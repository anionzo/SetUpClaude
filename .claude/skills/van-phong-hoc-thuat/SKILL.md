---
name: van-phong-hoc-thuat
description: Quy tắc văn phong học thuật tiếng Việt cho đề án, luận văn, bài báo, báo cáo khoa học, khóa luận, đề cương (LaTeX hoặc Word). Dùng khi viết mới, chuốt văn, review câu từ, giao việc viết cho Peer, hoặc soát danh mục tài liệu tham khảo. Gồm giọng một người viết, không tự khen, không lặp ý, câu mạch lạc, thuật ngữ Anh–Việt (giữ hay dịch), viết hoa, trích dẫn IEEE với biblatex, và quy trình kiểm.
---

# Văn phong học thuật tiếng Việt

Rút từ đợt chuốt đề án thạc sĩ `de-an-mas-huit` (user chốt 2026-11-13). Áp dụng cho mọi bài viết học thuật tiếng Việt: đề án, luận văn, khóa luận, bài báo, báo cáo, đề cương. Khi giao việc viết cho Peer, chép mục "Quy tắc" dưới đây vào brief (Peer không tự đọc skill của kho khác).

## Quy tắc

### 1. Một người viết, một giọng
- Cả văn bản đọc như do MỘT người viết, dù nhiều agent cùng soạn.
- Chính văn: người thực hiện gọi là **"học viên"** (đề án, luận văn) hoặc **"tác giả"/"nhóm tác giả"** (bài báo); không trộn "tôi", "chúng tôi", "người viết". Ưu tiên để công việc hoặc sự vật làm chủ ngữ: "Đề án xây dựng…", "Hệ thống tách…".
- Ngoại lệ: **Lời cam đoan** và **Lời cảm ơn** viết ngôi thứ nhất "Tôi" theo mẫu chuẩn ("Tôi xin cam đoan…"). Không viết "Học viên xin cam đoan".
- Dùng "đề án" cho đề án thạc sĩ định hướng ứng dụng, không "luận văn".

### 2. Không nịnh, không tự khen
- Bỏ từ đánh giá cảm tính khi không có số đo đi kèm: vượt trội, hiệu quả cao, rất tốt, đáng kể, mạnh mẽ, toàn diện, tối ưu, linh hoạt, hiện đại, góp phần quan trọng, hoạt động ổn định.
- Thay bằng số liệu cụ thể hoặc mô tả trung tính ("đạt 1.738/1.755 ca", "tập trung vào…").
- Không khen chung chung công trình người khác ("nổi tiếng", "đột phá").
- Không bịa số liệu, khảo sát, người dùng, tên cán bộ. Thiếu dữ kiện thì ghi `% TODO(user): …`, không đoán.

### 3. Không lặp
- Một ý đã nói thì không nói lại ở câu sau, đoạn sau hay mục sau (kể cả kiểu "như đã nói ở trên", câu kết đoạn nhắc lại câu mở đoạn).
- Giới hạn, phạm vi, "chưa đo/chưa đánh giá": nêu đầy đủ ở MỘT mục (thường là mục Hạn chế/Giới hạn của chương thực nghiệm và chương kết luận). Chỗ khác dẫn chiếu bằng `\ref`.
- Kết luận chương: 2–4 câu tóm điều chương đã làm và nối sang chương sau; không chép lại câu của thân chương.
- Tóm tắt/Abstract: mỗi giới hạn một câu.

### 4. Câu mạch lạc
- Văn học thuật tiếng Việt, không khẩu ngữ, không dịch máy. Mục tiêu 15–30 từ/câu.
- Không viết chuỗi câu cụt rời rạc; nối ý bằng từ nối hợp lý: do đó, vì vậy, trong khi đó, cụ thể, bên cạnh đó, tuy nhiên, ngược lại.
- Không viết câu lê thê nhiều tầng mệnh đề.
- Sửa cấu trúc câu kiểu tiếng Anh: "Đề án vay khái niệm này" → "Đề án kế thừa khái niệm này"; "Câu hỏi được phép trả lời bằng số là" → "Câu hỏi mà chương này trả lời bằng số liệu là"; "bộ não của tác tử" → "thành phần suy luận chính".

### 5. Thuật ngữ Anh – Việt: giữ hay dịch
Nguyên tắc: **dân CNTT Việt Nam quen nói tiếng Anh thì giữ tiếng Anh; chỉ dịch khi đã có từ tiếng Việt phổ biến, tự nhiên.** Dịch gượng (từ ghép mới, không ai trong ngành dùng) làm văn nghe lạ.
- Lần đầu xuất hiện trong chương: có thể kèm giải thích ngắn hoặc dạng kia trong ngoặc. Sau đó dùng MỘT cách gọi cho toàn văn bản.
- Tên riêng, tên sản phẩm, tên hàm, tên tệp, mã: giữ nguyên, đặt trong `\texttt{}` nếu là mã.

| Giữ tiếng Anh (không dịch gượng) | Không viết |
|---|---|
| pipeline, worker, gateway, tenant | "đường ống", "công nhân", "cổng vào"*, "đơn vị thuê" |
| embedding, chunk/chunking, token, streaming | "nhúng", "tách đoạn"*, "thẻ", "phát luồng" |
| rerank, trace, span, prompt, cache | "khử trùng + xếp hạng lại", "vết thực thi", "lời nhắc"* |
| control plane / data plane | "mặt phẳng điều khiển" (giữ tiếng Anh hoặc viết "lớp điều khiển") |
| LLM-as-a-judge, groundedness, enrichment | "người chấm tự động"*, "độ bám nguồn"*, "làm giàu" |
| microservice, multi-agent, API, endpoint | "vi dịch vụ", "điểm cuối"* |

| Dịch (đã có từ Việt quen dùng) |
|---|
| retrieval → truy xuất; index → chỉ mục; large language model → mô hình ngôn ngữ lớn (LLM) |
| queue → hàng đợi; routing/router → định tuyến/bộ định tuyến; orchestrator → bộ điều phối |
| evaluation → đánh giá; dataset → bộ dữ liệu; use case → ca sử dụng; requirement → yêu cầu |
| latency → độ trễ; throughput → thông lượng; concurrency → độ đồng thời; threshold → ngưỡng |

`*` = chấp nhận được nếu cả văn bản dùng thống nhất và đã giải thích ở lần đầu; nếu nghe gượng trong ngữ cảnh thì dùng tiếng Anh. Khi một dự án đã chốt bảng thuật ngữ riêng (vd. từ báo cáo review), bảng đó ưu tiên hơn bảng này; nhớ cập nhật skill nếu bảng mới tốt hơn.

### 6. Viết hoa
- Tiếng Việt chỉ viết hoa chữ đầu câu và tên riêng. Không viết hoa từ thường giữa câu ("Mô hình Ngôn ngữ Lớn", "Bộ Điều Phối", "Worker").
- Tên cơ quan: hoa chữ đầu mỗi thành phần tên riêng: "Trường Đại học Công Thương TP.HCM", "Bộ Công Thương", "Khoa Công nghệ thông tin". "Trường" viết hoa khi thay cho tên trường cụ thể.
- Tiêu đề mục, chú thích hình/bảng, tiêu đề cột: kiểu câu (chỉ hoa chữ đầu và tên riêng), không Title Case kiểu tiếng Anh.
- Sau dấu hai chấm: viết thường, trừ tên riêng hoặc câu trích trọn vẹn.
- Danh sách liệt kê: thống nhất trong một danh sách (mục là câu hoàn chỉnh: hoa đầu + dấu chấm; mục là cụm từ: thường, không chấm).
- Tiêu đề chương in hoa do template tự làm (`\MakeUppercase`), không gõ tay chữ hoa trong nguồn.

### 7. Tài liệu tham khảo (IEEE, biblatex)
- Tên bài/chương/trang web: **sentence case** (hoa chữ đầu, chữ đầu sau dấu hai chấm, tên riêng, viết tắt). Trong `.bib` bọc phần phải giữ hoa: `{NLP}`, `{LLM}`, `{Vietnamese}`, `{AutoGen}`. Tên tạp chí, hội nghị, sách giữ Title Case.
- Chỉ thêm nguồn đã mở được trang/DOI/arXiv. Mỗi Peer một file `refs-<peer>.bib`.
- biblatex-ieee chỉ khai chuỗi cho `english`; khi văn bản dùng babel `vietnamese` phải khai lại:
  ```latex
  \DefineBibliographyStrings{vietnamese}{artno = {Art. no.}, url = {[Online]. Available}, urlseen = {Accessed:}}
  \DeclareFieldFormat{pages}{\mkpageprefix[bookpagination]{#1}}   % bỏ dấu cách ngăn nghìn "13 782"
  \appto{\bibsetup}{\raggedright}
  ```

### 8. Giữ nguyên khi chuốt văn
Số liệu, run id, `\cite`, `\ref`, `\label`, hình, bảng (nội dung ô), công thức, code, cấu trúc mục. Độ dài không tăng quá 3% (ưu tiên giảm nhờ bỏ lặp). Ghi file bằng Edit/Write, không dùng heredoc bash hay script thay chuỗi có dấu `\` (dễ hỏng `\f`, `\b`, `\a`).

## Quy trình
1. **Viết/chuốt:** chia theo chương cho Peer Claude (Sonnet), mỗi Peer một nhóm file rời nhau, brief chứa mục "Quy tắc". Một Peer riêng cho `.bib` nếu cần.
2. **Kiểm máy** (chạy trong repo):
   ```powershell
   # xưng hô lẫn lộn
   Select-String -Path chapters\*.tex -Pattern 'chúng tôi| tôi |người viết|tác giả' -CaseSensitive:$false
   # từ cảm tính
   Select-String -Path chapters\*.tex -Pattern 'vượt trội|đáng kể|mạnh mẽ|toàn diện|tối ưu|hiệu quả cao|rất tốt'
   # từ thường viết hoa giữa câu (lọc tay kết quả, phần lớn là tên riêng)
   Select-String -Path chapters\*.tex -Pattern '(?<=[\p{Ll},;] )\p{Lu}\p{Ll}+' -CaseSensitive -AllMatches
   ```
   Build sạch (không Overfull/Underfull/undefined), xem PDF bằng mắt vài trang mỗi chương và trang tài liệu tham khảo.
3. **Review độc lập:** một agent khác họ mô hình, chỉ đọc, ghi báo cáo (vd. `slp.ps1 run <project> <brief> -Name review-gemini -Provider antigravity -Model gemini-3.8-flash-high`). Báo cáo gồm: nhận xét chung, bảng phát hiện theo mức nặng (file:dòng, câu gốc, tiêu chí, đề xuất), chỗ lặp giữa các chương, bảng thuật ngữ đề xuất.
4. **Áp dụng:** nhạc trưởng lọc góp ý (bỏ góp ý đổi nội dung hoặc sai kỹ thuật), chốt bảng thuật ngữ, giao Peer áp dụng đồng loạt, build, xem, commit.
