---
name: tim-va-kiem-nguon
description: Find academic sources and verify them before citing (tìm tài liệu, kiểm nguồn, tài liệu tham khảo) - search Google Scholar, Semantic Scholar, OpenAlex, Crossref, arXiv, VJOL; confirm a paper exists with correct metadata (DOI, authors, year, volume, pages); detect AI-fabricated citations; check predatory journals/conferences and retracted papers; check similarity/plagiarism (Turnitin, DoIT, iThenticate). Use when writing a literature review, adding references, auditing a reference list, or choosing where to submit.
---

# Finding and verifying sources

**Never cite what you have not been able to open.** Language models fabricate citations very often: studies measure roughly one fifth to more than half of model-generated citations as entirely fabricated, and many "real" citations still carry wrong authors, year or pages. Therefore every reference entry must be checked against at least one independent lookup source, even when it looks plausible.

## 1. Finding sources
| Source | Use for | Notes |
|---|---|---|
| Google Scholar | broad search, citation counts, "Cited by" | no official API; search the title phrase in quotation marks |
| Semantic Scholar | topic search, citation graph | has an API (`api.semanticscholar.org/graph/v1/paper/search`) |
| OpenAlex | open metadata, filter by year/venue | `https://api.openalex.org/works?filter=title.search:<từ>`; `search=` also searches abstracts |
| Crossref | verify DOI and publisher metadata | `https://api.crossref.org/works?query.bibliographic=<tiêu đề tác giả năm>&rows=3` |
| arXiv | preprints in CS, math, physics | `http://export.arxiv.org/api/query?search_query=ti:"<tiêu đề>"`; check whether an official published version exists, and prefer citing the official version |
| DBLP | CS conference/journal papers, clean BibTeX | dblp.org |
| ACL Anthology, IEEE Xplore, ACM DL, SpringerLink, ScienceDirect | original publisher sources | BibTeX from here is better than from Google Scholar |
| VJOL (Vietnam Journals Online) | journals published in Vietnam | vjol.info.vn |
| University library, thesis repositories | domestic theses and projects (luận văn, đề án) | |

Strategy: start from the 2-3 most recent survey papers → read the relevant parts → follow their references (backward) and "Cited by" (forward) → stop when new papers add no new directions. Record the search strings and the search date.

## 2. Verifying one reference entry
1. **Has a DOI:** open `https://doi.org/<doi>`; compare title, authors, year, venue. A DOI that does not resolve or points to a different paper → suspect fabrication. Or use `https://api.crossref.org/works/<doi>`.
2. **No DOI:** search the title in quotation marks on Google Scholar/Semantic Scholar/OpenAlex/DBLP; if it appears nowhere, treat it as non-existent until evidence appears.
3. **Check details:** full author names, year, volume, issue, pages, conference name matching the right year.
4. **Check content:** does what you wrote really appear in the paper (open it, find the passage)? If you read only the abstract, write only what the abstract says.
5. **Record the status** in a notes file or the BibTeX `note` field: verified (date, verification source).
6. Never let AI generate DOIs, page numbers, volume/issue. Get BibTeX from the publisher, DBLP or Crossref (`https://api.crossref.org/works/<doi>/transform/application/x-bibtex`).

## 3. Signs of a fabricated citation
- Real authors and a plausible topic, but the title exists nowhere.
- A real journal, but the volume/issue/pages do not exist or belong to another paper.
- A DOI with a "nice" format that does not resolve.
- Year does not match the journal volume; the conference was not held that year.
- A Vietnamese-language source cannot be found on VJOL, the journal's website or a library.
- Many entries by the same author with near-identical titles.

## 4. Predatory journals and conferences
There is no longer a reliable free blacklist (Beall's list has been discontinued; Cabells Predatory Reports is paid). Use positive confirmation and combine signals:
- Indexed in Scopus (Sources), the Web of Science Master Journal List, DOAJ; publisher is a COPE member.
- For domestic credit: the list of scored journals of the State Professorship Council (Hội đồng Giáo sư nhà nước; updated yearly, by field).
- The Think. Check. Submit. checklist (thinkchecksubmit.org).
- Warning signs: name easily confused with a reputable journal, mass invitation emails, promise of peer review in a few days, high non-transparent fees, editorial board that cannot be verified, vague contact address, unfamiliar "impact factor" metrics.
- Conferences: check that the proceedings have a clear publisher (IEEE, ACM, Springer), a history of previous years, and are listed in DBLP.

## 5. Retracted papers
Before citing an important paper, check for retraction: Retraction Watch data is integrated into Crossref; look at the `update-to` field in the DOI's Crossref record, or filter `https://api.crossref.org/works?filter=update-type:retraction`. The publisher's page also shows "Retracted". Do not cite a retracted paper (unless discussing the retraction itself).

## 6. Similarity and plagiarism checking
- Tools commonly used in Vietnam: Turnitin, DoIT (developed by VNU University of Engineering and Technology, supports Vietnamese), iThenticate (for journal articles).
- The similarity threshold is set by each school in its academic-integrity regulations; Thông tư 23/2021/TT-BGDĐT gives no figure. Ask for or look up the school's rule; do not guess.
- Reduce similarity the right way: paraphrase in your own words and cite; for verbatim text use quotation marks plus the source. Do not mechanically swap synonyms to evade the tool (it is still plagiarism).
- Self-plagiarism: reusing verbatim your own published paper/thesis must also be cited and follow the submission venue's rules.

## 7. Source log (recommended)
A table recording, for each source: citation key | full text opened or abstract only | idea used in the document (which section) | date checked | verification source (DOI/Crossref/DBLP). When several people write together, each adds sources to their own `.bib` file together with this log.
