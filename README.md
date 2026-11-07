# SetUpClaude — bộ công cụ SLP trên Paseo

> **Đã chuyển (2026-11-07):** bộ công cụ SLP chính thức giờ nằm trong `D:\CODE\Supervision` (`slp.ps1`, `slp\roles\`, `slp\templates\`, `docs\slp\README.md`). Đọc và chạy từ đó: `D:\CODE\Supervision\slp.ps1 ...`. Các file ở repo này là bản sao đồng bộ ngày 2026-11-07, không sửa ở đây.
>
> **Quy tắc mới (người dùng chốt 2026-11-07): MỘT workspace Paseo, MỘT worktree cho mỗi project.**
> - Agent luôn chạy trong repo project hoặc worktree dùng chung duy nhất `<repo>\.worktrees\slp` (nhánh `slp/<project>`, `-Worktree`, gốc `-Base`, mặc định `dev`), không bao giờ trong Supervision hay SetUpClaude.
> - `slp.ps1 run` dùng lại workspace Paseo đang mở đúng thư mục, chỉ tạo khi chưa có; kiểm `cwd` và huỷ agent nếu sai.
> - Không tạo worktree/nhánh/workspace riêng cho từng agent; mỗi lúc một Peer ghi code; agent không dùng nữa thì `paseo delete` cho sidebar gọn.
> - Không giao việc bằng `paseo run` trực tiếp: gọi từ trong một agent Paseo thì Paseo gắn agent con vào workspace của agent gọi và bỏ qua `--cwd`.

Điều phối nhiều AI agent theo mô hình **SLP (Supervisor – Lead – Peer)** trên [Paseo](https://paseo.sh): một session nhạc trưởng giao việc, các Peer làm trong repo của từng project, Supervisor giám sát theo nhịp. Mọi agent hiện trong giao diện Paseo; provider nào Paseo hỗ trợ đều dùng được (Claude, Gemini qua Antigravity, GPT/Kimi/DeepSeek qua OpenCode–OpenRouter, Mistral/Grok qua Pi).

Repo này chỉ chứa **bộ công cụ**. Dữ liệu điều phối (sổ project, giao thức, inbox, báo cáo) nằm ở kho riêng [Supervision](https://github.com/anionzo/Supervision).

```
 Bạn ──► Nhạc trưởng (session Claude trong Paseo)
             │  .\slp.ps1 run <project> <task-id | "việc" | file>
             │  paseo wait <id>  (chạy nền → được báo khi xong)
             ├──► Peer A   claude/sonnet        cwd = repo project
             ├──► Peer B   antigravity/gemini   cwd = repo project
             └──► Supervisor  haiku, paseo schedule 30m, chỉ đọc

 <repo project>\.knowns\      nguồn sự thật: docs, task, decision (nếu project có Knowns)
 D:\CODE\Supervision\         projects.json + projects\<tên>\{protocol.md, agents.md, inbox\, supervisor-notes.md}
 D:\CODE\SetUpClaude\         slp.ps1 + slp\roles\ + slp\templates\   (repo này)
```

## Yêu cầu
- Windows, PowerShell 5.1 trở lên.
- [Paseo](https://paseo.sh) desktop (đã thử với 0.15.3), CLI tại `C:\Program Files\Paseo\resources\bin\paseo.cmd`.
- Claude Code đăng nhập sẵn (provider `claude`). Các provider khác tùy chọn, bật trong Paseo.
- [Knowns](https://www.npmjs.com/package/knowns) nếu project dùng (`.knowns\` trong repo). Không bắt buộc.
- `gh` CLI chỉ cần nếu muốn đẩy kho lên GitHub.

## Cài đặt
```powershell
git clone https://github.com/anionzo/SetUpClaude D:\CODE\SetUpClaude
git clone https://github.com/anionzo/Supervision  D:\CODE\Supervision   # hoặc tạo kho trống rồi đặt biến SLP_HOME
```
Đường dẫn kho dữ liệu mặc định là `D:\CODE\Supervision`; đổi bằng biến môi trường `SLP_HOME`.

## Bắt đầu nhanh
```powershell
$slp = 'D:\CODE\SetUpClaude\slp.ps1'
& $slp add daotao D:\CODE\HUIT-Project\daotao     # nhớ một project (tên: chữ thường, số, gạch ngang)
& $slp ls                                         # danh sách, cột Knowns cho biết project có .knowns
& $slp run daotao 6vtobg                          # giao task Knowns theo ID cho một Peer
& $slp run dyneq "sửa lỗi đăng nhập"              # project không có Knowns: việc được ghi thành file task
& $slp run daotao 6vtobg -Provider antigravity -Model gemini-3.8-flash-medium
& $slp run daotao 6vtobg -Worktree                # Peer làm trong worktree riêng, nhánh slp/<tên-agent>
& $slp run daotao 6vtobg -Wait                    # chờ xong rồi in báo cáo
& $slp status daotao                              # agent SLP của project trên Paseo
```
Nhạc trưởng sau `run`: chạy nền `paseo wait <id>`, nhận thông báo, đọc `D:\CODE\Supervision\projects\<tên>\inbox\<agent>-report.md`. Giao việc tiếp cho agent cũ: `paseo send <id> --prompt-file <file> --no-wait`.

Lần `run` đầu tiên cho một project sẽ tạo `projects\<tên>\protocol.md` từ mẫu; **điền file này** (lệnh test, chỗ cấm đụng, anti-pattern) trước khi giao việc thật.

## Lệnh `slp.ps1`
| Lệnh | Việc |
|---|---|
| `ls` | Liệt kê project đã nhớ: đường dẫn, có git, có Knowns |
| `add <tên> <path>` · `rm <tên>` | Nhớ / bỏ nhớ project (không đụng gì trong project) |
| `run <tên> <task-id \| "việc" \| file.md>` | Tạo agent trên Paseo, cwd là repo project |
| `-Role peer\|supervisor\|lead` | Vai trò (mặc định `peer`) |
| `-Provider`, `-Model`, `-Mode` | Provider/model của Paseo (`paseo provider models <provider>`); Claude mặc định `bypassPermissions` |
| `-Name`, `-Worktree`, `-Wait`, `-DryRun` | Tên agent; worktree riêng; chờ và in báo cáo; chỉ in lệnh |
| `status [<tên>]` | Agent SLP đang có trên Paseo (mọi thư mục) |

## Vai trò
Prompt vai trò viết bằng tiếng Anh, một bản dùng chung cho mọi project và provider: [`slp/roles/lead.md`](slp/roles/lead.md), [`peer.md`](slp/roles/peer.md), [`supervisor.md`](slp/roles/supervisor.md). Agent được dặn viết báo cáo bằng tiếng Việt.

| Vai trò | Làm | Không làm |
|---|---|---|
| **Lead** (nhạc trưởng) | Chia việc theo mẫu bài giao, chấm bài theo đúng commit SHA, chốt quyết định | Tự viết code; sửa contract khi chưa được duyệt; đóng task `done` |
| **Peer** | Viết code và test trong phạm vi giao, nộp báo cáo 6 ô, được phản biện | Gọi `paseo`; sửa contract; tự đổi hướng |
| **Supervisor** | Đọc log, git, Knowns theo nhịp; hỏi câu trung tính; trả về `quiet` / `attention` / `partial` / `failed` | Viết code; ra lệnh; gợi ý đáp án |

Quy tắc cốt lõi (rút từ 17 setup cộng đồng, xem [docs/slp/README.md](docs/slp/README.md) mục 7b):
1. Báo cáo đúng khuôn 6 ô, loại chỉ là `RESULT` / `CHALLENGE` / `DECISION_REQUEST` / `BLOCKED`, dưới 4000 ký tự.
2. Xong việc không phải chấp nhận: Lead review đúng candidate SHA; code đổi thì review lại.
3. Giới hạn đếm theo sự kiện: làm lại tối đa 2 lần, lần 3 hỏi người dùng; cùng lỗi 2 lần thì dừng.
4. Ba lớp, ưu tiên một chiều: vai trò → giao thức project → bài giao việc.
5. Peer không có công cụ điều phối; mỗi phạm vi một người viết; trinh sát chỉ đọc trước khi chia việc lớn.
6. Cổng duyệt của người dùng: sửa contract, merge, xóa dữ liệu, deploy, đóng task `done`.

## Tích hợp Knowns
Project có `.knowns\` thì Knowns là nguồn sự thật cho docs, task, decision, memory. `slp.ps1 run <project> <id>` kiểm tra ID bằng `knowns task <id>` rồi giao; Peer đi theo quy trình `in-progress` → `--plan` → `--append-notes` → `--check-ac` → `in-review`, không bao giờ đặt `done`. Bộ công cụ không `knowns init`, không `knowns migrate` cho project nào; project không có Knowns thì dùng `notes\`, `contract.md`, `tasks.md` trong Supervision.

## Cấu trúc repo
```
slp.ps1                  lệnh chính
slp\roles\               lead.md, peer.md, supervisor.md (tiếng Anh)
slp\templates\           protocol.md (giao thức project, <40 dòng), assignment.md (bài giao việc)
slp\start.ps1, stop.ps1  phương án dự phòng không dùng Paseo (claude --bg), chưa chạy thử
slp\state\               dữ liệu các bài chạy thử demo
docs\slp\README.md       nghiên cứu, so sánh với cộng đồng, phân bổ model, điểm chưa kiểm chứng
.claude\settings.json    autoCompactWindow 400k, worktree từ HEAD
```

## Trạng thái
Đã chạy thử: tạo agent qua Paseo, `paseo wait` báo về nhạc trưởng, agent đọc vai trò và nộp báo cáo; `slp.ps1` với ID Knowns đúng/sai và project không Knowns (chạy khô). **Chưa chạy thử**: `run` thật với bộ prompt hiện tại, provider ngoài Claude, `-Worktree`, `paseo send`, lịch Supervisor. Chi tiết ở [docs/slp/README.md](docs/slp/README.md) mục 10.
