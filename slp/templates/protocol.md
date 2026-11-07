# Giao thức project: <tên>
status: draft · version: 1 · reviewed: <yyyy-mm-dd> · owner: người dùng

Giữ file này **dưới 40 dòng**. Lead đọc trước khi giao việc và trích các dòng liên quan vào bài giao. Peer đọc một lần khi bắt đầu.

## Đặc điểm
- Stack: <ngôn ngữ, framework, DB>
- Nhạy cảm: <dữ liệu thật? production? người dùng thật?>
- Knowns: <có | không>

## Thẩm quyền
- Người dùng quyết: contract, merge vào nhánh chính, deploy, xóa dữ liệu, chi phí lớn, đóng task `done`.
- Lead quyết: chia việc, chọn provider/model, chấp nhận candidate.
- Peer: chỉ trong phạm vi bài giao; vượt thì `DECISION_REQUEST`.

## Lớp việc và định tuyến
- Nhỏ, giới hạn rõ → Sonnet hoặc Gemini Flash; một Peer.
- Xuyên module, nhạy lifecycle → Sonnet; review độc lập khác họ model.
- Khóa kiến trúc → thiết kế mù 2 Peer, Lead chấm.
- Trinh sát chỉ đọc → Haiku hoặc Flash low.

## Sở hữu và không gian làm
- Nhánh làm việc: <quy ước tên nhánh>; nhánh chính: <main/master>.
- Song song → mỗi Peer một worktree, phạm vi file không giao nhau.
- Cấm đụng: <thư mục/file, ví dụ migrations đã chạy, secrets, config production>.

## Kiểm chứng
- Test: `<lệnh>` · Lint: `<lệnh>` · Build: `<lệnh>`
- Báo cáo phải kèm lệnh đã chạy, exit code và output thật.

## Anti-pattern của project
- <ví dụ: "sửa luôn chỗ thấy tiện", "tắt test đang fail", "đổi schema không có migration">

## Tiến hóa
- Sửa file này: Lead đề xuất, người dùng duyệt, tăng `version` và cập nhật `reviewed`.
