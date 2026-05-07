# PRJ Lab meeting Claude Code talk

#claude-code #talk

**Date:** 2026-05-12 (lab meeting)
**Audience:** Bahlo lab — PhD students, senior researchers, research assistants
**Framing:** Researcher perspective on Claude / Claude Code, followed by some demo 
activities
**Primary goal:** Show the lab the potential for this to help their research work. 

## Outline

**Goal:** strengths and pitfalls of agentic AI for research scientists. End on segue to demo activities. 

### 1. LLM foundations (quick, ~5 min)
- Token predictors, not databases — confident wrong answers are a feature of the architecture
- Context window = the model's scratchpad; everything outside it doesn't exist
- System prompt vs user prompt vs tool results — all the same context to the model
- Knowledge cutoffs — why "current best practice in X" answers go stale
- Grounding (files, tool output, citations) is what turns guessing into reasoning
- See figures/llm-anatomy.webp 

### 2. From web chat to agentic AI
- Web chat (claude.ai, ChatGPT): you are the copy-paste between model and reality
- Agentic: model reads your files, runs shell commands, calls tools, loops on results
- The agent loop: think → act → observe → repeat
- Why it matters for researchers: closes the gap between "suggesting code" and "running the analysis end-to-end"
- The trade-off: more autonomy = more chances to be wrong without you noticing

### 3. How I've actually used it (concrete examples)
- **My research notebook / meeting log** — `/capture`, `/meeting`, `/review` skills; Claude as research infrastructure, not just a coder
- **R/targets C9orf72 pipeline** — TDD-driven, multi-task plans landing with full test suites passing
- **Code understanding** — onboarding into unfamiliar codebases and pipelines
- **Manuscript editing, analysis planning** — brainstorm → spec → plan → execute across sessions

### 4. Context management
- Context window is the bottleneck; the model "forgets" what it can't see
- `CLAUDE.md` = persistent project memory (conventions, vocab, who's who)
- Skills / slash commands = reusable, versioned workflows
- Sub-agents (e.g. `Explore`) absorb read-heavy work and return a summary, keeping main context clean
- Plan mode and design docs compress decisions into a small durable artefact
- Know when to start a fresh session — long sessions drift
- See figures/context-engineering.webp 

### 5. Version control is more important than ever

- LLM tools are fluent in git and they know all of its archaic features
- Using git means if you write any code or if there are mistakes they can be rolled back or investigated 
- Another way of giving Claude Code memory (what did we change in the last three commits?)

### 5. Tenets for checking your work 
- Read the diff, every time — never trust a "done" claim
- Plan first, execute second — explicit phase gates ("plan only, don't implement until I say go")
- Tests are the unit of trust for code; for prose, your own eyes are
- Commit early, commit often — cheap save-points make rollback painless
- Watch for confident-sounding wrong answers (real examples: Northern/Southern Europe swap, gene/acronym confusion, wrong meeting day)
- If the agent is confused, you are under-specifying — re-ground, don't argue with it

### 6. Pitfalls to name out loud
- Premature action before alignment
- Confabulated file paths and function names
- Sycophancy — it will agree with a bad idea if you push
- Cost runaway on long autonomous loops
- Over-reliance erodes your own understanding (especially risky for students mid-training)
- "Vibe coding" — code that runs but no one understands, including you

### 7. How we could use it?
- Strongest researcher payoffs: analysis pipelines, codebase onboarding, paper drafts, personal knowledge infra
- What "good use" looks like in a research lab vs. a software team
- Honest scope: this is a tool, not a researcher. i.e. it is still important to learn how to program, learn methods, learn the biology

### 8. Lab policies?
- **Security issues**: ok to run agents on HPC?
- **Infrastructure / data governance addendum** — see [[202605061718 TIL Claude Code on shared HPC — security and architecture]]. Headline: data egress is the binding constraint, not SSH topology. Don't point Claude at UKB / GEL / clinical data; code-only workspaces are fine. The right ask of WEHI IT is institutional Enterprise tier + documented deny-list policy, not just opening api.anthropic.com on the firewall.

### 9. Activities 

- Break into groups to try out claude code live. 
- Suggested ideas in [ACTIVITIES.md](ACTIVITIES.md)



