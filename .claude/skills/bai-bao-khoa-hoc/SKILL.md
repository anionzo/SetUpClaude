---
name: bai-bao-khoa-hoc
description: Write, submit and revise scientific papers (bài báo khoa học; conferences, domestic and international journals), from a thesis (luận văn/đề án) or from scratch. Use when choosing a venue, building an IMRaD outline, writing title/abstract/introduction/contributions, preparing a submission (template, anonymization, page limit), writing a cover letter (thư gửi biên tập), writing a response letter to reviewers (trả lời phản biện), fixing a camera-ready version, or extracting a paper from a thesis.
---

# Scientific papers

Related skills: `van-phong-hoc-thuat` (style; its `references/llm-tu-soat.md` has the LLM read-back protocol), `trich-dan-tai-lieu` (citations), `tim-va-kiem-nguon` (verifying sources), `bao-cao-ket-qua` (figures and result tables), `dich-thuat-hoc-thuat` (writing/translating English papers).

## 1. Choose a venue
- Read the scope and the 3–5 most recent papers of the target venue: check that topic, length and level of experimentation fit.
- Check quality: indexed in Scopus/Web of Science/DOAJ, or on the list of scored journals of the Hội đồng Giáo sư nhà nước (if domestic credit is needed); conferences must have a clear proceedings publisher (IEEE, ACM, Springer LNCS/LNNS…). Avoid venues with unusually fast acceptance, high fees without peer review, or mass invitation emails (see `tim-va-kiem-nguon`).
- Record: deadline, page limit (whether references count), template (IEEEtran, LNCS, ACM acmart, Elsevier), whether review is double-blind, preprint policy (arXiv) and AI-use policy.

## 2. IMRaD outline and proportions
| Section | Suggested share (8–10 page paper) | Purpose |
|---|---|---|
| Abstract | 150–250 words | problem, method, data, results in numbers, significance |
| Introduction | 1–1.5 pages | context → gap → contributions → paper structure |
| Related work | 1 page | group by direction, state the difference explicitly |
| Method / System | 2–3 pages | enough for others to reproduce |
| Experiments / Results | 2–3 pages | setup, baselines, tables, analysis |
| Discussion / Limitations | 0.5 page | explanation, limitations, threats to validity |
| Conclusion | 1 paragraph | what was done, results, next steps |

## 3. Section by section
**Title:** state the object + method + context. No "Nghiên cứu về…", no "Một cách tiếp cận mới…", no self-praise. Under 15 words if possible.

**Abstract (6-sentence frame):** context → gap → proposal → data/evaluation approach → main result in numbers → significance or limitation. No citations, no undefined abbreviations.

**Introduction:** paragraph 1 context (no cliché openers like "Ngày nay…"); paragraph 2 the concrete problem and why existing approaches fall short (with citations); paragraph 3 the approach; a list of 2–4 contributions, each verifiable within the paper ("Chúng tôi đề xuất X; Chúng tôi xây dựng bộ dữ liệu Y gồm N mẫu; Chúng tôi đánh giá trên Z và cho thấy…"); the last sentence gives the paper structure.

**Related work:** group by direction, and end each group with a sentence comparing it to this paper. Do not list works one sentence each. Cite the closest work from the target venue itself if relevant.

**Method:** define the problem (input, output, notation), the architecture/algorithm, and enough detail to reproduce (parameters, model versions, hardware). Put the architecture figure across one page width (full-width, spanning columns).

**Experiments:** evaluation questions (RQ1, RQ2…), data (source, size, splits), fair baselines, metrics, results (main table + ablation), error analysis, qualitative examples. See `bao-cao-ket-qua`.

**Limitations / threats to validity:** data, metrics, raters, generalizability. State them plainly, in one place.

**Conclusion:** add no new results; do not copy the abstract.

## 4. Extract a paper from a thesis
- Pick ONE main contribution (do not cram in the whole thesis).
- Rewrite; do not copy paragraphs verbatim (self-plagiarism if the thesis is already published; similarity-check systems will catch it).
- Cut textbook-style theoretical background, keep the new part.
- Numbers must match the thesis; if rerun, state which run.
- Acknowledge the thesis if the venue requires it; agree the author list and order with the supervisor before submitting.

## 5. Prepare the submission
- Use the correct template; do not adjust margins/font size to dodge the page limit.
- Double-blind review: remove names, affiliations, acknowledgments, self-citations of the form "nghiên cứu trước của chúng tôi [5]" (write in third person: "Nguyễn và cộng sự [5]"), and repository links that reveal identity (use anonymous.4open.science or submit the code as an attachment).
- Check: every figure is readable when printed in black and white; every table/figure is referenced in the text; references have all required fields; no compile errors; PDF has embedded fonts (PDF/A or IEEE PDF eXpress if required).
- Declare AI use per the venue's policy (usually: do not list AI as an author; declare it if AI wrote or edited content).
- Run a similarity check before submitting (iThenticate/Turnitin if available).

## 6. Cover letter (thư gửi biên tập, journals)
One page: paper title; article type; main contribution in 2–3 sentences; why it fits the journal scope; statement that it is not submitted elsewhere; conflicts of interest; suggested/excluded reviewers (if the journal allows). Do not praise your own paper.

## 7. Response letter to reviewers (trả lời phản biện)
- Thank the reviewers briefly once at the start, not at every point.
- Copy each reviewer comment **verbatim** (numbered R1.1, R1.2…), with the response directly below it and the **location of the change** in the new version (page, section, line); mark changed content in color in the new version.
- Agree: say what was changed. Disagree: explain politely with evidence (numbers, citations), do not argue. Cannot do it (e.g. lack of data): state the reason and add it to the limitations section.
- New experiments requested: report the numbers both in the letter and in the paper.
- Keep a neutral tone: avoid "Phản biện đã hiểu sai…" → "Chúng tôi đã viết lại mục 3.2 để làm rõ…".

Template:
```
R1.3: "The baseline comparison is unfair because…"
Trả lời: Chúng tôi đồng ý. Chúng tôi đã chạy lại baseline X với cùng ngân sách truy xuất (top-k = 3) và cập nhật Bảng 4 (trang 7). Kết quả: X đạt 0,71, phương pháp đề xuất đạt 0,78.
```

## 8. Camera-ready
Restore names, affiliations, acknowledgments, funding sources; revise per the reviews; follow the publisher's format (copyright, ORCID, declarations); recheck the references; submit by the deadline.
