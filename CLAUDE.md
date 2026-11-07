# SetUpClaude: bộ công cụ SLP

> **Đã chuyển (2026-11-07):** bộ công cụ SLP chính thức giờ nằm trong `D:\CODE\Supervision` (`slp.ps1`, `slp\roles\`, `slp\templates\`, `docs\slp\README.md`). Đọc và chạy từ đó: `D:\CODE\Supervision\slp.ps1 ...`. Các file ở repo này là bản sao đồng bộ ngày 2026-11-07, không sửa ở đây.
>
> **Quy tắc mới (người dùng chốt 2026-11-07): MỘT workspace Paseo, MỘT worktree cho mỗi project.**
> - Agent luôn chạy trong repo project hoặc worktree dùng chung duy nhất **do Paseo tạo trong project** (workspace `SLP <project>`, slug `slp-<project>`; không tự `git worktree add`, Paseo sẽ coi là project riêng) (nhánh `slp/<project>`, `-Worktree`, gốc `-Base`, mặc định `dev`), không bao giờ trong Supervision hay SetUpClaude.
> - `slp.ps1 run` dùng lại workspace Paseo đang mở đúng thư mục, chỉ tạo khi chưa có; kiểm `cwd` và huỷ agent nếu sai.
> - Không tạo worktree/nhánh/workspace riêng cho từng agent; mỗi lúc một Peer ghi code; agent không dùng nữa thì `paseo delete` cho sidebar gọn.
> - Không giao việc bằng `paseo run` trực tiếp: gọi từ trong một agent Paseo thì Paseo gắn agent con vào workspace của agent gọi và bỏ qua `--cwd`.

Repo này chứa **bộ công cụ** của hệ SLP (Supervisor – Lead – Peer): nhiều agent độc lập chạy trên **Paseo**, điều phối bởi một session nhạc trưởng. Dữ liệu (sổ project, inbox, báo cáo) **không** nằm ở đây mà ở kho git riêng `D:\CODE\Supervision` (đổi bằng biến `SLP_HOME`).

- Hướng dẫn đầy đủ: `docs/slp/README.md`
- Lệnh chính: `.\slp.ps1` (`ls` · `add <tên> <path>` · `rm <tên>` · `run <tên> <việc|file|task-id> [-Provider -Model -Worktree -Wait]` · `status [<tên>]`)
- Prompt vai trò, một bản dùng chung cho mọi project và mọi provider: `slp/roles/{lead,peer,supervisor}.md`
- Phương án dự phòng không dùng Paseo (chưa chạy thử): `slp/start.ps1`, `slp/stop.ps1`, `slp/lead.settings.json`
- `slp/state/`: chỉ còn dữ liệu của các bài chạy thử demo

## Quy tắc khi là nhạc trưởng
1. **Knowns trước.** Project có `.knowns/` thì docs, task, decision, memory lấy từ Knowns của project đó (`knowns ... --plain`). Giao task bằng ID Knowns: `.\slp.ps1 run daotao 6vtobg`. Không tạo bản trùng, không `knowns init` hay `knowns migrate` cho project nào; project không có Knowns thì bỏ qua Knowns.
2. Sau `run`, chạy nền `paseo wait <id>` để được báo khi agent xong, rồi đọc `D:\CODE\Supervision\projects\<tên>\inbox\<agent>-report.md`.
3. Cổng duyệt của người dùng: sửa contract, merge, xóa dữ liệu, deploy, đóng task `done`.

Cấu hình (`.claude/settings.json`): auto-compact ở 400k token, worktree tạo từ HEAD cục bộ.
