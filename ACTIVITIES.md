# Potential Activities — Claude Code talk (2026-05-12)

Work in a small group (2–4) on something close to your own
research or that's of interest to you. The best way to learn is to just try it out on a problem or question and see where it goes well and where it goes wrong!


- Pair up so one person drives and one watches; swap halfway. 
- If you're using git, make sure to read the diff, every time. Never accept a "done" claim without
  looking at what changed.
- If you're using real data, make sure it isn't sensitive. I'd recommend grabbing a paper's data or supplementary table to work from.
- Don't fight a confused agent; ask it what context it needs to help you get where you want to go. Make liberal use of [`/compact`](https://code.claude.com/docs/en/context-window#what-survives-compaction) to summarise the current state and free up context.


## Activity 1 — Onboard into an unfamiliar codebase

Pick a package or pipeline you've always meant to read but haven't
— `plyranges`, a Bioconductor package, a colleague's repo, a
nf-core pipeline. Get Claude to produce a 5-minute orientation:
what is this, what are the important files, what would I read
first to extend it.

Try repeating this task after you've created a `CLAUDE.md` stating your goals and see how the response changes.

## Activity 2 — Plan a hypothetical analysis end-to-end

Pick a research question you've been thinking about. Use plan mode (shift + tab) to draft an analysis
plan: data sources, cleaning steps, model, sanity checks, figures. Don't run anything — then read
the plan critically together with your group. Would you trust it?

Repeat this activity after giving Claude more context (some background reading material perhaps, or a grant you've written). Is the plan better or worse? You could try to combine this with an MCP server available for Claude like bioRxiv or PubMed and try again.

## Activity 3 — Capture a recurring task as a slash command

Pick something you do every week — literature scan, lab-meeting
minutes, code-review checklist, weekly summary email. Write it
as `.claude/commands/<name>.md` (a slash command) or as a skill
under `.claude/skills/<name>/SKILL.md`. Run it on a real task.

Note that Claude can help you here; it has access to its own [documentation](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).

## Activity 4 — Manuscript-paragraph critique

Take a paragraph from a current draft (intro, discussion, or
abstract). Ask Claude to critique it as a sceptical reviewer.
Compare to your own read — where did it agree, where did it
disagree, where did it miss the point. Don't accept its edits
without rereading.

A calibration
exercise: is this critique substantive, or is Claude just performing
helpfulness?

## Activity 5 — Transform a paper into a slide deck or interactive web app

Download (or ask Claude to) a paper you've worked on or a paper you've not gotten around to reading. Ask Claude to read the paper (if it's a PDF) in 4-page chunks, summarising what it has read at each stage and then finally collating a markdown file of the entire paper. Ask it to build a beautiful slide deck or an interactive application from its readings, using your preferred programming language to recreate the key figures and tables from the paper. How did it go? Go back later and read the paper (if it wasn't your own work) to see what's missing. How could you improve it for next time?
