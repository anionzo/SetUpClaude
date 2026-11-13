# Voice and tone

## 1. Self-reference and sentence subject

| Document type | Main text | Separate pages |
|---|---|---|
| Thesis, project report, undergraduate thesis | "học viên"/"sinh viên", or let the work be the subject ("Đề án đề xuất…", "Chương này trình bày…") | Declaration, acknowledgements: "Tôi" |
| Paper | "chúng tôi" (common) or "nhóm tác giả"; pick one. "Bài báo", "nghiên cứu này" as subject | — |
| Technical report | subject is the system/team/document ("Tài liệu này mô tả…") | — |

- Do not mix "tôi", "chúng tôi", "người viết", "tác giả", "học viên" in the same main text (a single-author thesis does not use "chúng tôi").
- Prefer a thing or a piece of work as the subject. Use a person as the subject only when the action really is the writer's (collecting data, interviewing, making a design choice).
- No "ta", "mình", "các bạn", "chúng ta" (except in textbooks).
- One name for the document: "đề án" or "luận văn" or "khóa luận" according to the actual type; do not switch back and forth.

## 2. No self-praise, no flattery

Words to drop or replace when no measurement accompanies them:

| Avoid | Replace with |
|---|---|
| vượt trội, tốt hơn hẳn | "cao hơn X điểm so với…" |
| hiệu quả cao, rất hiệu quả | a concrete measure, or "đạt mục tiêu đặt ra là…" |
| đáng kể (without a test) | "tăng từ A lên B"; use "đáng kể" only with a statistical test |
| mạnh mẽ, vững chắc | describe the mechanism ("chịu được lỗi mất một nút") |
| toàn diện, đầy đủ | list the scope actually covered |
| tối ưu | "tốt nhất trong các cấu hình đã thử" |
| hiện đại, tiên tiến, đột phá, mới mẻ | drop, or give the year/specific difference |
| linh hoạt, dễ dàng mở rộng | describe what extending requires ("thêm một tệp YAML") |
| góp phần quan trọng, có ý nghĩa to lớn | state the specific contribution |
| hoạt động ổn định | "không lỗi trong N lần chạy" |
| nổi tiếng, hàng đầu (about other work) | cite, drop the adjective |

Also drop disguised self-praise: "Đây là một hướng tiếp cận rất triển vọng", "Kết quả cho thấy tính đúng đắn của giải pháp" (when there is only one measurement).

## 3. Claim only as much as the evidence supports

| Evidence available | Verb to use |
|---|---|
| Mathematical proof | chứng minh |
| Controlled experiment, statistical test | cho thấy, xác nhận (trong điều kiện…) |
| One measurement, no control | ghi nhận, đo được |
| Qualitative observation, a few examples | gợi ý, minh họa |
| Reasoning, not measured | dự kiến, có thể, giả thuyết là |

- State the conditions of the result: which data, which configuration, how many samples.
- Do not stack hedges: "có thể phần nào góp phần giúp cải thiện" → "có thể cải thiện".
- State a limitation once, in the Limitations section; elsewhere refer to it ("xem mục 6.8").

## 4. No repetition

Common forms of repetition and how to handle them:

| Form | Fix |
|---|---|
| A closing sentence restates the opening sentence of the paragraph | drop the closing sentence, or replace it with a new idea (consequence, bridge to the next paragraph) |
| "Như đã trình bày ở trên…" followed by restating | cross-reference only, do not restate |
| Chapter opening lists the contents, chapter ending lists them again | opening 2–3 sentences, ending 2–4 sentences stating results, no re-listing |
| The same limitation repeated in the abstract, introduction, experiments and conclusion | 1 sentence in the abstract, full Limitations section, cross-reference elsewhere |
| The same number given in the body, figure captions and tables | the number lives in the table; the body states only the most important number and interprets it |
| A concept defined in two chapters | define it in the theory chapter, later chapters refer to it |
| Two adjacent sentences with the same idea in different words | merge |

## 5. Sentences and paragraphs

- One main idea per paragraph; the first sentence states it (topic sentence), the following sentences develop it.
- Sentences of 15–30 words. Many consecutive sentences under 10 words read jerkily; over 40 words, split.
- Connectives by relation:
  - cause – effect: do đó, vì vậy, nhờ đó, dẫn đến
  - contrast: tuy nhiên, ngược lại, trong khi đó, mặc dù
  - addition: bên cạnh đó, ngoài ra, đồng thời
  - specification: cụ thể, chẳng hạn, ví dụ
  - order: trước hết, tiếp theo, sau cùng
  Do not open every sentence with a connective; do not overuse "Ngoài ra".
- Keep list items parallel ("thu thập…, làm sạch…, gán nhãn…" not "thu thập…, việc làm sạch…, nhãn được gán…").

## 6. Colloquial → academic

| Colloquial, machine translation | Academic |
|---|---|
| vay khái niệm | kế thừa khái niệm |
| bộ não của hệ thống | thành phần suy luận chính |
| chạy ngon, chạy ổn | hoạt động đúng yêu cầu (with conditions) |
| làm cái việc này | thực hiện công việc này |
| cứng (hard-code) | cố định trong mã |
| nhìn chung là ổn | đạt các ngưỡng đã đặt |
| thằng service này | dịch vụ này |
| bắn request | gửi yêu cầu |
| ra kết quả | trả về kết quả |
| khá là, hơi bị, cực kỳ | drop, or use a number |
| rất nhiều | give a number, or "nhiều" |
| Câu hỏi được phép trả lời bằng số là: | Câu hỏi mà chương này trả lời bằng số liệu là: |

## 7. What stays unchanged when polishing
Numbers, run identifiers, citations, reference labels, figures, tables (cell contents), formulas, source code, section structure. Section headings get only spelling/capitalization fixes. Add no new claims and no new sources.
