---
name: ai-trong-hoc-thuat
description: Responsible use of generative AI / LLMs (ChatGPT, Claude, Gemini, Copilot…) in academic work — luận văn, đề án, bài báo, khóa luận, phản biện. Covers what publishers and universities allow, AI is never an author, how and where to disclose AI use (methods, acknowledgements, declaration section), AI-generated images, citing AI tools, reviewer confidentiality (do not upload manuscripts), keeping prompts/outputs, fact-checking AI output, hallucinated references, and a disclosure statement template in Vietnamese and English.
---

# Generative AI in academic work

Rules differ by venue and change often. **Always read the current policy of the target school, journal or conference before submitting**; the summary below (checked 2026-11-13) is a starting point. Related: `tim-va-kiem-nguon` (verifying references AI produces), `trich-dan-tai-lieu` (`references/loai-nguon.md`: citing AI tools), `van-phong-hoc-thuat/references/llm-tu-soat.md` (using LLMs to polish text safely).

## 1. Principles shared by all major policies
1. **AI cannot be an author.** Authorship requires accountability that only humans can take (Elsevier, Springer Nature, IEEE, ACM, ICMJE, APA, Taylor & Francis, Wiley, COPE).
2. **Humans are responsible** for every statement, number, citation and image, including those produced with AI help.
3. **Disclose substantive use** (drafting text, generating code/data/figures, analysis, literature search/summarisation). Basic spelling/grammar checking usually needs no disclosure (Elsevier, Springer Nature, IEEE), but APA journals ask to disclose even editing use — check.
4. **No AI-generated or AI-altered images** as research figures (Elsevier, Springer Nature; Wiley for evidential figures), except when AI image generation is the subject/method of the research, described in Methods.
5. **Reviewers and editors must not upload manuscripts** (or parts, or their review) into generative AI tools — confidentiality (Elsevier, Springer Nature, IEEE, APA, T&F, Wiley, ACL/ARR). Some allow AI to polish the reviewer's own wording only.
6. **Do not cite an AI chatbot as a source of facts** (ICMJE); find and cite the primary source.

## 2. Where to disclose (by publisher)
| Venue | Location |
|---|---|
| Elsevier | Separate section before the references: "Declaration of generative AI and AI-assisted technologies in the writing process" (tool, purpose, statement that authors reviewed and take responsibility) |
| Springer Nature | Methods (or equivalent section) |
| IEEE | Acknowledgments: name the system, the sections affected, the level of use |
| APA journals | Methods (and author note); describe use per section; keep prompts and outputs |
| ICMJE journals | Cover letter at submission and in the manuscript where relevant |
| ACL/ARR | Responsible NLP checklist, section on AI assistants |
| Taylor & Francis | Methods or Acknowledgments, tool name and version [unverified] |
| ACM | Policy wording in flux; disclose in acknowledgements and describe in methods if AI was part of the research [unverified] |

**Theses (luận văn, đề án):** follow the university's regulation; many Vietnamese universities now require a statement in the lời cam đoan or a separate page. If there is no rule, add a short declaration (template §4) and ask the supervisor.

## 3. Safe working practice
- Keep a log: date, tool and version, purpose, prompt, what was kept. Required by some publishers on request (APA).
- Never paste unpublished data, personal data, confidential organisational documents, or others' manuscripts into a public AI service without permission.
- Verify every factual claim and every reference AI suggests (studies measure roughly 20–55% fabricated references from chatbots; see `tim-va-kiem-nguon`).
- Use AI for: language polishing, restructuring your own draft, brainstorming outlines, explaining concepts to yourself, code assistance (review all code), translation drafts (`dich-thuat-hoc-thuat`).
- Do not use AI to: generate data or results, write the literature review from its memory, produce citations, write a peer review, or rewrite others' text to evade plagiarism checks (this is plagiarism).
- AI-paraphrased text from a source is still that source's idea: cite it.
- AI detectors are unreliable; do not rely on them to prove or disprove anything, and do not "humanise" text to evade them.

## 4. Disclosure templates
**Vietnamese (luận văn/đề án):**
> Trong quá trình thực hiện đề án, học viên sử dụng <công cụ, phiên bản> để <mục đích: rà soát chính tả và diễn đạt / gợi ý cấu trúc mã nguồn / dịch nháp tóm tắt>. Mọi nội dung do công cụ gợi ý đều được học viên kiểm tra, chỉnh sửa và chịu trách nhiệm. Công cụ không được dùng để tạo số liệu, kết quả thực nghiệm hay tài liệu tham khảo.

**English (paper):**
> During the preparation of this work the authors used <tool, version> in order to <purpose>. After using this tool, the authors reviewed and edited the content as needed and take full responsibility for the content of the publication.

When AI is part of the research method (e.g., an LLM is the system under study or a judge in evaluation), describe it in Methods with model name, version/date, parameters, and prompts (appendix) — that is not a writing-assistance disclosure. See `bao-cao-ket-qua` §5 for LLM-as-a-judge.

## 5. Peer review and supervision
- Reviewers: do not upload the manuscript; do not generate the review with AI; if allowed by the venue, AI may polish your own wording only — declare it if the venue asks.
- Supervisors/committee members reviewing a thesis: same confidentiality applies to unpublished theses.

## 6. Checklist before submission
- [ ] Read the venue's/university's current AI policy; noted the required disclosure location.
- [ ] No AI listed as author; no AI-generated research images (unless the method).
- [ ] Disclosure statement written where required.
- [ ] Every reference verified; no chatbot cited as a factual source.
- [ ] No confidential data was sent to public AI tools.
- [ ] Prompts/outputs log kept.
