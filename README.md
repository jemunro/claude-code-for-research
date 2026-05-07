# Claude Code for Bioinformatics / Statistical Genetics

This repository has two jobs:

1. Source for a Bahlo lab meeting talk on 2026-05-12 on using Claude Code for research — see [deck.pdf](deck.pdf).
2. A worked example. This repo follows the conventions described below — `CLAUDE.md`, `.claude/`, `session_logs/`, `` are all real files you can fork and adapt.
3. The best way to learn is to try it out on something that you are curious about!

## Directory setup

A handful of files and folders show up in almost every project I run with 
Claude Code.  You don't necessarily need any of them but I find they help turn it from just coding autocomplete into an active collaborator. 

### `CLAUDE.md` — persistent project memory

`CLAUDE.md` is a plain markdown file in your project root that Claude reads into context at the start of every session. It is the project's contract for delegating
to claude. It should be short, opinionated, things that would surprise a new collaborator if they didn't already know.

What I put in it:

- **What this project is** in one or two sentences.
- **Conventions I want followed** — package style, test commands, naming.
- **Vocabulary** — domain-specific terms, gene names, who-is-who.
- **Anti-patterns specific to this project** — "don't copy data here", "never use pandas".
- **Pointers to authoritative files** — "see `OUTLINE.md` for talk scope, `session_logs/` for state".

What shouldn't go in:

- Long architectural prose. That belongs in design docs that Claude reads on demand.
- Anything Claude can derive from the code using it's `Bash` tool — file paths, function signatures, conventions visible in the repo.
- Status updates. Those go in session logs.

`CLAUDE.md` is **always loaded**, so every byte costs you context. Aim for under 100 lines.

There are three scopes that get concatenated: a global one at `~/.claude/CLAUDE.md` for personal preferences (mine tells it who I am, what I do and how I want claude to act); a project-level one at the repo root; and a parent-directory one (e.g. `~/projects/CLAUDE.md`) for things shared across related projects.

If you use other LLM harnesses, the `CLAUDE.md` file is called `AGENTS.md`
by pretty much everyone else.

### `.claude/` — project-specific tooling

The hidden `.claude/` directory holds anything beyond simple instructions:

- `.claude/skills/` — project-specific skills. A skill is a folder with a `SKILL.md` describing a reusable workflow ("how I review a PR in this repo", "how I bump a package version"). Claude loads these on demand, so they don't cost main-context.
- `.claude/commands/` — slash commands. A file at `.claude/commands/check.md` becomes `/check` in the session. Use these for repeatable multi-step actions you want at your fingertips.
- `.claude/agents/` — sub-agent definitions. A sub-agent is a child Claude with its own system prompt and tool set; useful for read-heavy tasks (e.g. exploring an unfamiliar codebase) that you don't want eating your main context.
- `.claude/settings.json` — committed settings: permissions, hook config, MCP servers, model defaults.
- `.claude/settings.local.json` — gitignored personal overrides.
- `.claude/hooks/` — shell scripts triggered on events (e.g. auto-format on file write, log on session start).

You don't need to worry about any of this on first use. Eventually you start integrating each aspect as you use it more, depending on what you find useful.
I generally try to keep things pretty simple.  

### `session_logs/` — my own convention, not Claude's

Claude has no memory between sessions. To compensate I keep `session_logs/YYYY-MM-DD_<topic>.md` files describing what we did, what surprised us, and what's still open. At session start, Claude reads the most recent one and we pick up from there.

This is *the* most load-bearing piece of infrastructure I have. It costs five minutes at the end of a session and saves an hour at the start of the next one.

### Other useful artefacts

None of these are Claude-specific, but each makes Claude more useful:

- `PLAN.md` or `plans/` — durable design docs for multi-session work.
- `OUTLINE.md`, `SPEC.md`, `REFERENCES.md` — project artefacts that compress decisions into something Claude can reread instead of you re-explaining.
- `figures/` — render outputs once, reference them from reports and decks rather than copying.

### What this looks like in this repo

```
claude-code-tutorial/
├── CLAUDE.md          # project constitution (short, opinionated)
├── OUTLINE.md         # talk content — the source of truth
├── REFERENCES.md      # full reference notes, longer than the talk
├── README.md          # what you're reading
├── figures/           # rendered figures, referenced from the deck
├── session_logs/      # working memory between sessions
└── .claude/           # project skills, commands, settings (grows over time)
```

If you fork this repo as a starting point, those are the files to carry across.

## Project setup for data analysis

Here's how I'd lay out a fresh data analysis project. The skeleton is language-agnostic; I've called out R- and Python-flavoured specialisations where they matter. This is what works for me, not meant to be prescriptive. 

### The skeleton

```
my-analysis/
├── CLAUDE.md                      # short, project-specific instructions
├── README.md                      # human-facing overview
├── .claude/                       # skills, commands, settings
├── session_logs/                  # YYYY-MM-DD_<topic>.md
├── plans/                         # Analysis plans
├── data/
│   ├── raw/                       # read-only, never edited by hand
│   ├── processed/                 # outputs of the cleaning pipeline
│   └── derived/                   # one-off datasets for figures/tables
├── R/  or  src/<package>/         # functions
├── tests/                         # tests, mirroring the function tree
├── _targets.R  or  Makefile       # the pipeline entry point
├── reports/                       # Quarto manuscripts, supplementary docs
├── figures/                       # rendered figures
└── DESCRIPTION  or  pyproject.toml
```

Analysis language specialisations:

- **R-targets pipeline** — `_targets.R` at the root, functions in `R/`, tests in `tests/testthat/`. This is what I use for UKB-RAP pipeline. 
- **Python `uv` project** — `pyproject.toml` at the root, code in `src/<package>/`, tests in `tests/`. A `Makefile` or `noxfile.py` drives the analysis. Notebooks live in `notebooks/` but never as the source of truth — they're scratchpads, the canonical pipeline is in `src/`.

A lot of this is just a refit of the cookie-cutter-data

Adapt as you see fit. I am assuming this set up happens once you have summarised sequencing data or the output of a nextflow pipeline.

### Where data lives

1. **`data/raw/` is read-only.** If a downstream step needs to mutate something, it writes to `data/processed/`. Claude is told this in `CLAUDE.md`.
2. **Reference canonical paths, never copy.** Same for figures: render once into `figures/`, reference from anywhere. For R specifically make use of the `here` package. 
3. **Sensitive data stays out of the repo entirely.** Code-only repos are fine, but the data lives elsewhere on the HPC behind the same access controls as before. Don't point a Claude session at a directory that contains controlled data!

### How I use claude?

- **Planning** — Pre specify analyses or design of R functions with claude, save the output as a plan. You can also get claude to interview you for what you want.
I find planning first makes sure that things don't go a awry.  
- **Implementation** — TDD on package code (`/r-package-tdd`), simulation-based verification on pipeline steps.
- **Reporting** — I have a `/beautiful-deck-quarto` skill that help me turn analysis reports or written scripts into slide decks.
- **Memory** — `session_logs/` updated at the end of every non-trivial session.
- **Verification** — Claude reads the diff, runs the test, renders the figure, *before* saying "done". Git becomes very important here, to roll back 


## Reference Material

Here's a non-exhaustive list of material I have found useful for understanding how to integrate Claude into research work. 

- [Paul Goldsmith-Pinkham — "Getting started with Claude Code"](https://paulgp.substack.com/p/getting-started-with-claude-code): This series of posts is helpful in framing how Agentic AI could be useful for research work tasks.  
- [Scott Cunningham — MixtapeTools repo](https://github.com/scunning1975/MixtapeTools): Scott Cunningham is an econometrics/economics professor, a lot of the ideas he proposes here are transferable to other fields. His [substack](https://causalinf.substack.com/s/claude-code?utm_source=substack&utm_medium=menu) is also really good.
- [How Boris uses Claude Code](https://howborisusesclaudecode.com/): Details about how the creator of Claude Code uses it for software development. Lots of tips and tricks. 
- [Claude Blattman · AI for Professionals Who Don't Code](https://claudeblattman.com/): An intricate workflow system for managing research projects, email, meetings, and teams using Claude Code. Lots of neat suggestions and guides. 
- [Anthropic Skilljar](https://anthropic.skilljar.com/): interactive courses for using Claude written by Anthropic
- [Claude for Life Sciences](https://github.com/anthropics/life-sciences) I have not used this much but it looks potentially useful. A suite of skills and plugins for biology / bioinformatics work.