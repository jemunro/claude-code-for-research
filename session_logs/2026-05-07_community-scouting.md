# 2026-05-07 — Stat-gen / bioinformatics community scouting

## Goals

Tick the open `OUTLINE.md` to-do (line 74): scout how stat-gen / bioinformatics researchers — *outside the foundation-model crowd* — are publicly using Claude Code (blogs, GitHub, Bluesky, lab writeups). Gap itself is informative: if the field is silent, that's a talking point.

## Work completed

- Dispatched a research subagent across blogs, GitHub, Bluesky-via-Google, Reddit, and named stat-gen labs.
- Verified the four highest-stakes leads directly (WebFetch / `gh api`) before adding to references — this matters because a fabricated citation in front of the lab would be expensive.
  - Naughton (Boolean Biotech, Dec 2025) — verified.
  - Bayer "Naur for LLMs" (Aug 2025) — verified; noted he doesn't *explicitly* self-identify as bioinformatician on-page (caveated in REFERENCES.md).
  - Saera Vila (Love, DNA & Code, Feb 2026) — verified; self-identifies.
  - Mineault (neuroai.science, Jan 2026) — verified; gray-zone (neuroAI more than wet bioinformatics), kept for the failure-modes/calibration angle.
  - Swarup lab `swaruplab/operon` repo — verified via `gh repo view`; created 2026-03-26, public, "AI-powered IDE for bioinformatics — built by biologists, for biologists".
  - nf-core CLAUDE.md commits — verified via GitHub code search: 8 distinct repos (`cellpainting`, `strict-syntax-health`, `ops`, `hackathon-infra`, `slackbot`, `vale`, `nf-core-utils`, `stats`).
  - `wolf5996/agentic-skills` — verified; *scout had the repo name wrong* (called it `claude-skills`). Real name is `agentic-skills`. Tool-agnostic (ships both `CLAUDE.md` and `CODEX.md`). Skills covered: R-package dev, Quarto, scientific writing, R-code, analysis-project conventions.
- Wrote a new section in `REFERENCES.md` § "Stat-gen / bioinformatics community scouting (May 2026)" inserted before the "Verification & evaluation" section, with the seven entries above and an explicit gap assessment.
- Ticked OUTLINE.md line 74; added pointer to the REFERENCES.md section.

## Decisions and rationale

- **Verify before citing.** Spent ~5 extra WebFetch / gh-api calls confirming URLs, dates, repo names, and authorship before writing entries into REFERENCES.md. Caught one error (the `wolf5996` repo name) and one nuance (Bayer doesn't say "bioinformatician" explicitly even though all examples are). Worth it.
- **Kept Mineault despite gray-zone.** He's neuroAI-leaning, not pure bioinformatics, but the calibration register ("speed demands stronger validation, not weaker") is exactly the tone the failure-modes slide needs.
- **Frame the gap, don't oversell the absence.** REFERENCES.md notes which channels were *not* exhaustively checked (Mastodon, conference recordings, Bluesky timelines directly) so the "early adopters in stat-gen" claim is calibrated rather than maximalist.

## Surprises / things to flag

- **Stat-gen specifically is genuinely quiet.** Zero public writeups by stat-gen PIs/postdocs on PLINK/REGENIE/SAIGE/SuSiE/finemap/LDSC/LDpred Claude-Code workflows surfaced despite tool- and lab-name-targeted queries (Pritchard, Neale, Price, Stegle, Yengo, McCarthy, Daly, Visscher, Bahlo). The "we'd be early adopters" line is defensible.
- **Wet/general computational biology is *not* quiet.** Naughton + Bayer + Saera Vila + Swarup lab is a small but real conversation. The talk shouldn't claim total silence — distinguish stat-gen from comp-bio.
- **The Swarup lab `operon` repo is the unexpectedly strong find.** A real neurodegeneration-genomics PI (Alzheimer's, snRNA-seq) shipping an open-source Claude-Code-wrapping IDE — closer to the Bahlo audience than anything else in the references list. Worth a slide on its own, or at least a screenshot.

## Open items / next steps

- Decide if the talk wants a dedicated "what others in our field are doing" slide drawing on this section, or whether to fold the framings into existing slides (e.g. Bayer's Naur framing into the *what good use looks like* section, Naughton into *concrete demos*, Swarup `operon` into *infrastructure/tooling*).
- Optional deepening if time allows: eyeball Bluesky directly (Google's index is unreliable there) and check the BioC / ASHG / ESHG 2025–26 talk archives for any Claude-Code mentions. Low priority — the gap claim already holds.
- Naughton's blog has more than the one post; a second pass for additional concrete workflows could pay off.
