# English – Vietnamese terminology: keep or translate

## Principles
1. **If people in the field say it in English, keep English.** Translating a word nobody in the field uses makes the sentence sound odd and hard to search for.
2. **If a common, natural Vietnamese term exists, translate.** Examples: "truy xuất", "chỉ mục", "hàng đợi", "mô hình ngôn ngữ lớn".
3. **At first occurrence** (per chapter in a long thesis): give a short explanation or the other form in parentheses, e.g. "xếp hạng lại (rerank)" or "pipeline (chuỗi bước xử lý được khai báo)". After that use one form.
4. **One concept, one name** across the whole document. Build a terminology table before writing or polishing; when several people write, give the table to everyone.
5. **Do not mix forms**: not "embedding" in chapter 3 and "nhúng" in chapter 5, not "tenant" in the table and "đơn vị" in the body.
6. **Proper names, products, functions, files, commands** keep their original spelling (OpenSearch, gRPC, `handle_upload`); code goes in code formatting.
7. **Do not add plural "s"** to English words kept as-is: "các worker", not "các workers".
8. **Do not italicize** English terms already in common use; italicize at first introduction only if the school's rules require it.

## Table: keep in English

| Term | Avoid translating as | Note |
|---|---|---|
| pipeline | đường ống, dây chuyền | first time: "chuỗi bước xử lý" |
| worker | công nhân, tiến trình thợ | |
| gateway, API gateway | cổng vào, cổng nối | "cổng API" acceptable if consistent |
| tenant, multi-tenant | đơn vị thuê, người thuê | explain at first use; "đa tenant" |
| embedding | nhúng, véc-tơ nhúng | "vector embedding" |
| chunk, chunking | khúc, tách đoạn | "đoạn" acceptable if consistent |
| token | thẻ, mã thông báo | |
| prompt, system prompt | lời nhắc, câu lệnh gợi ý | "lời nhắc" acceptable if consistent |
| streaming | phát luồng, truyền dòng | "trả kết quả dạng streaming" |
| rerank, reranker | khử trùng xếp hạng lại | "xếp hạng lại" acceptable if consistent |
| trace, span, tracing | vết thực thi, khoảng | |
| cache | bộ nhớ đệm | "bộ nhớ đệm" usable, pick one |
| microservice | vi dịch vụ | |
| framework | khung sườn | "khung" or keep framework |
| benchmark | điểm chuẩn | "bộ đánh giá chuẩn" if needed |
| baseline | đường cơ sở | "mốc so sánh" |
| fine-tune | điều chỉnh mịn | "tinh chỉnh" is already common, usable |
| zero-shot, few-shot | không phát bắn | |
| LLM-as-a-judge | người chấm tự động | first time: "dùng LLM làm người chấm" |
| groundedness | độ bám đất | explain at first use: "mức câu trả lời dựa trên ngữ cảnh truy xuất" |
| hallucination | ảo tưởng | "ảo giác" is already common; or "sinh nội dung không có căn cứ" |
| control plane, data plane | mặt phẳng điều khiển | keep English or "lớp điều khiển", "lớp dữ liệu" |
| endpoint | điểm cuối | "endpoint" or "đường dẫn API" |
| deploy, rollback | | "triển khai" usable for deploy |
| commit, branch, merge | | |
| container, image (Docker) | thùng chứa, ảnh | |
| dashboard | bảng đồng hồ | "bảng điều khiển" usable |
| enrichment | làm giàu | "bổ sung thông tin (enrichment)" |
| dedupe, deduplication | khử trùng | "loại bỏ trùng lặp" |
| batch | mẻ | "theo lô" usable |
| agent (AI) | đại lý | "tác tử" is already common in academic writing; "agent" in technical writing. Pick one |

## Table: translate

| English | Vietnamese |
|---|---|
| retrieval | truy xuất |
| index, indexing | chỉ mục, lập chỉ mục |
| query | truy vấn |
| large language model | mô hình ngôn ngữ lớn (LLM) |
| retrieval-augmented generation | sinh có truy xuất (RAG); or keep RAG |
| inference | suy luận |
| training, pre-training | huấn luyện, tiền huấn luyện |
| dataset | bộ dữ liệu |
| corpus | kho văn bản, kho ngữ liệu |
| feature (ML) | đặc trưng |
| feature (software) | tính năng |
| label, annotation | nhãn, gán nhãn |
| ground truth | nhãn chuẩn, đáp án chuẩn |
| evaluation, metric | đánh giá, chỉ số / độ đo |
| accuracy | độ chính xác |
| precision, recall | keep Precision, Recall (or độ chuẩn xác, độ phủ; pick one) |
| latency, throughput | độ trễ, thông lượng |
| concurrency | độ đồng thời, số yêu cầu đồng thời |
| scalability | khả năng mở rộng |
| availability, reliability | tính sẵn sàng, độ tin cậy |
| queue, message queue | hàng đợi, hàng đợi thông điệp |
| router, routing | bộ định tuyến, định tuyến |
| orchestrator, orchestration | bộ điều phối, điều phối |
| scheduler | bộ lập lịch |
| use case, actor | ca sử dụng, tác nhân |
| requirement (functional/non-functional) | yêu cầu (chức năng/phi chức năng) |
| architecture, component, module | kiến trúc, thành phần, mô-đun |
| interface, contract | giao diện, hợp đồng (giao tiếp) |
| configuration | cấu hình |
| threshold | ngưỡng |
| trade-off | đánh đổi |
| bottleneck | nút thắt |
| edge case | trường hợp biên |
| robustness | độ bền vững, khả năng chịu nhiễu |
| security, privacy | bảo mật, quyền riêng tư |
| authentication, authorization | xác thực, phân quyền |
| rate limit, quota | giới hạn tần suất, hạn mức |
| log, logging, monitoring | nhật ký (or log), ghi log, giám sát |
| test, unit test | kiểm thử, kiểm thử đơn vị |

## Quick check for a term
- Look in 3–5 recent Vietnamese theses/papers in the same field: which form do they use?
- Read the sentence aloud: would someone in the field say it that way in a presentation?
- If still unsure: keep English and explain it at first use.
