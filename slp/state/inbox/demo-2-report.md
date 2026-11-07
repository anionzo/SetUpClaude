# Báo cáo demo-2

Nhánh/commit: không có thay đổi nào. Đây là bài chạy thử, không sửa code, không commit. Thư mục làm việc không phải git repo.

## 1. Các file trong `slp/roles/`

- `lead.md`: vai trò Lead, điều phối và ra quyết định; không tự viết code tính năng, giữ trạng thái trong `slp/state/`.
- `peer.md`: vai trò Peer, thực thi code và test trong worktree riêng; báo cáo vào `slp/state/inbox/`.
- `supervisor.md`: vai trò Supervisor, giám sát các session `slp-*`, không viết code, chỉ đặt câu hỏi trung tính khi có dấu hiệu bất thường.

## 2. Tin nhắn hội thoại trước đó

Không có. Ngoài prompt khởi tạo (bắt đầu bằng "You are SLP peer 'demo-2'"), tôi không thấy tin nhắn hội thoại nào trước đó. Tin nhắn đầu tiên tôi nhận là khối `<paseo-system ...>` chứa prompt khởi tạo, nên không có dòng nào để chép nguyên văn.

## Ghi chú

- Đã đọc `slp/roles/peer.md` và `slp/state/inbox/task-demo-2.md`.
- `peer.md` yêu cầu đọc `slp/state/contract.md`, `decisions.md` và `tasks.md` trước khi làm. Cả ba file không có trong `slp/state/` (Glob `slp/state/*.md` chỉ thấy `agents.md`), nên tôi không đọc được. Việc này không ảnh hưởng kết quả bài demo vì không sửa code.
