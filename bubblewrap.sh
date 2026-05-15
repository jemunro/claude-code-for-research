#!/bin/bash
#
# bubblewrap.sh — launch a sandboxed login shell using bwrap
#
# Wraps a login shell in a bubblewrap sandbox to isolate processes (e.g.
# VSCode remote, Claude CLI, other agents) from most of the shared HPC
# filesystem. The sandbox:
#   - allows full read/write access to /vast/home (user home directories)
#   - allows read/write access to a private tmp dir on scratch
#   - blocks all other /vast and most /stornext volumes via empty tmpfs overlays
#   - retains access to /stornext/Home and /stornext/System (modules, tools)
#
# Can be used as an SSH RemoteCommand to sandbox anything that connects
# over SSH, e.g. in ~/.ssh/config:
#   Host <hostname>
#     RemoteCommand ~/bin/bubblewrap.sh
#     RequestTTY no

# Real scratch-backed tmp dir; visible inside sandbox at .../tmp/
SCRATCH_TMP="/vast/scratch/users/${USER}/tmp/bwrap_tmp"
mkdir -p "$SCRATCH_TMP"

# bwrap creates a new user namespace so winbind can't resolve UIDs — inject
# the user's passwd/group entries so getpwuid works via files lookup instead.
# Built in-memory via process substitution (no temp files written to disk).
# Group members are replaced with just $USER to avoid leaking other usernames.
exec {PASSWD_FD}< <(cat /etc/passwd; getent passwd "$USER")
exec {GROUP_FD}< <(cat /etc/group; id -G | tr ' ' '\n' | xargs -I{} getent group {} | sed -E "s/^([^:]*:[^:]*:[^:]*:).*/\1${USER}/")

exec bwrap \
  --bind / /        `# bind entire host root into sandbox` \
  --dev /dev        `# replace bound /dev with a fresh devtmpfs (fixes /dev/null perms in user namespace)` \
  --symlink /run/systemd/journal/dev-log /dev/log  `# restore syslog socket symlink absent from fresh devtmpfs` \
  --die-with-parent `# kill sandbox if parent process (e.g. SSH) dies` \
  --tmpfs /etc/ssh/ssh_config.d `# hide drop-ins: root-owned files appear as nobody in user namespace, causing ssh to reject them` \
  \
  `# --- block /vast volumes except /vast/home ---` \
  --tmpfs /vast/cryoem \
  --tmpfs /vast/imaging \
  --tmpfs /vast/ai_projects \
  --tmpfs /vast/projects \
  --tmpfs /vast/scratch \
  --bind "$SCRATCH_TMP" "/vast/scratch/users/${USER}/tmp" `# expose only private tmp dir on scratch` \
  \
  `# --- block /stornext volumes except Home and System ---` \
  --tmpfs /stornext/Archive \
  --tmpfs /stornext/Bioinf \
  --tmpfs /stornext/General \
  --tmpfs /stornext/Genomics \
  --tmpfs /stornext/ImageData \
  --tmpfs /stornext/Img \
  --tmpfs /stornext/Projects \
  --tmpfs /stornext/SBPM \
  --tmpfs /stornext/Sysbio \
  \
  `# --- inject user identity files so getpwuid resolves without winbind ---` \
  --ro-bind-data "$PASSWD_FD" /etc/passwd \
  --ro-bind-data "$GROUP_FD" /etc/group \
  --setenv USER "${USER}" \
  \
  -- "${SHELL:-bash}" --login
