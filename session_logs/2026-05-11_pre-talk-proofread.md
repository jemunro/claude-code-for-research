# 2026-05-11 — Pre-talk proofread of `deck.qmd` and `ACTIVITIES.md`

## Goals

- Final proofreading pass on `deck.qmd` and `ACTIVITIES.md` before tomorrow's lab meeting.
- Catch spelling, grammar, repeated phrasing, factual / logical errors, weak arguments, and broken/placeholder links.
- Apply low-risk fixes (typos, grammar) directly; flag higher-stakes changes (factual reframes, rhetorical strengthening) for the user.

## Work completed

- Proofreading pass delivered in conversation — not on disk; categorised into typos, grammar, factual, weak-argument, and link issues for both files.
- Typo / grammar fixes applied to `ACTIVITIES.md` — uncommitted, see `ACTIVITIES.md`:
  - Comma splice → semicolon in the `/compact` ground-rule bullet (line 11).
  - Activity 2 (line 27): split ambiguous "Don't run anything and then read the plan" into two clauses.
  - Activity 2 (line 30): `claude` → `Claude`, `biorXiv` → `bioRxiv`, `pubmed` → `PubMed`, `try and combine` → `try to combine`, comma splice → full stop.
  - Activity 3 (line 39): `claude` → `Claude`, `it's` → `its`, comma splice → semicolon.
  - Activity 5 (line 53): hyphen → em dash to match other section headings; `pdf` → `PDF`; `it's readings` → `its readings`; `4 page chunks` → `4-page chunks`.
- `/compact` link in `ACTIVITIES.md` swapped from a third-party gist to the canonical Anthropic docs anchor `https://code.claude.com/docs/en/context-window#what-survives-compaction` — uncommitted.
- Verified `https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices` (Activity 3) resolves and is the live canonical page; left as-is.

### Follow-up — edit pass (same day)

After the proofread, applied the deck fixes the proofread flagged plus several substantive changes the audit surfaced — `deck.qmd` modifications uncommitted at time of writing:

- New slide `Claude Code, concretely` inserted at `deck.qmd:141-159`, between the `In a web chat...` framing and the `An agent reads files...` loop slide. Addresses two audience gaps: model-and-when (Sonnet 4.6 / Opus 4.7), and that Claude Code isn't the only harness (Codex, Gemini CLI, OpenCode).
- Section header rename: `# Lab policies` → `# Working with sensitive data` (`deck.qmd:451`).
- Section header rename: `# Web chat to agentic` → `# From web to the command line` (`deck.qmd:127`).
- Slide 32 replaced — old text `Ask IT for an Enterprise tier and a deny-list` swapped for `Local models on the HPC unlock controlled-data work` (Qwen-family path forward; `deck.qmd:483-495`). ZDR footnote restored at `deck.qmd:495`.
- Slide 31 (data egress): removed `GEL` from the `Not fine` bullet (`deck.qmd:471`); punchline rephrased to `It's not where the agent runs --- it's what data leaves our networks` (`deck.qmd:481`); title → `Data egress is the constraint --- not where the code runs` (`deck.qmd:453`); user later trimmed in IDE to `Data egress is the constraint` to drop the line wrap.
- Slide 5 ("Confident wrong answers") softened: `Without tools, it generates fluent text --- not retrieved facts` (`deck.qmd:56`).
- Slide 8 retitled: `Grounding turns guesses into answers we can check` (`deck.qmd:119`).
- Pitfalls card renamed: `Over-reliance / risky for students mid-training` → `Outsourced judgment / uses what you can't verify` (`deck.qmd:446`).
- Slide 13 (MCP): `The lever` → `A lever` (`deck.qmd:204`).
- Slide 15 (TDD intro): `makes agents write reliable code` → `gives agents a target you can check` (`deck.qmd:213`).
- Slide 18 (paper-archive): named the archive — `My notes/ directory is just markdown` (`deck.qmd:297`).
- Slide 20 (context bottleneck): dropped folklore claim `Near the limit, performance degrades` (`deck.qmd:309`).
- Slide 22 (sub-agents): narrowed title to `Sub-agents read so the main session doesn't have to` (`deck.qmd:334`); added `before` / `after` labels to the two `Main session` boxes (`deck.qmd:347-348`); drift defined inline in the footer (`deck.qmd:361`).
- Slide 16 RED block: rewrote to test boolean classification directly, then rolled back to the original Table-1 format check — see *Decisions* below.

PDF renders to 35 pages, zero LaTeX box warnings. ACTIVITIES.md proofread fixes and a separate README expansion were committed during the compacted session as `b18f24a docs: more comprehensive activities and readme`.

## Decisions and rationale

- **Did not edit `deck.qmd`.** User asked for proofreading only on this pass. The deck issues that warrant changes (see *Surprises*) were flagged in the conversation; user can decide tonight which to apply before delivery. Slide-content edits the day before a talk are higher-risk than text fixes — better surfaced than silently rewritten.
- **`/compact` link → `context-window#what-survives-compaction`, not `/commands`.** The activities bullet is teaching context hygiene, not command syntax. The context-window page actually explains *what compaction does to the buffer*, which is the load-bearing concept; the commands reference just names the command. Picked the page that matches the pedagogical intent of the bullet.
- **Did not touch `README.md`.** It is also uncommitted (`+7/-1` lines: a `## Stuart Lee 2026-05-12` header and an `## Installing Claude Code` section pointing to `code.claude.com/docs/en/quickstart`). These look like user-authored edits made outside this conversation. Flagging rather than touching.
- **Capitalisation rule for `bioRxiv` / `PubMed` taken from the deck (line 177).** The deck already standardises these forms; ACTIVITIES.md should match for delivery consistency. `Claude` capitalisation is just standard product-name treatment.

### Added in the edit pass

- **Reversal of prior decision on slide 22.** The 2026-05-08 log explicitly kept slide 22 as one slide making three claims (sub-agent insulation, design docs persist, restart before drift) while the diagram only carried the first; the call there was "user asked for visuals, not structural rewrite". This session reversed that. The new title matches what the visual asserts; design docs and drift live in the footer where drift is now defined inline. The rhetoric audit pushed harder on title-as-assertion than the previous pass had.
- **TDD RED block: rewrite then rollback.** The audit flagged the original RED as testing a *format consequence* (carrier count `"^3 \\("` in Table 1's incident row) rather than the case definition itself. User accepted a rewrite that asserted `cohort$incident_neuro` directly on `eid==1` and `eid==3`. On render review the GREEN block in the same slide is the body of `format_incident_row()` — the *table-row formatter*, not the classifier — so the two halves of the slide ended up at different layers. Rolled back to the original RED; both halves now coherent at the formatter layer. Delivery line agreed: *"the test pins the carrier count in Table 1's incident row — three carriers — and that flushed out the formatter using the wrong age column."* Honest about scope without TDD purity overclaim.
- **Slide 17 column overflow during the RED rewrite.** Short-lived: the new RED's fixture comments overran the 49% column width at scriptsize. Fixed by shortening the comments; moot after rollback.
- **Kept slide 2 (`Three threads today`).** Audit flagged it as a roadmap-failure-mode candidate per the Rhetoric of Decks. Overruled for this delivery: teaching session, mixed-experience audience, the map earns its place.
- **Slide 31 title wrap.** First fix (`Data egress is the constraint --- not where the code runs`) wrapped with `runs` as a single-word orphan on line 2. User trimmed to `Data egress is the constraint` in IDE — dropping the contrast clause entirely fits on one line and the punchline at `deck.qmd:481` (`it's not where the agent runs --- it's what data leaves our networks`) carries the same load.

## Surprises / things to flag

These are deck issues identified in the proofread but **not changed**. Worth a decision before tomorrow:

- **Factual / dating:**
  - `deck.qmd:52` cites `Sonnet 4.6: 200K standard, 1M premium`. The speaker is on Opus 4.7 (also 1M). Either generalise or update — the named model dates the slide.
  - `deck.qmd:173–178` claims PubMed and bioRxiv MCP servers are "First-party, free". Both are community plugins (PubMed was just installed in this session as `plugin_pubmed_PubMed`), not Anthropic first-party. Drive/Gmail/Calendar are first-party Anthropic integrations to Google products. The "First-party" framing is ambiguous at best; suggested rephrase: *"Built-in integrations / available plugins, free to use:"*.
  - `deck.qmd:473` says "try this Monday" — talk is Tuesday 2026-05-12, so "this Monday" parses as either yesterday or next Monday. Suggested: "try this next week".

- **Weak / strengthenable arguments (none changed):**
  - `deck.qmd:54–60` ("Confident wrong answers"): "Not looking up facts. Generating fluent text." overstates — Claude *does* look things up when given tools. Suggested tightening: *"Without tools, it generates fluent text — not retrieved facts."*
  - `deck.qmd:119` "Grounding turns guessing into reasoning" — *reasoning* is contested terminology in this audience. Suggested: *"…into something verifiable."*
  - `deck.qmd:412–427`: the "Over-reliance — risky for students mid-training" pitfall card names a *population*; the other five name *failure modes*. Suggested: rename to a failure mode (*"Skips the learning step"* / *"Outsources judgment before forming it"*).
  - `deck.qmd:463–469`: the punchline ("laptops ✓, code-only HPC ✓, controlled data off-limits") is buried as a caption beneath the `block`. That is the line the lab will repeat — promote it to the main visual element.

- **Repeated terms (intentional but worth pacing in delivery):** "Read the diff" appears on `deck.qmd:193` and `deck.qmd:354`. Either acknowledge the callback at line 354 or reduce one to a glance.

- **No empty / placeholder links** in either file.

## Open items / next steps

Resolved this session:

- [x] Commit `ACTIVITIES.md` fixes — landed in `b18f24a` (alongside README expansion).
- [x] Deck fixes flagged in proofread (Sonnet 4.6 reference, First-party MCP framing, "this Monday") — superseded; the proofread-flagged lines no longer exist in current `deck.qmd`. The Sonnet 4.6 footnote was replaced by an Opus 4.7 / Team plan line at `deck.qmd:52` (1M, corrected this session).
- [x] Slide 32 punchline buried as caption — moot; old slide 32 replaced entirely.
- [x] Slide 22 dual-`Main session` labelling — resolved with `before` / `after` modifiers.

Still open:

- [x] Verify `deck.qmd:52` footnote — corrected. Opus 4.7 on the Team plan is **1M**, not 200K; updated in-line.
- [x] Screenshots for slides 11 / 12 / 14 / 17 (carryover from 2026-05-08) — landed; placeholders cleared.
- [ ] Rehearsal pass. Slide 11 (`Claude Code, concretely`) is the densest in the deck — paragraph + 3 bullets + Models line + harness footnote. The harness footnote is the easiest verbal cut if it feels slow.

## Cross-references

- Continues from `session_logs/2026-05-08_deck-tikz-rework.md` (the deck artefacts this proofread covers).
- Source of truth: `deck.qmd`, `ACTIVITIES.md`, `OUTLINE.md`.
- Canonical `/compact` reference now linked from `ACTIVITIES.md`: `https://code.claude.com/docs/en/context-window#what-survives-compaction`.
