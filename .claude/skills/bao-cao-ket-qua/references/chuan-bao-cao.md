# Reporting guidelines and reproducibility checklists

Check which guideline the target journal requires (often stated in the author instructions; many medical/health journals require the checklist to be submitted). Index of all guidelines: EQUATOR Network (equator-network.org). Checked 2026-11-13; items marked [unverified] were not confirmed against the primary source.

## Study design → guideline
| Study type | Guideline | Size |
|---|---|---|
| Randomised trial | CONSORT 2025 (replaces CONSORT 2010) | 30 items + participant flow diagram |
| Observational (cohort, case-control, cross-sectional) | STROBE | 22 items [unverified] |
| Systematic review / meta-analysis | PRISMA 2020 | 27 items + abstract checklist + flow diagram |
| Scoping review | PRISMA-ScR | ~20 + 2 optional [unverified] |
| Qualitative interviews / focus groups | COREQ | 32 items in 3 domains |
| Qualitative research (general) | SRQR | 21 items [unverified] |
| Diagnostic accuracy | STARD 2015 | 30 items |
| Prediction models (regression or ML) | TRIPOD+AI (2024, replaces TRIPOD 2015) | 27 items + 13-item abstract checklist |
| Online surveys | CHERRIES | [unverified count] |

Even when not required (e.g., computing, economics), the relevant checklist is a good self-check for what to report.

## Machine learning / NLP venues
**NeurIPS paper checklist** (mandatory; after references, not counted in page limit; Yes/No/NA + justification). Items cover [list partly unverified]: claims match contributions; limitations; theory assumptions and proofs; reproducibility of results; open access to data and code; experimental settings; statistical significance (error bars); compute resources; code of ethics; broader impacts; safeguards; licenses of existing assets; documentation of new assets; crowdsourcing and human subjects; IRB approval; LLM usage declaration.

**ACL/ARR Responsible NLP Research checklist** (sections vary by year):
- A — every submission: limitations, risks, claims match abstract/introduction.
- B — scientific artifacts: citation of creators, licenses, intended use, personal data, documentation, statistics.
- C — computational experiments: model size and compute budget, hyperparameters, descriptive statistics, packages.
- D — human annotators/participants: instructions, recruitment and pay, consent, ethics approval, demographics.
- E — AI assistants: use in research, coding or writing.

**ACM Artifact Review and Badging v1.1:**
- Artifacts Available — archived permanently, publicly accessible.
- Artifacts Evaluated – Functional — documented, consistent, complete, exercisable.
- Artifacts Evaluated – Reusable — Functional plus well documented/structured for reuse.
- Results Reproduced — a different team obtains the main results using the authors' artifacts.
- Results Replicated — a different team obtains them without the authors' artifacts.

## Minimum reproducibility package (any field with computation)
- Code with a README (setup, exact commands to reproduce each table/figure), pinned dependencies, license.
- Data or access instructions; preprocessing scripts; splits.
- Configurations, seeds, model versions, hardware and runtime.
- Raw results files from which tables are generated; plotting scripts.
- Archived with a persistent identifier (Zenodo DOI, institutional repository) at submission or publication.
