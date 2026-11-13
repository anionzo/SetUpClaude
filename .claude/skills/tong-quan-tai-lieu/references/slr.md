# Systematic, scoping and mapping review methods

Sources (checked 2026-11-13): PRISMA 2020 (Page et al., BMJ 2021; PubMed 33789826); Kitchenham & Charters, *Guidelines for performing Systematic Literature Reviews in Software Engineering*, EBSE-2007-01 v2.3 (2007); Wohlin, "Guidelines for snowballing in systematic literature studies", EASE 2014 (doi:10.1145/2601248.2601268); Arksey & O'Malley (2005) and Levac et al. (2010) for scoping reviews; PRISMA-ScR. Items marked [unverified] were not confirmed against the primary text.

## 1. Kitchenham SLR phases (software engineering / computing)
1. **Planning:** identify the need for the review (check no recent SLR already answers it); specify research questions; write a review protocol (questions, search strategy, criteria, quality checklist, extraction form, synthesis plan); validate the protocol (supervisor or peer).
2. **Conducting:** search; select primary studies; assess quality; extract data; synthesise.
3. **Reporting:** write the report; have it validated/reviewed.
[unverified: sub-step naming is from memory of the guideline; the three phases are confirmed.]

## 2. Review questions: PICO / PICOC
| Element | Meaning | Example (computing) |
|---|---|---|
| Population | the domain, users, systems | document retrieval in enterprises |
| Intervention | the method/technology studied | hybrid lexical + dense retrieval |
| Comparison | baseline | BM25 only, dense only |
| Outcome | measured effect | retrieval accuracy, latency |
| Context | setting | non-English, on-premise |
[PICOC is the Kitchenham adaptation of PICO; mark as standard practice.]

## 3. Search strategy
- Derive keywords per PICOC element, add synonyms, spelling variants, acronyms. Combine: `(synonym1 OR synonym2) AND (…) AND (…)`.
- Pilot the string: does it retrieve a set of known relevant papers ("golden set")? Adjust until it does.
- Adapt syntax per database (field codes: TITLE-ABS-KEY in Scopus, etc.); record the exact string per database and the search date.
- Supplement with snowballing and hand search of key venues.
- Export results to a reference manager; remove duplicates; record counts.

## 4. Snowballing (Wohlin 2014)
Start set: papers from a database search or known key papers (diverse authors/venues). Iterate:
- **Backward:** examine the reference list of each included paper; apply criteria.
- **Forward:** examine papers citing each included paper (Google Scholar/Scopus "cited by"); apply criteria.
Repeat on newly included papers until an iteration adds nothing. Snowballing can be the main search strategy or complement a database search.

## 5. Selection
- Inclusion/exclusion criteria written before screening (topic, period, language, peer-reviewed, full text available, primary study vs review).
- Two stages: title/abstract, then full text. Ideally two reviewers independently on at least a sample; report agreement (Cohen's κ) and how disagreements were resolved. A single student reviewer: state it as a limitation; have the supervisor check a sample.
- Keep a log: record ID | stage | decision | reason.

## 6. PRISMA 2020 flow diagram (counts at each box)
- **Identification:** records from databases/registers (per source); records from other methods (snowballing, websites); records removed before screening (duplicates, automation, other).
- **Screening:** records screened → records excluded; reports sought for retrieval → not retrieved; reports assessed for eligibility → reports excluded, with reasons and counts.
- **Included:** studies included in the review (and reports of included studies).
PRISMA 2020 has a 27-item checklist (with sub-items) plus an abstract checklist. Use the official template from prisma-statement.org.

## 7. Quality assessment
Predefined checklist applied to each included study, e.g. (computing): clear aims; method described enough to replicate; appropriate baseline; dataset described and available; metrics justified; threats to validity discussed; results support conclusions. Score (yes/partly/no = 1/0.5/0); use scores to weight synthesis or for sensitivity analysis, not only to exclude. [General practice; adapt to the field. Medicine uses validated tools such as risk-of-bias instruments.]

## 8. Data extraction
Pilot the form on 3–5 studies, then fix it. Extract into a spreadsheet (see SKILL.md §3). Record "not reported" explicitly rather than leaving blanks.

## 9. Synthesis
- **Quantitative (meta-analysis):** only when studies measure comparable outcomes; beyond most theses.
- **Narrative/thematic synthesis:** group by approach/theme; tabulate; describe patterns, contradictions, and moderating factors (data, language, scale).
- **Mapping:** counts by year, venue, approach, evaluation type; bubble charts or tables.

## 10. Scoping review
Arksey & O'Malley stages: (1) identify the research question; (2) identify relevant studies; (3) select studies; (4) chart the data; (5) collate, summarise and report; optional (6) consultation with stakeholders (Levac et al. recommend making it standard). Report with PRISMA-ScR (about 20 essential items + 2 optional [unverified count]).

## 11. Reporting the method in a thesis
One subsection: questions, databases and dates, search strings (full strings in an appendix), criteria, selection process and counts (PRISMA diagram), quality assessment, extraction, synthesis method, limitations (single reviewer, language restrictions, databases not covered).
