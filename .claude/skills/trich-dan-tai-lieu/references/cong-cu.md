# Tools: BibTeX/biblatex, Zotero, Word

## Managing sources
- Zotero (free): save from the browser, fetch metadata by DOI/ISBN/arXiv ("Add Item by Identifier" button), export BibTeX, Word/LibreOffice plugin.
- Better BibTeX (Zotero add-on): stable citation keys (e.g. `tran2023retrieval`), automatically exports the `.bib` file when the library changes.
- Mendeley, EndNote: similar; pick one tool for the whole document.
- Re-check metadata after import: Google Scholar and some sites often give wrong journal/conference names, missing pages, messy capitalization.

## BibTeX: rules for writing entries
```bibtex
@article{tran2023retrieval,
  author  = {Tran, An Binh and Le, Cuong Duc},
  title   = {Dense retrieval for {Vietnamese} legal documents},
  journal = {IEEE Transactions on Knowledge and Data Engineering},
  year    = {2023},
  volume  = {35},
  number  = {4},
  pages   = {101--115},
  doi     = {10.1109/TKDE.2023.0000000}
}
```
- Join authors with `and`, in the form `Surname, Given name`. Vietnamese names: `{Nguyễn Văn An}` in braces so the family/given name is not split, or `Nguyễn, Văn An` depending on how the school wants it displayed (check the printed output).
- Organization as author: `author = {{Bộ Giáo dục và Đào tạo}}` (double braces).
- Preserve capitals for proper names and abbreviations: `{BERT}`, `{Việt Nam}`, `{SQL}`. Write titles in sentence case and wrap proper names, and let the citation style handle the rest.
- Pages use `--`. The DOI does not include `https://doi.org/`.
- `@inproceedings` for conference papers (`booktitle`), `@phdthesis`/`@mastersthesis` (biblatex: `@thesis` + `type`), `@misc`/`@online` for web (`url`, `urldate`), `@software`, `@dataset` (biblatex).
- arXiv (biblatex): `eprint = {2305.12345}, eprinttype = {arxiv}`.
- One key per document; name keys by the rule `first author surname + year + keyword`.

## biblatex for Vietnamese documents
```latex
\usepackage[vietnamese]{babel}
\usepackage[backend=biber, style=ieee]{biblatex}  % hoặc style=apa, authoryear, numeric, vancouver
\addbibresource{refs.bib}
...
\printbibliography[title={Tài liệu tham khảo}]
```
- babel `vietnamese` lacks some strings for the IEEE style, so output may mix in English or report missing strings. Define the extras per school rules, for example:
```latex
\DefineBibliographyStrings{vietnamese}{
  url     = {[Trực tuyến]. Địa chỉ},
  urlseen = {Truy cập},
  editor  = {biên tập},
  editors = {biên tập},
  chapter = {chương},
}
\DeclareFieldFormat{pages}{\mkpageprefix[bookpagination]{#1}}
```
  If the school requires English-form entries for English sources, set `langid = {english}` in each entry and enable `autolang=other` in biblatex.
- Split the list by language (Vietnamese model): assign `keywords = {vi}` or use `langid`, then
```latex
\printbibheading[title={Tài liệu tham khảo}]
\printbibliography[heading=subbibliography, title={Tiếng Việt}, keyword=vi]
\printbibliography[heading=subbibliography, title={Tiếng Anh}, notkeyword=vi]
```
  Numbering is continuous across blocks with the numeric style (`defernumbers=true` is the default when filtering; enable it in the options if numbers jump).
- Sort Vietnamese authors by given name: biblatex sorts by `family`; for Vietnamese entries declare `sortname = {An, Nguyễn Văn}` or `sortkey` so sorting follows the given name while still printing "Nguyễn Văn An".
- Citing with a page: `\cite[tr.~5]{khoa}` or `\cite[5]{khoa}` (biblatex adds the page prefix automatically by language).
- Multiple sources: `\cite{a,b,c}`; biblatex numeric collapses them into a range if you use `style=numeric-comp`.
- Sentence with author: `\textcite{khoa}` (author–year), `\citeauthor{khoa}~\cite{khoa}` (numeric style).
- Run: `latexmk -xelatex` (calls biber automatically). Check the `.blg` file when biber reports errors; "Citation … undefined" warnings must reach 0.

## natbib/BibTeX (older conference templates)
Many conference templates (ACL, IEEEtran) use BibTeX + `.bst` instead of biblatex. Do not switch to biblatex when submitting with a template; use `\cite`, `\citep`, `\citet` as the template does.

## Word
- Zotero plugin: Add/Edit Citation, Add/Edit Bibliography, Document Preferences to change style (CSL). For a Vietnamese school style: look on the Zotero Style Repository or edit an existing CSL.
- Word's References → Citations & Bibliography works for short documents; few styles, hard to customize.
- Before submission: Refresh to update numbers; if you need a copy without dynamic fields, "Unlink Citations" on a copy and keep the original with fields.

## Checking the list by command
```bash
# khóa trích trong .tex nhưng không có trong .bib (và ngược lại)
grep -ohP '\\(?:text|paren|auto)?cite[a-z]*\*?(?:\[[^\]]*\])*\{\K[^}]+' *.tex chapters/*.tex | tr ',' '\n' | sed 's/ //g' | sort -u > used.txt
grep -oP '^@\w+\{\K[^,]+' *.bib | sort -u > defined.txt
comm -23 used.txt defined.txt   # trích nhưng chưa định nghĩa
comm -13 used.txt defined.txt   # định nghĩa nhưng không trích (biblatex mặc định không in)
# DOI trùng
grep -ohiP 'doi\s*=\s*\{\K[^}]+' *.bib | tr 'A-Z' 'a-z' | sort | uniq -d
```
