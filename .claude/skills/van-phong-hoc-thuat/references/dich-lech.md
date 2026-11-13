# Distorted translation (dịch lệch)

"Dịch lệch" is when a translation is right word by word but wrong in meaning or nuance, or carries the structure of the source language so the sentence sounds foreign. There are four kinds: meaning distortion, nuance/degree distortion, structure distortion, convention distortion (numbers, dates, units, capitalization).

## 1. Meaning distortion: false friends

| English | Common bad rendering | Correct meaning in academic writing |
|---|---|---|
| significant (statistically) | đáng kể | có ý nghĩa thống kê. Without a test, do not use it |
| robust | mạnh mẽ | bền vững, ổn định trước nhiễu/thay đổi đầu vào |
| performance | hiệu suất (everywhere) | hiệu năng (speed, resources) or kết quả/chất lượng (accuracy). Separate the two senses |
| efficient / effective | hiệu quả (both) | efficient: saves resources; effective: meets the goal. "hiệu quả về chi phí" vs "đạt mục tiêu" |
| accuracy / precision | độ chính xác (both) | accuracy: độ chính xác; precision: Precision/độ chuẩn xác |
| recall | thu hồi, nhớ lại | Recall/độ phủ |
| feature | tính năng (in ML) | đặc trưng (ML); tính năng (software) |
| instance | ví dụ | thể hiện, bản chạy (machine/service); mẫu (data) |
| application | ứng dụng (everywhere) | ứng dụng (software); việc áp dụng; đơn (application form) |
| agent | đại lý | tác tử, agent |
| model | người mẫu, mô hình (everywhere) | mô hình (ML); kiểu/mẫu (product) |
| issue | phát hành | vấn đề; lỗi (on GitHub) |
| address (a problem) | địa chỉ | giải quyết, xử lý |
| propose | cầu hôn, đề nghị | đề xuất |
| suggest (results) | đề nghị | gợi ý, cho thấy (weak) |
| evidence | chứng cứ (legal) | bằng chứng |
| eventually | cuối cùng thì (conclusion) | sau một thời gian, rốt cuộc (process) |
| actually | thực tế (everywhere) | thật ra; often can be dropped |
| novel | tiểu thuyết, mới lạ | mới; usually drop (self-praise) |
| state-of-the-art | hiện đại nhất | tốt nhất hiện công bố (with source, year) |
| leverage | đòn bẩy | tận dụng, sử dụng |
| handle | tay cầm | xử lý |
| support | ủng hộ | hỗ trợ |
| validate / verify | xác nhận (both) | validate: kiểm định đúng nhu cầu; verify: kiểm tra đúng đặc tả |
| deployment | sự triển khai quân | triển khai (system) |
| scope | phạm vi, tầm nhìn | phạm vi |
| framework | khuôn khổ (legal) | khung, framework |
| baseline | đường cơ sở | mốc so sánh, phương pháp cơ sở |
| ablation study | nghiên cứu cắt bỏ | thí nghiệm lược bỏ thành phần |
| ground truth | sự thật mặt đất | nhãn chuẩn |
| in-context learning | học trong ngữ cảnh | keep, or "học từ ví dụ trong prompt" |
| attention | sự chú ý | cơ chế attention |
| fair, fairness | hội chợ | công bằng |
| sample | mẫu thử (food) | mẫu (data) |
| control (group) | điều khiển | nhóm đối chứng |
| environment | môi trường (ecology) | môi trường (runtime, development) |

## 2. Nuance and degree of claim

| English | Wrong degree | Right degree |
|---|---|---|
| may, might | sẽ | có thể |
| suggest | chứng minh | gợi ý |
| indicate, show | chứng minh | cho thấy |
| demonstrate | chứng minh (when it is only an example) | minh họa / cho thấy |
| prove | cho thấy | chứng minh (only with a proof) |
| likely | chắc chắn | nhiều khả năng |
| approximately, about | — (lost) | khoảng, xấp xỉ |
| up to 30% | 30% | tới 30% (maximum value, not the average) |
| at least / at most | — | ít nhất / nhiều nhất |
| outperform | vượt trội | cao hơn (with numbers) |
| comparable | tương đương | gần với (with the gap) |
| promising | đầy hứa hẹn | drop, or give numbers |

The reverse direction works the same way: "cho thấy" → show/indicate, not "prove".

## 3. Structure distortion: machine-translated prose

| Symptom | Bad example | Fix |
|---|---|---|
| Redundant passive "được… bởi" | Dữ liệu được thu thập bởi hệ thống. | Hệ thống thu thập dữ liệu. |
| Wrong "bị/được" nuance | Mô hình bị huấn luyện trên… | Mô hình được huấn luyện trên… (or active voice) |
| Stacked nominalization "việc", "sự" | Việc thực hiện sự đánh giá của mô hình… | Đánh giá mô hình… |
| Chain of "của" | Độ chính xác của kết quả của mô hình của đề án | Độ chính xác của mô hình đề xuất |
| Redundant article "một" | Đây là một phương pháp mà một hệ thống… | Đây là phương pháp mà hệ thống… |
| "Nó" replacing a thing | Nó trả về kết quả. | Dịch vụ trả về kết quả. |
| Vague "Điều này" | Điều này giúp… | Việc tách bước X giúp… (name the referent) |
| Redundant "Thông qua", "đối với" | Đối với mô hình, nó cho kết quả… | Mô hình cho kết quả… |
| Sentence-initial "Bằng cách" | Bằng cách sử dụng BM25, hệ thống… | Hệ thống dùng BM25 để… |
| "Trong khi" with the wrong sense (while = còn) | Trong khi A tốt, B kém. | A tốt, còn B kém. / Ngược lại, B kém. |
| Redundant plural | Các những mô hình | Các mô hình |
| English modifier order | Lớn ngôn ngữ mô hình | Mô hình ngôn ngữ lớn |
| Cliché opening | Trong bối cảnh hiện nay, với sự phát triển mạnh mẽ của… | Go straight to the point |
| Repeated "Có thể" | Hệ thống có thể có khả năng… | Hệ thống có thể… |
| Compound sentence too long, English syntax | (one 50-word sentence with 3 "mà" clauses) | Split into 2–3 sentences |
| Literal preposition | phụ thuộc vào trên | phụ thuộc vào |
| English-style countable nouns | các thông tin, các dữ liệu | thông tin, dữ liệu |

## 4. Convention distortion

| Item | Vietnamese | English |
|---|---|---|
| Decimal | 4,95 | 4.95 |
| Thousands | 1.250; 10.480 | 1,250; 10,480 |
| Percent | 99,0% (or "99,0 phần trăm") | 99.0% |
| Range | 1 đến 5; 1–5 | 1 to 5; 1–5 |
| Date | 25/9/2026; ngày 25 tháng 9 năm 2026 | September 25, 2026; 2026-09-25 |
| Units | 512 MB, 3,2 giây (with a space) | 512 MB, 3.2 s |
| Heading capitalization | Sentence case | Title Case for paper titles (depending on style), section headings |
| Quotation marks | “…” | “…” |
| Page numbers in citations | tr. 12–15 | pp. 12–15 |

When translating an abstract into English, convert decimal and thousands separators. Numbers in tables and figures of the Vietnamese part keep Vietnamese conventions.

## 5. Vietnamese → English (abstract, English-language paper)

- **Voice:** choose "we" (multi-author papers) or "this thesis/this study" and keep it; do not mix "the author" and "we".
- **Tense:** present for facts and the content of the paper ("This thesis presents…"); past for what was done and measured results ("We evaluated… The system achieved…").
- **Articles:** a/an/the in the right places; uncountable nouns: information, data (often plural in academic writing: "data are"), research, software, equipment, feedback, knowledge (no added s).
- **Wrong literal renderings:** "researches" → studies; "datas" → data; "softwares" → software; "an useful" → a useful; "make experiment" → conduct experiments; "discuss about" → discuss; "according with" → according to; "in the other hand" → on the other hand.
- **Hard-to-translate Vietnamese terms:** đề án thạc sĩ → master's project (application-oriented); khóa luận → undergraduate thesis; học viên → the author/student; phòng ban → administrative units/departments; đơn vị (tenant) → tenant.
- **Avoid** very, really, a lot of, nowadays, in recent years (cliché openings), sentence-initial so, etc. in academic lists.
- **Independent read:** read the English version without looking at the Vietnamese; if a native speaker would not write a sentence that way, rewrite it by meaning, not by words.

## 6. Procedure for reviewing a translation
1. Read the translation alone, without the source: mark any sentence that sounds odd.
2. For each marked sentence, compare with the source: is it a meaning, nuance, structure or convention distortion?
3. Terms: check the table in `thuat-ngu.md`; if absent, look at usage in documents of the same field.
4. Quick back-translation of important sentences (contributions, main results): translate back into the source language and compare meaning.
5. Numbers: convert decimal and thousands conventions; check every number against the source.
6. If unsure, keep the original term in parentheses at first use.
