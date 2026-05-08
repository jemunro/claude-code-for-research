# Lab activities — Claude Code talk (2026-05-12)

Pick one. Work in a small group (2–4) on something close to your own
research. The point isn't to finish — it's to feel where Claude Code
helps and where it gets in the way.

A few ground rules:

- Pair up so one person drives and one watches; swap halfway. The
  watcher catches confabulations the driver misses.
- Read the diff, every time. Never accept a "done" claim without
  looking at what changed.
- If you're using real data, make sure it isn't sensitive. Code-only
  workspaces are fine; UKB / GEL / clinical data directories are not.
- Don't fight a confused agent — re-ground it (point at a file, paste
  a spec, restate the goal) instead of arguing.

## Activity 1 — Bootstrap a `CLAUDE.md`

Open Claude Code in one of your existing analysis directories. Ask
it to summarise what's there, flag what's missing for reproducibility,
and propose a `CLAUDE.md`. Read its proposal critically — does it
capture *your* conventions, or generic ones? Edit, commit.

**Why this is useful.** `CLAUDE.md` is the single highest-leverage
artefact for working with Claude long-term. Doing it on a real
project means you walk out with something you'll keep using.

## Activity 2 — Onboard into an unfamiliar codebase

Pick a package or pipeline you've always meant to read but haven't
— `plyranges`, a Bioconductor package, a colleague's repo, a
nf-core pipeline. Get Claude to produce a 5-minute orientation:
what is this, what are the load-bearing files, what would I read
first to extend it.

**Why this is useful.** Codebase onboarding is one of the strongest
agentic-AI use cases. It also surfaces how much Claude can — and
cannot — infer without `CLAUDE.md` to anchor it.

## Activity 3 — Plan a hypothetical analysis end-to-end

Pick a research question you've been chewing on. Use plan mode
(or the `brainstorming` skill if installed) to draft an analysis
plan: data sources, cleaning steps, model, sanity checks, figures.
Don't run anything. Exercise the planning muscle and then read
the plan critically together — would you trust it?

**Why this is useful.** The cost of a bad turn in research isn't
wasted time — it's a wrong conclusion in a paper. Up-front planning
is where Claude is most valuable and least dangerous.

## Activity 4 — Capture a recurring task as a slash command

Pick something you do every week — literature scan, lab-meeting
minutes, code-review checklist, weekly summary email. Write it
as `.claude/commands/<name>.md` (a slash command) or as a skill
under `.claude/skills/<name>/SKILL.md`. Run it on a real task.

**Why this is useful.** Slash commands and skills are how casual
use turns into infrastructure. Ten minutes of authorship saves
an hour a week.

## Activity 5 — Try a research MCP server

Connect a research MCP server (bioRxiv, PubMed, Google Drive,
Gmail are first-party and free). Ask Claude to surface recent
papers in your area and draft a one-paragraph summary of the
two or three most relevant. Compare to a manual literature
search — what did it catch, what did it miss, what did it
fabricate?

**Why this is useful.** MCP servers are the lever that makes
Claude Code useful for research, not just code. They're also
the easiest place to get bitten by confabulation — perfect for
practising verification.

## Activity 6 — Manuscript-paragraph critique

Take a paragraph from a current draft (intro, discussion, or
abstract). Ask Claude to critique it as a sceptical reviewer.
Compare to your own read — where did it agree, where did it
disagree, where did it miss the point. Don't accept its edits
without rereading.

**Why this is useful.** Editing prose is one of the easier wins
and the easiest place for sycophancy to kick in. A good calibration
exercise: is this critique substantive, or is Claude just performing
helpfulness?
