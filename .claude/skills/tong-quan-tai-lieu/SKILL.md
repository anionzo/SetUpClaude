---
name: tong-quan-tai-lieu
description: Plan, conduct and write a literature review (tổng quan tài liệu, tổng quan nghiên cứu, chương cơ sở lý thuyết) for a thesis, đề án, luận văn, luận án or paper — narrative review, systematic literature review (SLR), scoping review, mapping study. Covers research questions (PICO/PICOC), search strings and databases, inclusion/exclusion criteria, PRISMA 2020 flow, Kitchenham SLR phases, snowballing, quality assessment, data extraction, synthesis matrix, identifying the research gap (khoảng trống nghiên cứu), and writing the review chapter without listing papers one by one.
---

# Literature review

Related: `tim-va-kiem-nguon` (finding and verifying each source), `trich-dan-tai-lieu` (citing), `van-phong-hoc-thuat` (style; `references/mau-cau.md` §3 has review phrases). Process details: `references/slr.md`.

## 1. Pick the review type
| Type | Use when | Method weight | Typical output |
|---|---|---|---|
| Narrative / background review | thesis chapter giving context and theory | low: purposive search, documented roughly | chapter organised by theme |
| Systematic literature review (SLR) | answering a specific question from all available evidence | high: protocol, reproducible search, screening by criteria, quality appraisal | PRISMA flow + synthesis |
| Scoping review / systematic mapping | charting what exists in a broad or new area | medium–high: systematic search, no/limited quality appraisal | counts, categories, gaps |
| Rapid review | time-limited SLR | simplified SLR, limitations stated | |

A master's thesis usually needs a narrative review organised by themes, made more credible by stating how the literature was found (databases, keywords, period, criteria). Call it "systematic" only if the method in `references/slr.md` was actually followed.

## 2. Workflow (any type)
1. **Questions.** Write 1–3 review questions derived from the thesis objectives. Use PICOC to frame them: Population, Intervention, Comparison, Outcome, Context.
2. **Search.** Choose databases for the field (Scopus, Web of Science, IEEE Xplore, ACM DL, PubMed, ScienceDirect, Google Scholar for coverage, VJOL for Vietnamese work). Build a search string from synonyms of each PICOC element joined by AND/OR; record string, database, date, hit counts.
3. **Select.** Explicit inclusion/exclusion criteria (topic, years, language, publication type, peer review). Screen titles/abstracts, then full texts; log the reason for each full-text exclusion.
4. **Snowball.** Backward (reference lists) and forward (citing papers) from the included set until no new relevant studies appear.
5. **Extract.** One row per study in a extraction table (see §3). Read the full text; do not extract from abstracts only.
6. **Synthesise.** Group by theme/approach, compare, find agreements, contradictions and gaps (§4).
7. **Write** (§5). Keep the extraction table as an appendix or supplementary file.

## 3. Extraction / synthesis matrix
Columns to adapt: citation key | year | venue | problem | method/approach | data (size, language, domain) | evaluation metrics | main result (numbers) | limitations stated by authors | relevance to this thesis (which RQ/section).
Fill one row per paper as you read; the matrix is the basis for comparison tables and for the gap.

## 4. From matrix to research gap
- Sort the matrix by approach and by the dimensions that matter for the thesis (data type, language, scale, deployment setting, evaluation method).
- A gap is a specific, checkable absence: "no study evaluates X on Vietnamese administrative documents", "existing systems do not handle per-tenant access control in retrieval", "results are reported only on English benchmarks". Not a gap: "few studies exist" without evidence, "this area is new".
- Support each gap with the rows of the matrix that show it; cite them.
- The gap must lead directly to the thesis objectives (gap → objective → method → evaluation).

## 5. Writing the review chapter
- **Organise by theme, not by paper.** Wrong: one paragraph per paper ("A (2020) proposed… B (2021) proposed…"). Right: one paragraph per idea, comparing several works: "Dense retrievers [4], [7] outperform BM25 on in-domain queries but degrade on unseen domains [9]; hybrid methods [11], [12] address this by…".
- Structure: concepts and theory → approaches grouped by type (with a comparison table) → related systems/applications → summary of gaps.
- Each section ends with what it means for this work (one or two sentences), not a recap.
- Use a comparison table (approaches × criteria) for 5+ works; describe in text only what the table cannot show.
- Be evaluative: say what each group of works does not do, under which conditions results hold, and how evaluations differ — with evidence, not adjectives.
- Recency: cover recent work (last 3–5 years for fast fields) and the foundational papers; state the search cut-off date.
- Report the search method in 1 paragraph (narrative review) or a full method section with PRISMA flow (SLR).
- Do not cite what you have not read (`tim-va-kiem-nguon`); do not copy another review's reference list.

## 6. Checklist
- [ ] Review questions stated and tied to the thesis objectives.
- [ ] Search documented: databases, strings, dates, criteria, counts.
- [ ] Every cited work read and verified; extraction matrix kept.
- [ ] Organised by themes with comparison; no paper-by-paper listing.
- [ ] Gaps are specific, supported by cited evidence, and lead to the objectives.
- [ ] Recent and foundational works both present; cut-off date stated.
