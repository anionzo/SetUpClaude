---
name: dich-thuat-hoc-thuat
description: Translate academic text English–Vietnamese and Vietnamese–English (dịch bài báo, tóm tắt/abstract, luận văn, đề án, tài liệu tổng quan, trích dẫn nguyên văn, tên đề tài, giấy tờ học vụ) and post-edit machine or AI translations. Covers the translation workflow, sentence strategies (passive, nominalization, long clauses, information order), proper names and place names, titles, field-specific terminology (statistics, research methods, economics–management, education, biomedicine, law, IT), Vietnamese academic-affairs terms into English, hedging strength, quality criteria, and safe use of machine translation/LLMs.
---

# Academic translation

Goal of an academic translation: **same meaning and same strength of claim as the source, reads as naturally as text written directly in the target language, terminology follows the field's usage.** Vietnamese style follows `van-phong-hoc-thuat` (the table of "false friends" and basic machine-translation errors is in `van-phong-hoc-thuat/references/dich-lech.md`).

| Task | Read |
|---|---|
| Translation workflow, post-editing, using machine translation/LLMs | sections 1-3 of this file |
| Sentence transformations when translating (English→Vietnamese, Vietnamese→English) | `references/chien-luoc-cau.md` |
| Field-specific terminology | `references/thuat-ngu-nganh.md` |
| Vietnamese academic-affairs terms, school names, documents (Vietnamese→English); proper names; titles | `references/hoc-vu-ten-rieng.md` |
| Bilingual academic sentence patterns by function | `van-phong-hoc-thuat/references/mau-cau.md` |
| Multi-pass read-back-then-fix protocol and review prompts for LLM agents | `van-phong-hoc-thuat/references/llm-tu-soat.md` |

When an LLM does the translating, run an inventory pass (glossary, proper names, numbers) before translating and a read-back pass after translating, following `van-phong-hoc-thuat/references/llm-tu-soat.md`.

## 1. Principles
1. **Translate meaning, not words.** The unit of translation is the sentence and the paragraph, not the word. Split, merge and reorder sentences freely; never add or drop ideas.
2. **Preserve the strength of the claim.** may → có thể; suggest → gợi ý; show → cho thấy; prove → chứng minh. Never strengthen, never weaken.
3. **Use terminology the way the field uses it**, not the way a general dictionary does. Check Vietnamese texts in the same field (textbooks, domestic journals, recent dissertations).
4. **One term, one translation** across the whole document; build a glossary before translating.
5. **Do not touch:** figures (change only decimal/thousands conventions), formulas, proper names, code, citations, reference labels.
6. **The target reader decides the style.** An English abstract for an international committee must read as if written by an English writer; a translated literature review for Vietnamese readers must read as Vietnamese prose.
7. **Ambiguity in the source:** do not resolve it silently. Ask the author, or pick the most plausible reading and add a note.

## 2. Workflow
1. **Prepare.** Read the whole source before translating the first sentence. Identify the field, document type, readers and citation style. Build a glossary: source term | translation | reference source | note (keep English? gloss at first use?).
2. **Draft** paragraph by paragraph. Mark difficult sentences, move on, return later.
3. **Bilingual review:** compare each sentence with the source: missing ideas, extra ideas, wrong meaning, wrong strength of claim, reversed negation, reversed comparison (higher/lower, more/less), numbers.
4. **Monolingual read:** read the translation without looking at the source, as the target reader would. Rewrite every sentence that sounds translated (see `references/chien-luoc-cau.md`).
5. **Mechanical check:** numbers and units, proper names, symbols, citations [n] present and in the right place, figures/tables referenced by the correct number, capitalization per target-language conventions.
6. **Back-translate** the key sentences: contribution statements, main results, definitions. Compare meaning with the source.
7. **Second reader** (person or another model) only records comments; the translator decides.

## 3. Using machine translation and LLMs
Acceptable for drafts; **never** paste directly into the submitted text.
- Give the tool: context (field, document type, readers), the mandatory glossary, an instruction to keep numbers/citations/code, and the passage to translate (one section at a time, not a whole thesis at once).
- Typical errors to check:
  - lost or added negation ("not significantly different" → "khác biệt đáng kể");
  - reversed comparison, reversed cause–effect;
  - lost hedges (may, likely, approximately) or added assertions;
  - translated proper names, method names, dataset names ("Transformer" → "biến áp");
  - inconsistent terminology across paragraphs;
  - added sentences, examples or citations absent from the source (hallucination);
  - a "beautiful translation" that summarizes and drops details.
- Prompt template:
  ```
  Translate the following passage from English into academic Vietnamese. Field: <field>. Readers: a thesis examination committee.
  Keep unchanged: figures, formulas, citations [n], proper names, method names, code.
  Use exactly this glossary: <glossary>. For terms not in the glossary, keep the English term and mark it [?].
  Preserve the strength of claim of the source (may = có thể, suggest = gợi ý). Do not add or drop ideas.
  Write natural Vietnamese: active voice where possible, no "được… bởi", no chains of "việc/sự".
  Output in Vietnamese.
  ```
- Copyright and confidentiality: do not feed unpublished data, personal data or confidential documents into online tools without permission. Disclose the use of AI tools according to school/journal rules.
- Translating someone else's work and presenting it as your own is still plagiarism (plagiarism through translation); the source must still be cited.

## 4. Quoting with translation
- Vietnamese text quoting an English sentence: translate in the main text, add "(người viết dịch)" or "(học viên dịch)" after the quotation; the original may go in a footnote. Use the page number of the original.
- Published translation: quote the translation, and give the translator and the publisher of the translation.
- Key definitions: keep the original term in parentheses at first use.

## 5. Quality criteria (use when reviewing a translation)
| Category | Errors |
|---|---|
| Accuracy | wrong meaning, missing idea, extra idea, wrong number, wrong strength of claim, reversed negation/comparison |
| Terminology | wrong field term, inconsistency, translating what should be kept |
| Naturalness | source-language structure, unnecessary passive, stacked nominalizations, odd word order, overlong sentences |
| Style | wrong register (colloquial, self-praising), mismatch with the document type |
| Conventions | target-language decimals, dates, units, capitalization, punctuation, citations |

Record each error as: location | source sentence | translation | error category | suggestion. Fix accuracy errors before naturalness errors.
