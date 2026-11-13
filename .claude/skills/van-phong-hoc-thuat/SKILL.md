---
name: van-phong-hoc-thuat
description: Rules for Vietnamese academic writing (văn phong học thuật): write, polish, translate and review theses (luận văn, đề án, khóa luận), papers (bài báo), scientific reports (báo cáo khoa học), proposals (đề cương), abstracts, in LaTeX or Word. Use when writing new text, chuốt văn, rà câu từ, dịch Anh–Việt / Việt–Anh, choosing whether to keep or translate a thuật ngữ, fixing dịch lệch or machine-translated Vietnamese, checking viết hoa, number formats, trích dẫn and tài liệu tham khảo, or when briefing another LLM/agent to write or polish Vietnamese academic text.
---

# Vietnamese academic writing

A rule set that makes Vietnamese academic text read naturally and precisely, in one voice, with no self-praise, no repetition and no mistranslation. It works for any writer and any tool (by hand, a single agent, several agents drafting together).

## Which file to read

| Task | Read |
|---|---|
| Write new text or polish existing text | `references/giong-van.md` |
| Decide whether to keep an English term or translate it | `references/thuat-ngu.md` |
| Translate EN→VI or VI→EN, review machine translation, fix distorted meaning | `references/dich-lech.md` |
| Capitalization, punctuation, numbers, units, abbreviations, figures/tables | `references/dinh-dang.md` |
| Citations, reference list, BibTeX/biblatex | the `trich-dan-tai-lieu` skill (`references/trich-dan.md` is only a short reminder) |
| Structure by document type (thesis, paper, abstract) | `references/cau-truc.md` |
| Review or self-check before submission | `references/kiem-tra.md` |
| Phrase bank by function (VN↔EN) | `references/mau-cau.md` |
| Common Vietnamese grammar, word-choice and spelling errors | `references/loi-tieng-viet.md` |
| Multi-pass LLM read-back-then-fix protocol; prompts for delegating polishing or translation review | `references/llm-tu-soat.md` |

## Ten core rules

1. **One voice.** The whole document reads as written by one person. Pick one way of referring to the author and keep it: theses/projects use "học viên" (or let the work be the subject: "Đề án xây dựng…"); papers use "chúng tôi" or "nhóm tác giả" (pick one). The declaration and acknowledgements use "Tôi" per the template.
2. **No self-praise, no flattery.** Drop "vượt trội", "hiệu quả cao", "đáng kể", "mạnh mẽ", "toàn diện", "tối ưu", "hiện đại", "đột phá" unless a measurement accompanies them. Replace with a number or a neutral description.
3. **Claim only as much as the evidence supports.** If measured, give the number; if not measured, say so once, in the right place. Do not write "chứng minh" when the evidence only "cho thấy"; do not hedge until the sentence is meaningless.
4. **No repetition.** State an idea once. Gather limitations and scope in one section; refer to it elsewhere. A chapter conclusion is 2–4 sentences and does not recopy the chapter body.
5. **Coherent sentences.** 15–30 words per sentence, connected with fitting connectives; no run of clipped sentences, no sprawling sentences, no colloquialisms.
6. **Consistent terminology.** One concept, one name across the whole document. Field terms normally used in English stay in English; translate only when a common Vietnamese term exists. Do not force a translation.
7. **No mistranslation.** Check meaning, nuance and structure when changing language: false friends (robust ≠ mạnh mẽ, significant ≠ đáng kể), redundant passives, stacked nominalizations, numbers and decimal separators.
8. **Capitalize the Vietnamese way.** Capitalize only sentence starts and proper nouns; headings and captions in sentence case; no English-style Title Case.
9. **Do not fabricate.** Do not invent figures, surveys, citations or names. When data is missing, mark the gap (e.g. `% TODO: …`) and tell the writer.
10. **Polishing does not change content.** Keep numbers, citations, reference labels, figures, tables, formulas, code and section structure unchanged. Length grows by no more than a few percent.

## Workflow

**Writing new text:** outline per `cau-truc.md` → write each section per `giong-van.md` → fix the terminology table at the start (`thuat-ngu.md`) → self-check (`kiem-tra.md`).

**Polishing an existing document:**
1. Skim the whole text and record: the form of self-reference in use, the terms and their variants, ideas repeated across chapters.
2. Decide: one form of self-reference, one terminology table, the single place for the limitations section.
3. Edit chapter by chapter. If several people or agents edit together, split by disjoint files and give all of them the same rule set (copy the ten core rules and the fixed terminology table into the brief).
4. Run the checks in `kiem-tra.md`, rebuild, inspect visually.
5. Independent review: another person or model reads and writes only a report using the template in `kiem-tra.md`. The writer filters the feedback (drop comments that change content or are technically wrong), then applies it.

**Translating an abstract:** finish the Vietnamese version first, translate to English per `dich-lech.md` section Việt→Anh, then read the English version independently as a native reader would.

**When an LLM does the work,** follow `references/llm-tu-soat.md` (inventory pass before editing, read-back pass, mechanical checks).

## Related skills

- `trich-dan-tai-lieu`: citations and reference lists
- `tim-va-kiem-nguon`: finding and verifying sources
- `trinh-bay-van-ban-hoc-thuat`: thesis formatting
- `dich-thuat-hoc-thuat`: translation in depth
- `bai-bao-khoa-hoc`: scientific papers
- `bao-cao-ket-qua`: reporting results (and `references/chuan-bao-cao.md`: reporting guidelines, reproducibility checklists)
- `tong-quan-tai-lieu`: literature review, systematic/scoping review, research gap
- `ai-trong-hoc-thuat`: using generative AI responsibly, disclosure statements
- `phan-bien-khoa-hoc`: peer review, thesis review reports
- `de-cuong-nghien-cuu`: research proposals, đề cương, grant proposals
- `bao-ve-luan-van`: defense, slides, answering the committee

## Safe file writing (LaTeX)
Edit `.tex` and `.bib` with direct file-editing tools. Avoid shell heredocs or string-replacement scripts on text containing `\`: sequences such as `\f`, `\b`, `\a`, `\t` easily become control characters (`\footnotesize` → `ootnotesize`). After editing, search for control characters: `grep -nP '[\x00-\x08\x0B\x0C\x0E-\x1F]' *.tex`.
