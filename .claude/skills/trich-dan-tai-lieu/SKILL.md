---
name: trich-dan-tai-lieu
description: Citing sources and building reference lists for theses, projects (đề án), graduation theses (khóa luận), journal articles and reports, in Vietnamese and English (trích dẫn, tài liệu tham khảo, luận văn, đề án, khóa luận, bài báo, báo cáo). Covers when to cite, quotation vs paraphrase, secondary citation, in-text citations and reference entries in IEEE, APA 7, Harvard, Vancouver, Chicago author-date, Vietnamese conventions (ordering by language, Vietnamese author names, [số, tr.x]), citing web pages, software, AI models, datasets, legal documents, theses; BibTeX/biblatex, Zotero, Word; checking the reference list before submission. Use when inserting citations, switching citation style, fixing a .bib file, or auditing references.
---

# Citing sources

Verify that a source really exists before citing it: `tim-va-kiem-nguon`. Prose style around the citing sentence: `van-phong-hoc-thuat`. General document layout: `trinh-bay-van-ban-hoc-thuat`.

## 1. Choose the citation style
Priority order: **rules of the school/journal/conference** -> the template of the submission venue -> field convention. One document uses exactly one style.

| Style | In-text form | Fields that commonly use it |
|---|---|---|
| IEEE | [1], [2]–[4] in order of first appearance | IT, electrical, electronics, engineering |
| APA 7 | (Nguyễn, 2023) | psychology, education, economics, social sciences, management |
| Harvard | (Nguyen, 2023, p. 12) | economics, business, many UK/Australian universities |
| Vancouver | [1] or superscript | medicine, pharmacy, biology |
| Chicago author-date | (Nguyen 2023, 12) | social sciences, history (the notes-bibliography variant uses footnotes) |
| ACM | [1] or (author, year) per the ACM template | ACM conferences/journals |

Details per style: `references/kieu-trich-dan.md`. Vietnamese conventions: `references/viet-nam.md`. Special source types (web, software, data, AI models, law, standards, patents): `references/loai-nguon.md`. Tools: `references/cong-cu.md`.

## 2. When you must cite
Cite whenever you use someone else's:
- ideas, arguments, models, methods, definitions;
- data, results, tables, figures (including ones redrawn or modified: "Nguồn: phỏng theo [5]");
- verbatim wording;
- source code, datasets, software, models used in experiments;
- your own published work (avoids self-plagiarism).

No citation needed for: common knowledge of the field (the definition of SQL as a query language), and the results of the document itself. When in doubt, cite.

## 3. Quotation, paraphrase, summary
| Method | When to use | Rule |
|---|---|---|
| Direct quotation | standard definitions, key sentences, legal texts | quotation marks + source + page number; above about 40 words (APA) or 4 lines, set it as an indented block without quotation marks; use "[…]" for omissions and "[ ]" for your own added words |
| Paraphrase | most cases | rewrite with your own structure and words, keep the meaning exact; still cite the source; swapping a few synonyms is not paraphrasing |
| Summary | gathering the ideas of one or several works | name the source for each idea; when several sources support the same idea, group them as [3]–[5] |

Keep direct quotations few (under a few percent of the text). For an English quotation inside a Vietnamese text: keep the original wording; you may add a translation in parentheses or a footnote, marked "(người viết dịch)".

## 4. Sentences containing citations
- Place the citation right after the idea it supports, not piled at the end of the paragraph: "BM25 xếp hạng theo tần suất từ [3], còn DPR dùng vector dày [4]."
- Numeric style: the citation number must not be the grammatical subject, as in "[3] cho thấy". Write "Karpukhin và cộng sự [4] cho thấy…" or "Nghiên cứu [4] cho thấy…" (the latter is accepted by many schools; check the rules).
- Author in the sentence (author–year style): "Nguyễn (2023) cho rằng…"; in parentheses: "…(Nguyễn, 2023)".
- Two authors: "Lewis và Perez [2]"; three or more authors: "Lewis và cộng sự [2]" ("et al." in English). A Vietnamese text uses "và cộng sự" or "và cs." consistently.
- Punctuation: IEEE puts [n] before the period: "…truy xuất [3]." APA: "…(Nguyễn, 2023)."
- Do not cite a long meaningless chain "[1]–[15]" for a general claim; choose 2–3 representative sources.
- Every citation must support exactly the claim before it (you have read and checked it, see `tim-va-kiem-nguon`).

## 5. Secondary citation
Use only when the original is inaccessible. Cite the source you actually read, and name the original in the sentence:
- APA: "Theo Shannon (1948, được trích trong Cover & Thomas, 2006)…"; only Cover & Thomas goes into the reference list.
- IEEE/numeric: "Shannon (được trích trong [7]) cho rằng…".
- Common Vietnamese convention: "Theo Shannon (1948) được trích dẫn bởi [7]…".
Do not copy someone else's reference list into yours as if you had read the works.

## 6. Reference list: general rules
- List only sources cited in the text, and every cited source must appear (two-way match). A "further reading" list is a separate list if the school allows it.
- Numeric style: order of first appearance. Author–year style: alphabetical by author surname, same author by year, same year add a, b (2023a, 2023b).
- Give all fields required for the type (section 7); if there is a DOI, give it (APA form `https://doi.org/...`).
- Article titles in sentence case in APA and for Vietnamese-language sources; IEEE keeps the original capitalization or sentence case per the journal template, but be consistent. Proper names and abbreviations keep capitals (BERT, Việt Nam).
- Journal and book titles: italic; article titles in a journal/conference: not italic (IEEE puts them in quotation marks).
- Prefer the officially published version over the preprint; for a preprint give the arXiv ID.
- Do not use Wikipedia, blogs or sales pages as sources for scientific claims (acceptable for product figures and official technical documentation).

## 7. Required information by type
| Type | Required |
|---|---|
| Journal article | authors, year, article title, journal name, volume, issue, pages (or article number), DOI |
| Conference paper | authors, year, paper title, proceedings/conference name, location (IEEE), pages, publisher, DOI |
| Book | authors/editors, year, book title, edition, publisher, (place of publication depending on style) |
| Book chapter | chapter authors, chapter title, editors, book title, pages, publisher |
| Thesis, dissertation | author, year, title, type (master's thesis/doctoral dissertation), university, place |
| Preprint | authors, year, title, arXiv:xxxx.xxxxx, (version) |
| Web page, online document | author/organization, year or update date, page title, website name, URL, access date (if the content changes) |
| Software, dataset, model | see `references/loai-nguon.md` |

## 8. Pre-submission check
- [ ] Every citation in the text is in the list and vice versa (LaTeX: no "undefined citation" warnings left; Word: update the Zotero fields).
- [ ] Every entry is checked for existence and correct metadata (`tim-va-kiem-nguon`).
- [ ] One citation style, correct sort order, correct punctuation, italic/roman used consistently.
- [ ] No author name appears in two forms (Nguyen, V. and Nguyễn Văn); journal names in one form (full or ISO abbreviation, not mixed).
- [ ] No duplicate entries (same paper, two BibTeX keys).
- [ ] Entry language is correct (Vietnamese: "tr.", "và cộng sự", "NXB"; English: "pp.", "et al.") per school rules.
- [ ] A page number accompanies every direct quotation.
- [ ] URLs still open; DOIs resolve correctly.
