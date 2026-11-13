# Special source types

Templates follow IEEE (I) and APA 7 (A); adapt other styles per `kieu-trich-dan.md`.

## Preprint (arXiv, SSRN, bioRxiv)
- Check whether a published version exists (Semantic Scholar, DBLP, Google Scholar); if so, cite the published version.
- Give the version if the content differs between versions (v2).
- I: `A. Author, "Title," 2023, arXiv:2305.12345.`
- A: `Author, A. (2023). Title. arXiv. https://doi.org/10.48550/arXiv.2305.12345`

## Software, libraries, source code
Give: author/organization, name, version, release year/date, repository (GitHub, PyPI, Zenodo), identifier (Zenodo DOI if available). Many projects have a `CITATION.cff` file or a "How to cite" section: use the exact paper/identifier the authors ask for.
- I: `PostgreSQL Global Development Group, PostgreSQL, ver. 16.2, 2024. [Online]. Available: https://www.postgresql.org`
- A: `PostgreSQL Global Development Group. (2024). PostgreSQL (Version 16.2) [Computer software]. https://www.postgresql.org`
- Popular libraries used as tools (NumPy, pandas): usually cite their introductory paper if the project asks for it; there is no need to cite every dependency package.

## Datasets
Give: author/organization, year, title, version, repository (Hugging Face, Kaggle, Zenodo, UCI), DOI/URL, license if relevant. A dataset accompanying a paper: cite the paper, optionally with a dataset entry as well.
- I: `Author/Org., 2020, "Dataset title," Repository, doi: 10.xxxx/xxxxx.`
- A: `Author. (2020). Dataset title (Version 2) [Data set]. Publisher. https://doi.org/...`

## AI models, generative AI services
- A model with a paper/technical report: cite that report (e.g. the developer's technical report), and state the exact version name and the API access date in the experiments section.
- Using a generative AI tool as software (APA 7): `Company name. (Year). Model name (version/date) [Large language model]. URL`. In text (Company, year).
- Record in the methods section: model, version/identifier, call date, parameters (temperature…), key prompts (appendix).
- AI is not an author: do not put it in the author list; declare AI use per school/journal rules (many journals require a declaration section).
- AI-generated content is not a source for scientific claims: verify it and cite the original source.

## Web pages, online technical documentation
- Prefer official documents (developer docs, specifications, RFCs) over blogs.
- Give the update date if available, otherwise "n.d."/"k.n."; give the access date for pages that change.
- RFC: I `J. Postel, "Transmission control protocol," IETF, RFC 793, Sep. 1981.`

## Standards, technical regulations
- I: `Information technology — Database languages — SQL, ISO/IEC 9075-1:2023, 2023.`
- Vietnamese standards: `[n] Bộ Khoa học và Công nghệ (2020), TCVN xxxx:2020 Tên tiêu chuẩn, Hà Nội.` (traditional model).

## Legal documents
See `viet-nam.md` section 7.

## Theses, dissertations, graduation theses
Give the type (master's thesis, doctoral dissertation, master's project (đề án thạc sĩ), graduation thesis (khóa luận tốt nghiệp)), major, university, place; if online, the repository and URL. Templates in `kieu-trich-dan.md` and `viet-nam.md`.

## Lectures, internal documents, personal communication
- Unpublished lectures and slides: avoid; if used, give author, title, course, university, year.
- Internal documents of an organization (procedures, reports): give the organization name, year, document title, "tài liệu nội bộ"; get permission to use them.
- Personal communication, interviews (APA): cite only in the sentence "(N. V. An, trao đổi cá nhân, 12/3/2025)", not in the list; an interview conducted as research is described in the methods.

## Figures and tables taken from other sources
Under the figure/table: "Nguồn: [5]" or "Nguồn: phỏng theo [5]" (redrawn/modified); "Nguồn: học viên tổng hợp từ [3], [7]". A figure the writer drew personally needs no source (some schools require "Nguồn: tác giả"). Using a copyrighted figure in a published paper requires permission.
