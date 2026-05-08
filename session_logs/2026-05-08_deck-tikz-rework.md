# 2026-05-08 — Deck aesthetic pass: picture-focused slide 5, dot bullets, TikZ for text-heavy slides

## Goals

- Make slide 5 (LLM anatomy) picture-focused; remove the side text that was competing with the figure.
- Replace Beamer's default triangle item markers with dots — they read as smaller and cleaner at body size.
- For the deck's text-heavy slides, propose visual treatments (TikZ vs screenshot) and implement the TikZ ones in this session; defer screenshots until the user can capture them.
- Replace slide 22 ("Trust nothing you can't see") with something stronger than a list of failure anecdotes.

## Work completed

All uncommitted on `main`. Both files were already untracked from yesterday.

- Slide 5 redesigned — uncommitted, see `deck.qmd:44-52`. Two-column layout removed; figure centered with `width=0.7\textwidth, height=0.6\textheight, keepaspectratio`. Token footnote retained as the only auxiliary text.
- Bullet template override — uncommitted, see `assets/wehi/preamble.tex:60-64`. `\setbeamertemplate{itemize item}{\textbullet}` plus `$\circ$` and `$\ast$` for sub-levels.
- Five TikZ diagrams added — uncommitted, in `deck.qmd`:
  - Slide 7 (`The context window is the model's only memory`): membership diagram — solid teal buffer box with three in-items on the left, three faded grey-italic out-items on the right.
  - Slide 8 (`Training data has a freshness date`): horizontal timeline with orange dashed cutoff marker, teal "Today" marker, three labelled regions (seen / guesses / never seen).
  - Slide 18 (`Daily notes feed weekly reviews feed paper drafts`): three-stage staircase with solid teal forward arrows and dashed grey "Claude reads back" feedback arrows.
  - Slide 22 (`Sub-agents read; design docs persist; restart before drift`): main-session boxes (solid teal) with a sub-agent box (dashed grey) showing spawn → summary → die.
  - Slide 29 (`Six ways this goes wrong`): 2×3 card grid wrapped in `\resizebox{\textwidth}{!}{...}` to fit safely.
- Slide 22 (was `Trust nothing you can't see`) replaced — uncommitted, see `deck.qmd`. New title: `When it's confused, re-ground — don't argue`. 2×2 contrast diagram: vague prompt → plausible-wrong vs grounded prompt → verifiable, using the population-swap as the running example. Orange reserved for the "(silently swapped)" annotation.
- `quarto render` + 2 manual `xelatex` passes via `tinytex::xelatex` produce zero overfull/underfull warnings.

## Decisions and rationale

- **Slide 5 image sizing took four iterations** (0.86 → 0.78 → 0.72 → 0.7 `\textwidth`, plus a `height=0.6\textheight, keepaspectratio` constraint). The PNG is 1456×905 (aspect 1.61); at 0.86 of textwidth it overshot the frame's vertical budget by 62.7pt because the slide also has to host title, rule, footnote, and footer. Settled on the smallest constraint that gave a clean compile rather than the largest size that still fit.
- **Bullets as `\textbullet`, not the `circle` Beamer template.** `\setbeamertemplate{items}[circle]` exists but renders smaller hollow circles that read as "subitems" at body size. `\textbullet` is the standard solid dot a reader expects from a body bullet.
- **TikZ `step` style key collision was the documented gotcha.** First compile of the daily/weekly/paper diagram failed with `Package pgfkeys Error: The key '/tikz/step' requires a value`. `step` is a built-in pgf coordinate-arithmetic key; my `\tikzset{step/.style=...}` shadowed it. Renamed to `stage`. This is the exact failure the skill's "things to watch for" list calls out — confirmation that the gotchas section is load-bearing, not boilerplate.
- **Reserved orange for one element per visual slide.** Slide 7 uses no orange (the closing line `If it "forgot" — it never had it` is plain text). Slide 8 puts orange on the dashed cutoff marker (the freshness-date concept *is* the cutoff). Slide 27 puts orange on the `(silently swapped)` annotation (the moment of failure). Slides 18, 22, 29 use no orange — the diagrams carry the load themselves.
- **Slide 7 absent-items rendered as grey-italic, not orange Xs.** Three orange Xs would have violated the one-orange-per-slide rule and made the slide visually loud. Italic + grey signals "absent / faded" without competing for attention.
- **Did not split slide 22 (sub-agents) into two slides** despite it covering three ideas (sub-agent insulation, design docs, drift). User asked for visuals, not structural rewrite. The TikZ owns the sub-agent insulation idea; design docs and drift survive as a single small text line below. Re-evaluate at rehearsal — if the line gets glossed over, the design-doc point may need its own slide.
- **Slide 22 (now slide 27 in delivery) reframed from anecdote-list to mechanism-contrast.** User declined the screenshot option for the original "Trust nothing you can't see"; keeping it as bullets would have left it as the weakest slide in the verification cluster. The 2×2 contrast (vague vs grounded prompt → wrong vs correct output) shows the *mechanism* of under-specification rather than enumerating instances. Title rewrite was necessary because the new visual asserts an instruction, not a warning.
- **Slide 23 grid wrapped in `\resizebox`.** Six 4.4cm cards on a 3-column grid is 13.2cm before margins, just inside textwidth. Wrapping in `\resizebox{\textwidth}{!}{...}` gave a one-line guarantee against future content tweaks pushing it over.
- **Used `tikz_rules.md` measurement-first protocol.** Each diagram declared node dimensions explicitly, laid coordinates before edges, and kept x-range inside the ~14cm textwidth budget. Result: every diagram compiled correctly on first try except for the `step` key collision (which is a different failure class — name collision, not coordinate error).

## Surprises / things to flag

- **Slide 5 size compromise cost a pass each time.** The skill lists overfull-vbox fixes but doesn't suggest defaulting to `[width=X, height=Y, keepaspectratio]` for centred figures. Worth adding to the canonical template.
- **Slide 22 sub-agent diagram has two boxes labelled "Main session"** to convey the same session at two moments (8K → 9K tokens). Visually it could be misread as two separate sessions. Flagged in the handoff message; the three options for resolution (before/after labels, vertical time arrow, single growing box) are listed there.
- **Slide 27 contrast uses identical box dimensions for vague and grounded.** The grounded prompt is ~3× longer text-wise but the vague-prompt box has whitespace padding to match. Honest in spirit (both prompts get the same airtime visually) but a strict reading of "TikZ data integrity" from the skill's audit 2 would flag this — the box size doesn't encode prompt length. Letting it slide because the design intent is comparison-by-state, not comparison-by-volume.

## Open items / next steps

- [ ] User is capturing screenshots for slides 11 (`/mcp` listing), 12 (Plan-mode TDD on a real C9orf72 function), 14 (one slash command in action — likely `/meeting`), 17 (this repo's `CLAUDE.md` + skill listing). When they land in `figures/`, wire them in and recompile.
- [ ] Slide 22 (sub-agents): revisit the dual "Main session" labelling after a delivery rehearsal. The fix is small (add "before"/"after", or collapse to one box) but should be informed by which reading actually trips during delivery.
- [ ] Commit the deck artefacts. `deck.qmd`, `deck.pdf`, `assets/`, `figures/*.png`, `ACTIVITIES.md`, both session logs are still untracked. Pre-screenshot commit would isolate today's TikZ work from tomorrow's screenshot work in the history.
- [ ] Carryover from yesterday's log (still open): delivery rehearsal against section budgets; cross-check slides 25/26 read distinct at delivery speed; decide whether section 6 (Pitfalls, single content slide) earns its own divider; the unused Swarup `operon` find from the community-scouting log. Speaker-notes pass dropped — user not pursuing.
- [ ] Audit 2 ("Graphics") proper run via `/tikz <deck>.tex` — skipped this session because each diagram was visually inspected at render time and is conceptually simple. Should run before the screenshots land to keep the audits clean.

## Cross-references

- Continues from: `session_logs/2026-05-07_deck-build-and-audits.md` (the deck this builds on; yesterday's log lists most of the still-open carryover items).
- Source of truth: `OUTLINE.md`, `REFERENCES.md`.
- Skill invoked: `userSettings:beautiful-deck-quarto`.
- TikZ protocol applied: `~/.claude/skills/beautiful-deck-quarto/tikz_rules.md` (measurement-first; coordinate map before edges; built-in key collision gotcha confirmed).
- Brand pack: vendored at `assets/wehi/preamble.tex`; bullet override added at lines 60–64.
