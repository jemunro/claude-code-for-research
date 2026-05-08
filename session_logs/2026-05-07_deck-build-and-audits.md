# 2026-05-07 — Deck build, aesthetic pass, and audits

## Goals

- Build the `deck.qmd` for the 2026-05-12 lab meeting talk via `/beautiful-deck-quarto`, using `OUTLINE.md` as source-of-truth and the approved plan (`~/.claude/plans/read-outline-md-and-readme-md-graceful-meadow.md`) as scaffolding.
- Land a WEHI-themed deck that compiles cleanly to `deck.pdf` (referenced from `README.md` line 5) and runs ~25–30 min.
- Get the rhetoric, graphics, and so-what audits to actually clean — no "mostly clean".

## Work completed

All work uncommitted on `main`. The repo had no `assets/`, no `deck.*`, no `figures/*.png`, no `ACTIVITIES.md` at session start; everything created today.

- Wrote `ACTIVITIES.md` (six post-talk group activities) — uncommitted.
- Wrote `deck.qmd` — uncommitted, 34 slides across 8 sections + title + takeaway. Final structure: Foundations (5) → Web→agentic (3) → Vignettes (4) → Context (3) → Verification (4) → Pitfalls (1) → Lab policies (2) → On-ramp (1).
- Vendored a local copy of the WEHI brand pack to `assets/wehi/preamble.tex` so deck-specific template tweaks don't leak back into the skill — uncommitted.
- Converted `figures/llm-anatomy.webp` and `figures/context-engineering.webp` → PNG via ImageMagick (`magick -density 100`). XeLaTeX has no native webp loader.
- Added a token-as-subword-piece footnote on the anatomy slide (slide 5) — answers a question this audience has historically asked, without spending a full slide.

## Decisions and rationale

- **Title slide gradient via `background canvas`, not the title-page template.** First implementation drew the gradient inside `\setbeamertemplate{title page}` with a TikZ overlay. Rendered as a half-page band: `current page` overlay is bounded by the frame's content area when the frame is not `[plain]`. Moved to `\setbeamertemplate{background canvas}` with `\ifnum\thepage=1` guard. Background canvas is always full-page regardless of frame layout. The title-page template now owns text only.
- **Single TikZ node for the entire title block.** Author/date used to live in a separate node anchored at `current page.south west`. Long titles overflowed and the author block rode up into the subtitle. Consolidated into one `text width=0.85\paperwidth` node anchored north-west. Vertical layout cannot collide with itself by construction.
- **Title shortened to "Claude Code for research" / "Bahlo lab meeting".** First version was the takeaway sentence (`Claude Code is research infrastructure, not autocomplete`) at `\Huge`. Wrapped to three lines and collided with the author block. Took two text-width widenings (0.65 → 0.70 → 0.85) before deciding the right fix is to let slide 2 own the takeaway and let slide 1 be a name plate. Cost: a "boring" title slide. Benefit: the takeaway sentence lands harder when it's the *only* thing on slide 2.
- **Compiled with 4 xelatex passes (`quarto render` + 2 manual `tinytex::xelatex`).** `\inserttotalframenumber` writes to `.nav` on pass 1 and isn't read into the body until pass 2; section dividers using `current page` overlay also need the `.aux` populated. Quarto runs xelatex twice by default and that's not enough. Tried `pdf-engine-opt`/`latex-min-runs` in the YAML — Quarto rejects both keys ("invalid YAML"). Just running the extra passes by hand is fine.
- **Replaced the duplicate "Plan first, execute second" verification slide with a simulate-and-recover slide.** The earlier outline had two slides with near-identical titles in different sections; the second was redundant. The new slide promotes the simulation-as-verification idea from `~/.claude/CLAUDE.md` ("simulate data with known ground truth, run the pipeline, confirm it recovers the truth within tolerance"), which wasn't represented elsewhere.
- **Aggressive text-cut pass after first compile.** User: "too much text on slides, remove fluff". Cut 26/26 content slides — most slides went from 3–4 prose paragraphs to a 3–4 line list + one closing assertion. Removed the "One sentence to take home. The rest of the talk is evidence." subtitle from slide 2 (fluff that re-explained the takeaway in the act of presenting it). Removed all "Research infrastructure, not autocomplete" tagline repetitions inside the body.
- **Two assertion-title fixes after rhetoric audit.** Slide 15 (`TDD on the C9orf72 R/targets pipeline` → `TDD keeps the agent honest on the C9orf72 pipeline`) and slide 32 (`What we should ask of WEHI IT` → `Ask IT for an Enterprise tier and a deny-list`). Both were descriptive labels masquerading as titles.
- **Token explainer as a footnote, not a slide.** User asked whether to add a tokenisation slide because the audience has historically asked what a token represents. Pushed back on a generic "what is a token" slide (failed the so-what audit), offered (1) a memorable demo slide between slides 5–6 or (2) a calibrating footnote on the anatomy slide. User picked (2). Footnote: "A token is a subword piece — about three-quarters of a word, four characters on average. The context window is measured in tokens (Sonnet 4.6: 200K standard, 1M premium)."
- **`$\sim$` in the footnote rendered as a missing glyph in XeLaTeX + Georgia.** Switched to plain prose ("about three-quarters of a word") instead of `$\sim\!\!\frac{3}{4}$`. Same root cause as the unicode-arrow gotcha already documented in the skill.

## Surprises / things to flag

- **Don't use poppler.** User interrupted mid-tool-call when I tried `brew install poppler` to get `pdftoppm` for PDF page rendering. Switched to `magick -density 100 'deck.pdf[N]' /tmp/out.png` — ImageMagick was already installed and renders PDF pages directly. Saved as a feedback memory.
- **The Beamer footer multi-pass issue is undocumented in the skill.** The skill says "use tinytex via R, never system tlmgr" and notes `\inserttotalframenumber` needs a second pass — but Quarto's default 2 passes is *still* not enough for footer + section-divider TikZ overlay together. Worth adding to `tikz_rules.md` or the skill's "common fixes" table; flagging here so it lands in either place next time.
- **Rhetoric audit was the cheap one; aesthetics ate ~80% of the time.** The actual rhetoric pass found two title-as-label violations in 5 minutes. The bulk of the session went to title-slide layout, footer pass count, gradient bounds, text density. The skill's audit list is well-shaped, but the deck-aesthetics step before the audits is more iterative than the skill suggests.

## Open items / next steps

- [ ] Speaker-notes pass. The deck has no `notes:` blocks yet; would help on the verification cluster (slides 24–27) and lab-policy cluster (31–32). Deferred until I rehearse and find the seams.
- [ ] Delivery rehearsal against the section budgets in the plan. The 8-section / 27-min budget assumes ~3.4 min per section; the foundations cluster (5 slides) and the verification cluster (4 slides) are the most likely to overrun.
- [ ] Cross-check the simulate-and-recover slide (slide 26) reads as distinct from "Read the diff" (slide 25) at delivery speed. They're related but the simulate slide is the only place the cross-software-replication-substitute argument lives.
- [ ] Decide whether section 6 (Pitfalls, single content slide) earns its own divider. Kept for cadence; flag to revisit during rehearsal.
- [ ] `OUTLINE.md` line 74 to-do was already ticked in the earlier scouting log, but the deck doesn't include a "what others in our field are doing" slide (per plan decision #3). The Swarup `operon` find from the prior log is unused. Deferred by choice — the plan said skip — but worth re-examining if a section runs short.
- [ ] Commit the deck artefacts. Currently everything (`deck.qmd`, `assets/`, `figures/*.png`, `ACTIVITIES.md`, both session logs) is untracked. Pre-rehearsal commit would be a natural break.

## Cross-references

- Plan: `~/.claude/plans/read-outline-md-and-readme-md-graceful-meadow.md`
- Continues from: `session_logs/2026-05-07_community-scouting.md` (same day, distinct topic — that log scouted references; this one builds the deck)
- Source of truth: `OUTLINE.md`, `REFERENCES.md`, `ACTIVITIES.md`
- Skill invoked: `userSettings:beautiful-deck-quarto`
- Brand pack: vendored copy at `assets/wehi/preamble.tex`; upstream is `~/.claude/skills/beautiful-deck-quarto/assets/wehi/`
