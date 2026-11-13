---
name: trinh-bay-van-ban-hoc-thuat
description: Format theses, projects and dissertations (trình bày luận văn, đề án, luận án, khóa luận) per Vietnamese regulations, in Word or LaTeX - paper size, phông (font), font size, line spacing, lề (margins), page/chapter/section numbering, figures, tables, equations, order of parts (cover, title page, declaration, table of contents, lists...), length, thesis summary, and the difference between a luận văn and an đề án under Thông tư 23/2021/TT-BGDĐT. Use when building a template, checking formatting before submission, or moving content between Word and LaTeX.
---

# Formatting a thesis or project

**Rule number 1: the regulations of the student's own school are the standard.** The numbers below are common values for cross-checking and do not replace the school's template. Before applying anything: ask for the school and program, find the "thesis/project formatting guidelines" document (usually an appendix of the school's master's training regulations), read it and take the numbers from there. Record the source of the regulation used.

Writing style follows `van-phong-hoc-thuat`; citations follow `trich-dan-tai-lieu`.

## 1. Luận văn vs. đề án (Thông tư 23/2021/TT-BGDĐT)
| | Luận văn (thesis) | Đề án (project) |
|---|---|---|
| Program | research-oriented | application-oriented |
| Workload | 12-15 credits | graduation module of 6-9 credits (project/đề án) |
| Nature | scientific report summarizing the student's main research results | explanatory report on the process of building and carrying out the project |
| Requirement | academic or technological/innovative contribution, showing research capability | proposes and validates a new model/solution for a practical problem, showing applied problem-solving capability |
| Committee | >= 5 members, 2 reviewers (>= 1 external) | >= 3 members, 1 reviewer |

Both must comply with academic integrity and intellectual-property law; the institution controls plagiarism; copying or having someone else do the work can lead to forced withdrawal. The similarity threshold is set by each school (the Thông tư gives no figure).

Consequence for writing: an đề án stresses the practical problem, the solution, implementation and validation at the organization; a luận văn stresses the research question and the academic contribution. Use the correct name ("đề án" or "luận văn") consistently throughout the document.

## 2. Page parameters (common values)
| Item | Common | Range seen across schools |
|---|---|---|
| Paper size | A4, single-sided | |
| Font | Times New Roman (Unicode) | |
| Body font size | 13 | 13-14 |
| Line spacing | 1.5 | 1.3-1.5; about 6 pt between paragraphs |
| Top margin | 3.5 cm | 3-3.5 cm |
| Bottom margin | 3 cm | |
| Left margin | 3.5 cm | |
| Right margin | 2 cm | |
| Page number | centered, bottom margin | some schools put it centered in the header |
| Length of main part (master's) | | about 50-120 pages depending on school and type (some schools cap at 70 or 80 pages); usually excludes table of contents, lists, references, appendices |

Do not compress/expand character spacing to fit pages. Indent the first line of paragraphs (usually 1-1.27 cm), including the first paragraph after a heading.

## 3. Order of parts (common template)
1. Main cover (hard cover), title page (inner cover)
2. Committee/assignment information page (if the school requires it)
3. Declaration (lời cam đoan); acknowledgments (if any)
4. Vietnamese and English abstracts (many schools require them for a đề án/luận văn)
5. Table of contents
6. List of symbols and abbreviations; list of tables; list of figures
7. Introduction (Mở đầu) (or Chapter 1)
8. Content chapters
9. Conclusions and recommendations
10. List of the author's published works (if any)
11. References
12. Appendices
13. Accompanying documents as required (decision assigning the topic, reviews...)

Front-matter page numbering: per school (some use Roman numerals for the parts before the Introduction, some start numbering only from the Introduction). Check the template.

## 4. Chapters and sections
- Number with digit groups, at most 4 levels, the first number being the chapter number: 3.1.2.1.
- Each group of subsections has at least 2 items (if 2.1.1 exists, 2.1.2 must exist).
- Common formatting: chapter titles in bold uppercase (some schools use size 15, centered or left-aligned); level-2 headings bold; level 3 bold (or bold italic); level 4 italic. The table of contents usually goes down to level 3.
- Each chapter starts on a new page.

## 5. Figures, tables, equations
- Number by chapter: Hình 2.4, Bảng 3.1, equation (2.3) right-aligned.
- Table caption **above** the table, figure caption **below** the figure.
- Figure/table taken from another source: give the source right below ("Nguồn: [12]"); the source must be in the references.
- Refer by number ("Hình 3.2 cho thấy…"), not "the figure below".
- Place near the first mention; long tables may break across pages, repeating the header row.
- Text in figures must be legible when printed (equivalent to >= 8-9 pt); screenshots must be sharp.
- Long quotations (over about 4 lines): set as a separate paragraph, extra left indent, no quotation marks (per some schools).

## 6. Abbreviations
Abbreviate only phrases used many times; at first use write the full form with the abbreviation in parentheses; the list of abbreviations is alphabetical; no abbreviations in chapter titles, section titles or the abstract.

## 7. Cover
- Follow the school's cover template (usually contains: parent agency, school name, logo, student's full name, topic title, document type and program/code, place and year). A hard cover may carry a spine print: full name, document type/program, year.
- Add nothing beyond the template; keep the exact order and the uppercase/lowercase of the template.

## 8. Thesis summary (separately printed)
Some schools require a separately printed summary (about 24 pages of A4 folded in half, printed double-sided) containing the introduction, a condensed content, and the conclusions. Check the regulations.

## 9. Spelling and capitalization standards
- Capitalizing names of agencies and organizations: refer to Nghị định 30/2020/NĐ-CP, Appendix II (capitalize the first letter of words denoting type, function, field: "Bộ Giáo dục và Đào tạo", "Trường Đại học Kinh tế Quốc dân"). The decree applies to administrative documents; use it as a reference for theses.
- i/y and tone-mark placement (hoà/hòa, thuỷ/thủy): choose one style and use it consistently throughout; follow the school's regulation if there is one.

## 10. LaTeX
- Margins: `\usepackage[a4paper, top=3.5cm, bottom=3cm, left=3.5cm, right=2cm]{geometry}`.
- Times font: XeLaTeX/LuaLaTeX + `fontspec` (`\setmainfont{Times New Roman}`); Vietnamese via `babel` with `vietnamese` or `polyglossia`.
- Line spacing: `setspace` (`\setstretch{1.3}` ≈ Word's 1.5 lines with Times; measure against the school's Word template).
- Figure/table numbering by chapter: default in the `report`/`scrreprt` classes; Vietnamese labels `\renewcommand{\figurename}{Hình}`, `\tablename{Bảng}`; the period after the number per the template.
- Table of contents, lists of figures/tables: `\tableofcontents`, `\listoffigures`, `\listoftables`; Vietnamese headings via `\addto\captionsvietnamese{…}`.
- First-line indent of the first paragraph: `indentfirst`. Avoid floats drifting and creating blank pages: adjust `\topfraction`, `\floatpagefraction`.
- Check the log: no Overfull/Underfull boxes, no "Missing character".

## 11. Word
- Use Styles (Heading 1-4, Caption, Normal) instead of manual formatting; automatic table of contents and lists of figures/tables (References → Insert Table of Figures).
- Captions numbered by chapter (Insert Caption → Numbering → Include chapter number).
- Section breaks to change the page-number style (Roman/Arabic) and landscape orientation for large tables.
- Citations: Zotero/Mendeley plugin or Word's References (see `trich-dan-tai-lieu`).

## 12. Formatting check before submission
- [ ] Margins, font, size, line spacing match the school template (measure on the PDF).
- [ ] Order of parts matches the template; cover matches the template.
- [ ] Page numbers have the right style and position; table of contents matches page numbers.
- [ ] Chapters/sections/figures/tables/equations numbered continuously with no gaps; each group of sections has >= 2 subsections.
- [ ] Every figure/table is referenced in the text and has a source if taken from elsewhere.
- [ ] Length of the main part within the limit.
- [ ] PDF has fonts embedded; print a few pages as a test.
