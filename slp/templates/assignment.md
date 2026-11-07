# Bài giao việc <id hoặc tên> — <project> — rev 1
Vai: Engineer | Scout (chỉ đọc) | Reviewer (chỉ đọc) | Architect (thiết kế mù)
Task Knowns: <id | không có>

Quy tắc điền: **mọi mục phải có nội dung**; không có thì ghi "không có". Sửa bài giao thì tăng `rev`, không sửa đè.

## Mục tiêu (OUTCOME)
<kết quả cuối cùng cần đạt, một đoạn>

## Phải giữ (MUST HOLD)
<trích từ contract, decision, protocol: những điều không được vi phạm>

## Đã quyết (DECIDED), kèm lý do
<quyết định đã chốt mà Peer không bàn lại trong bài này>

## Chưa rõ (UNKNOWN)
<điều Lead cũng chưa chắc; Peer được tìm hiểu và nêu trong báo cáo>

## Phạm vi
- Được viết: <file/thư mục>
- Chỉ đọc: <file/thư mục>
- Dừng và hỏi (`DECISION_REQUEST`) nếu: <điều kiện, ví dụ cần sửa file ngoài phạm vi, cần đổi schema>

## Tiêu chí chấp nhận (AC)
1. <đo được, kiểm được>
2. ...

## Ngoài phạm vi
<việc Peer có thể thấy nhưng không được làm trong bài này>

## Kiểm chứng
- Lệnh: `<test>`, `<lint>`
- Base SHA: <ghi khi bắt đầu>

## Trả lời
Báo cáo 6 ô theo `peer.md`, loại `RESULT` | `CHALLENGE` | `DECISION_REQUEST` | `BLOCKED`, ghi vào `inbox\<tên-agent>-report.md`, dưới 4000 ký tự, rồi kết thúc lượt.
