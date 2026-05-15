# Sandboxing Claude (and other agents) on the HPC

When you run Claude Code or any other AI agent on the HPC, the agent inherits your full filesystem access. That means a runaway tool call, a confused prompt, or a prompt-injection attack in a file the agent reads could silently traverse project directories you didn't intend to expose.

The fix is [bubblewrap](https://github.com/containers/bubblewrap) (`bwrap`), a lightweight Linux sandboxing tool available on most HPC systems. It creates a new user namespace and remounts selected paths, so the agent can only see what you explicitly allow.

## What the sandbox does

`~/bin/bubblewrap.sh` wraps a login shell in a `bwrap` sandbox that:

| Path | Access |
|------|--------|
| `/vast/home/` (all users' home dirs) | Read/write |
| `/stornext/Home/` (all users' home dirs) | Read/write |
| `/stornext/System/` (modules, tools) | Read |
| `/vast/scratch/users/$USER/tmp/` | Read/write (private scratch tmp only) |
| Other `/vast/` volumes (`cryoem`, `imaging`, `ai_projects`, `projects`, `scratch`, …) | Blocked (empty tmpfs) |
| Other `/stornext/` volumes (`Bioinf`, `General`, `Genomics`, `Projects`, `SBPM`, …) | Blocked (empty tmpfs) |

Both `/vast/home` and `/stornext/Home` are accessible — the HPC is mid-migration and home directories may live on either volume.

The script also injects your `/etc/passwd` and `/etc/group` entries directly into the sandbox so that `getpwuid` resolves without `winbind` (which is inaccessible inside a user namespace).

## Setup

The script is included in this repo as [`bubblewrap.sh`](bubblewrap.sh). Copy it to `~/bin/` on the HPC and make it executable:

```bash
mkdir -p ~/bin
cp bubblewrap.sh ~/bin/bubblewrap.sh
chmod +x ~/bin/bubblewrap.sh
```

If `~/bin` is not already on your `$PATH`, add it to your `~/.bashrc`:

```bash
export PATH="$HOME/bin:$PATH"
```

## Option 1 — VSCode Remote SSH

The cleanest approach for day-to-day use. Add a second SSH host entry to your config that runs `bubblewrap.sh` as the `RemoteCommand`. VSCode connects to that host and every process it spawns — terminals, extensions, Claude Code — runs inside the sandbox.

Use a **different login node** for the sandboxed host so that VSCode's multiplexed SSH sessions don't accidentally attach to an existing unsandboxed session on the same node.

### SSH config

**macOS / Linux** — edit `~/.ssh/config`

**Windows** — edit `C:\Users\<YourUsername>\.ssh\config`  
(If the file doesn't exist, create it. OpenSSH ships with Windows 10+ and is used automatically by the VSCode Remote SSH extension.)

Add both stanzas — keep your normal login entry and add the sandboxed one below it:

```sshconfig
# Normal HPC login (full filesystem access)
Host slurm-login03
    HostName slurm-login03.hpc.wehi.edu.au
    User <your-username>

# Sandboxed login — use this host when running agents
# Different node so VSCode doesn't reuse an existing unsandboxed session
Host slurm-sandbox
    HostName slurm-login02.hpc.wehi.edu.au
    User <your-username>
    RemoteCommand /vast/home/users/<your-username>/bin/bubblewrap.sh
```

Replace `<your-username>` with your HPC username (e.g. `smith.a`). If your home directory is on `/stornext/Home`, adjust the `RemoteCommand` path accordingly.

### Connecting from VSCode

1. Install the **Remote - SSH** extension (`ms-vscode-remote.remote-ssh`) if you haven't already.
2. Open the Command Palette (`Ctrl+Shift+P` on Windows/Linux, `Cmd+Shift+P` on macOS`) → **Remote-SSH: Connect to Host…**
3. Select `slurm-sandbox`.
4. VSCode opens a new window connected to the sandboxed shell. Open your project folder from there.

Any terminal you open in that window, and any Claude Code session you launch from it, runs inside the sandbox.

> **Tip — proxy jump / SSH agent forwarding**: if your site requires a jump host or SSH agent forwarding, add `ForwardAgent yes` and `ProxyJump <jumphost>` to the `slurm-sandbox` stanza. The `RemoteCommand` still runs on the final destination.

## Option 2 — CLI agents directly

If you SSH in normally (or are already on a login node) you can launch the sandbox by hand and then start your agent inside it:

```bash
# Drop into a sandboxed login shell
~/bin/bubblewrap.sh

# Now launch Claude Code (or any other agent) — it runs inside the sandbox
claude
```


## Compatibility

Most things work normally inside the sandbox. The shell, modules (`module load`), tools installed in `/stornext/System/`, conda/mamba environments in your home, R and Python packages, and anything else under your home directory all behave as expected.

What won't work is software installed on a blocked volume. The most common case is a shared conda environment or a compiled tool stored under a project directory on `/vast/projects/` or `/stornext/Bioinf/` — those paths appear empty inside the sandbox. If you hit a "command not found" or missing library error that works fine outside the sandbox, check whether the software lives on a blocked volume and use the options below to expose it.

## Adjusting what the sandbox allows

The blocked volumes are hardcoded in `bubblewrap.sh`. To expose a specific path, add a `--bind` line to `bubblewrap.sh` *after* the corresponding `--tmpfs` line — the later bind overrides the tmpfs for that specific path:

```bash
--tmpfs /stornext/Bioinf \
--bind /stornext/Bioinf/myproject /stornext/Bioinf/myproject \
```

## What the sandbox does *not* protect against

- **Network access** — the agent can still make outbound HTTP/S requests (e.g. to the Claude API, to GitHub). 
- **Files in your home directory** — everything under your home is readable and writable. The intended pattern is source code and scripts in home, data on project volumes behind existing access controls. Best practice is to keep data off home entirely — and large datasets won't fit there anyway, so the sandbox gives you the strongest protection where it counts most.
- **Writes within the sandbox** — the agent can still write anywhere it can read. Keep work in a project subdirectory and tell Claude in `CLAUDE.md` not to write outside it.

The sandbox is a defence-in-depth measure, not a substitute for careful prompting and review of what the agent does.
