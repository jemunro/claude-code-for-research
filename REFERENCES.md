# Reading list — Claude Code talk references

## Claude Code & research workflow

- [Russell Poldrack · Better Code, Better Science](https://bettercodebetterscience.github.io/book/) — Open book on AI-assisted coding for reproducible scientific software: testing, project structure, workflow management, validation.
- [Claude Blattman · AI for Professionals Who Don't Code](https://claudeblattman.com/) — A professor's open-source AI workflow for managing research projects, email, and teams with Claude Code.
- [Simon Willison · Agentic Engineering Patterns](https://simonwillison.net/guides/agentic-engineering-patterns/) — Pattern catalogue for getting the best out of coding agents.
- [Anthropic Courses](https://anthropic.skilljar.com/) — First-party Anthropic training material.
- [Saeideh Bakhshi · You can delegate the work, but don't delegate the thinking](https://saeidehbakhshi.substack.com/p/you-can-delegate-the-work-but-dont) — Tool / oracle / system modes; argues for "system mode" via up-front analysis contracts.
- [Taylor (Mira) · Talking to Transformers](https://miraos.org/blog/2026/05/02/talking-to-transformers) — Four-pillar framing of prompting: intent, attention budget, translation, reading outputs.
- [Scott Cunningham · Claude Code 46: Verification is the new bottleneck](https://causalinf.substack.com/p/claude-code-46-verification-is-the) — Production and verification have decoupled; verification is now the binding constraint.
- [Ethan Mollick · Management as AI superpower](https://www.oneusefulthing.org/p/management-as-ai-superpower) — Delegation, not prompting, is the binding skill; the Equation of Agentic Work.
- [Carlo Cordasco · The confessions of a question-driven guy](https://carlolc.substack.com/p/the-honest-tails-of-a-question-driven) — A philosopher on AI changing the cost structure of cross-disciplinary work.

## Stat-gen / bioinformatics

- [Brian Naughton · Claude Code for computational biology](https://blog.booleanbiotech.com/claude-code-for-computational-biology) — End-to-end agent walkthrough integrating ipSAE scoring into an AlphaFold2 modal app.
- [swaruplab/operon](https://github.com/swaruplab/operon) — Open-source macOS IDE wrapping Claude Code, built by a neurodegeneration / single-nucleus genomics lab.
- [Philipp Bayer · Naur for LLMs](https://philippbayer.github.io/blerg/posts/2025_08_28_naur_for_llms/) — Bioinformatics-flavoured workflow leaning on Naur's *Programming as Theory Building*; explicit failure modes.
- [Alfonso Saera Vila · Claude Code for bioinformatics](https://lovednacodeblog.com/post/2026-02-04-claudecode/) — Terminal workflow basics: FASTQ parsing, VCF QC, RNA-seq scripts.
- [Alfonso Saera Vila · Claude Code skills for bioinformatics](https://lovednacodeblog.com/post/2026-03-02-claudecodeskills/) — Using skills to generate Excalidraw diagrams for a single-cell Nextflow pipeline.
- [Patrick Mineault · Claude Code for Scientists](https://www.neuroai.science/p/claude-code-for-scientists) — Speed of AI-assisted coding demands stronger validation, not weaker.
- [wolf5996/agentic-skills](https://github.com/wolf5996/agentic-skills) — Skills repo with R-package, Quarto, R-code, and analysis-project skills; ships both `CLAUDE.md` and `CODEX.md`.

## Pitfalls

- [Navigating the Jagged Technological Frontier: Field Experimental Evidence of the Effects of AI on Knowledge Worker Productivity and Quality](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4573321) - A paper on the causal impact of GPT4 on management consulting professionals performance. They introduce the term 'jagged frontier' which refers to uneven capability of LLMs to do certain tasks. They showed that within the frontier that quality increased and the time taken to complete an activity decreased by 25%, while on the other hand tasks that fell
outside of the frontier produced incorrect results with users unable to recognise the result was incorrect. 
- [Generative AI Without Guardrails Can Harm Learning: Evidence from High School Mathematics](https://www.pnas.org/doi/10.1073/pnas.2422633122) - A paper reporting on a RCT of ChatGPT use for mathematics, with an AI tutor that was specifically designed to help students with their math homework, compared against regular chatgpt and no AI intervenetions. Students who only used raw ChatGPT practiced more but had worse exam results compared to those who did not use AI, likewise the AI tutor arm had better practice scores compared to raw ChatGPT but performed about the same as the no AI arm on their (closed-book) exams.
