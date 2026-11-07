# SLP trên Paseo: hướng dẫn triển khai

> Cập nhật 2026-11-07. Phần nào đã chạy thử được ghi rõ; phần chưa thử nằm ở mục 10.

## 1. SLP là gì

Ba vai trò, **mỗi vai trò là một agent độc lập** chạy trên Paseo (không phải subagent bên trong một session):

| Vai trò | Việc | Model gợi ý | Không được làm |
|---|---|---|---|
| **Lead / nhạc trưởng** | Giữ định hướng, chia việc, thiết kế mù, chốt quyết định | Opus | Tự viết code tính năng; sửa contract khi người dùng chưa duyệt |
| **Peer** | Viết code và test, phản biện, đề xuất phương án C | Sonnet, hoặc model của provider khác | Sửa contract; tự đổi hướng; đóng task `done` |
| **Supervisor** | Kiểm tra theo nhịp tim, đặt câu hỏi trung tính | Haiku hoặc Gemini Flash | Viết code; ra lệnh; gợi ý đáp án |

Prompt vai trò: `slp/roles/lead.md`, `peer.md`, `supervisor.md`. Chỉ có **một bản** cho mọi project và mọi provider; `slp.ps1` đưa đường dẫn tuyệt đối vào prompt.

## 2. Kiến trúc hiện tại

```
 Người dùng ──► Nhạc trưởng (session Claude trong Paseo, thường mở ở D:\CODE\Supervision)
                    │  .\slp.ps1 run <project> <việc | file | task-id Knowns>
                    │  paseo wait <id> (chạy nền) ──► được báo khi agent xong
                    ├──► Peer A  (claude/sonnet,   cwd = repo project)
                    ├──► Peer B  (antigravity/gemini, cwd = repo project)
                    └──► Supervisor (paseo schedule, 15 phút/lần)

 Repo project            .knowns/  ← nguồn sự thật: docs, task, decision, memory (nếu có)
 D:\CODE\Supervision      slp.ps1 + slp/roles/ + slp/templates/ (bộ công cụ)
                          projects.json + projects/<tên>/{protocol.md, agents.md, inbox/, supervisor-notes.md} + .knowns/
```

Ba thành phần:
- **Paseo**: app desktop và daemon `127.0.0.1:6767`, CLI `C:\Program Files\Paseo\resources\bin\paseo.cmd`. Mọi agent hiện trong giao diện. Provider có sẵn: `claude`, `opencode` (OpenRouter: GPT, Kimi, DeepSeek, GLM…), `antigravity` (Gemini 3.8 Flash…), `pi` (Mistral, Grok…). Xem `paseo provider ls`, `paseo provider models <provider>`.
- **Supervision** (kho dữ liệu, git riêng): sổ project và phần điều phối. Không chứa code. `CLAUDE.md` ở đó hướng dẫn session nhạc trưởng.
- **Knowns** (`.knowns/` trong repo project, CLI `knowns`): nguồn sự thật cho docs, task, decision, memory. Xem mục 4.

**Nguyên tắc:**
1. **File là nguồn sự thật.** Tin nhắn chỉ để báo và trỏ tới file. Context bị compact ở 400k, nên thứ gì không nằm trong file sẽ mất.
2. **Bất đồng bộ.** Không agent nào ngồi chờ agent khác; xong thì ghi báo cáo và kết thúc lượt, nhạc trưởng được báo tự động.
3. **Báo cáo chung cho mọi provider:** `projects/<tên>/inbox/<agent>-report.md`. `SendMessage` chỉ có ở session Claude nên không là kênh chính.
4. **Cổng duyệt của người dùng:** sửa contract, merge, xóa dữ liệu, deploy, đóng task `done`.

## 3. Bắt đầu nhanh

```powershell
$slp = 'D:\CODE\Supervision\slp.ps1'
& $slp ls                                   # 8 project đã nhớ, cột Knowns cho biết project nào có .knowns
& $slp add <tên> <đường-dẫn>                # nhớ thêm project
& $slp run daotao 6vtobg                    # giao task Knowns theo ID
& $slp run piggery "sửa lỗi đăng nhập"      # project không có Knowns: việc ghi thành file task
& $slp run daotao 6vtobg -Provider antigravity -Model gemini-3.8-flash-medium
& $slp run dyneq SLP-HVEZZ3 -Worktree       # làm trong worktree dùng chung <repo>\.worktrees\slp (nhánh slp/dyneq, từ dev)
& $slp run daotao 6vtobg -Wait              # chờ xong rồi in báo cáo
& $slp status [daotao]                      # agent SLP trên Paseo (mọi thư mục)
```

Nhạc trưởng sau `run`: chạy nền `paseo wait <id>`, nhận thông báo, đọc báo cáo trong `inbox/`. Các lệnh Paseo hay dùng: `paseo send <id> --prompt-file <file> --no-wait` (giao việc tiếp cho agent cũ), `paseo logs <id>`, `paseo attach <id>`, `paseo stop <id>`, `paseo archive <id>`.

**Agent chạy ở đâu: MỘT workspace, MỘT worktree cho mỗi project** (người dùng chốt 2026-11-07: nhiều workspace làm sidebar Paseo rối, sau này chạy hàng trăm agent sẽ không nhìn được).
- `slp.ps1 run` tìm workspace Paseo đang mở đúng thư mục chạy và **dùng lại**; chỉ tạo mới (tên `SLP <project>`) khi chưa có.
- Không `-Worktree`: thư mục chạy là repo project.
- Có `-Worktree [-Base <nhánh>]`: thư mục chạy là worktree **dùng chung duy nhất** `<repo>\.worktrees\slp`, nhánh `slp/<project>`, tạo một lần từ `-Base` (mặc định `dev` nếu có, không thì nhánh hiện tại); `.worktrees/` được thêm vào `.git/info/exclude`. Lead và mọi Peer của project dùng chung worktree và workspace này, **mỗi lúc một Peer ghi code**.
- Không bao giờ tạo worktree/nhánh/workspace riêng cho từng agent. Agent xong việc, không dùng nữa thì `paseo delete` cho gọn.
- Sau khi tạo, `slp.ps1` kiểm `cwd` agent trả về; sai thì stop và archive, không giao việc. Lý do: gọi từ trong một agent Paseo (có `PASEO_AGENT_ID`), `paseo run` gắn agent con vào workspace của agent gọi và bỏ qua `--cwd`. Vì vậy không giao việc bằng `paseo run` trực tiếp. Agent cũng tự kiểm thư mục làm việc trước khi bắt đầu; sai thì báo `BLOCKED`.
- Lead nghiệm thu rồi merge `slp/<project>` vào nhánh làm việc của project (vd. `dev`); merge vào `main` do người dùng quyết.

Agent Claude mặc định chạy `bypassPermissions` để đọc và ghi được vào Supervision nằm ngoài cwd. Muốn chặt hơn: thêm Supervision vào `permissions.additionalDirectories` rồi dùng `-Mode acceptEdits`.

## 4. Knowns

Project có `.knowns/`: central-db-doc-ba, constellation, daotao, hybrid-chidung, knowns. Chưa có: piggery, dyneq, marroquineq.

- Với project có Knowns, Supervision **không** chép docs, task hay decision; chỉ giữ `agents.md`, `inbox/`, `supervisor-notes.md`.
- `slp.ps1 run <project> <id>`: ID 6 ký tự (có hoặc không có tiền tố `KN-`) được kiểm tra bằng `knowns task <id>` trước khi giao. ID sai thì báo lỗi.
- Prompt dặn agent lấy ngữ cảnh bằng `knowns retrieve "<chủ đề>" --plain`, `knowns doc list --plain`.
- Quy trình Peer với task Knowns: `in-progress` → `--plan` → `--append-notes` → `--check-ac` khi AC thật sự đạt → `in-review`. **Không bao giờ đặt `done`**; Lead kiểm tra AC rồi người dùng đóng.
- Lead tạo task bằng `knowns task create "<tiêu đề>" --ac ...`, ghi quyết định bằng `knowns decision create`. Supervisor xem `knowns task list --plain` để phát hiện task kẹt.
- Project không có Knowns: dùng `notes/`, `contract.md`, `decisions.md`, `tasks.md` trong `projects/<tên>/`. **Không** `knowns init`, **không** `knowns migrate` hay reindex cho project nào (quyết định của người dùng). Cảnh báo "config needs migrating" của daotao và hybrid-chidung không ảnh hưởng; `slp.ps1` đã bỏ qua.

## 5. Dùng lại Peer hay tạo mới

| Tình huống | Nên làm |
|---|---|
| Việc tiếp theo cùng task hoặc cùng module, Peer vừa xong, context còn dưới khoảng 60% | **Dùng lại** bằng `paseo send`. Peer đã nắm code, tiết kiệm token |
| Sửa theo review hoặc fix bug phần Peer vừa viết | Dùng lại |
| Thiết kế mù, review chéo | **Agent mới**, để không bị ảnh hưởng bởi bài trước |
| Task khác hẳn, hoặc Peer đã compact nhiều lần và bắt đầu nhầm | Agent mới; `paseo archive` con cũ |
| Việc chạy song song | Mỗi việc một Peer |

`agents.md` có cột trạng thái (đang làm, rảnh, lưu trữ). Lead tra bảng này trước khi tạo agent mới.

## 6. Cơ chế "xong thì báo lại"

| Cơ chế | Dùng cho | Đã thử |
|---|---|---|
| `paseo wait <id>` chạy nền | Mọi agent trên Paseo, mọi provider | **Có**, hai lần (demo ping, demo-2) |
| Lệnh shell chạy nền (`claude -p`, `opencode run`) | Worker chạy một lần | **Có** với `claude -p --model haiku` |
| `SendMessage` + `notify_when_idle: true` | Session Claude chạy lâu | Chưa |
| `Monitor` theo dõi `inbox/` | Nhiều sự kiện liên tục | Chưa |
| Hook `Stop` ở worker ghi sự kiện ra file | Báo tất định, không phụ thuộc model nhớ báo | Chưa |

Lưu ý với `SendMessage` giữa các session Claude: chỉ giao ngay khi hai bên **cùng nhóm permission mode**; khác nhóm thì bị giữ chờ duyệt (`crossSessionInbound`).

## 7. Thiết kế mù (blind design)

Chỉ dùng cho quyết định kiến trúc, vì tốn gấp 2–3 lần:
1. Lead viết spec **trung tính** (bài toán, ràng buộc, tiêu chí chấm), không kèm ý kiến riêng.
2. Giao cùng spec cho 2–3 Peer, nên khác provider để đa dạng góc nhìn; mỗi Peer không đọc bài của Peer khác.
3. Lead chấm theo tiêu chí đã viết **trước** khi đọc bài, ghi vào `decisions.md` hoặc `knowns decision`, kể cả khi mình nghiêng về ý ban đầu.

## 7b. Sáu quy tắc rút từ các setup cộng đồng (thêm 2026-11-07)

Đã đọc 17 repo SLP/Paseo của cộng đồng (seatwork, paseo-room, epistex, paseo-slp-plugin, paseo-team-orchestration…). Tất cả hội tụ về cùng hình dạng với setup này; phần khác nhau là máy móc bọc quanh (fork Paseo, installer, ledger, lease). Không cài repo nào; chỉ lấy sáu quy tắc họ rút ra từ chạy thật, đã đưa vào ba file vai trò:

| # | Quy tắc | Nguồn | Ở file |
|---|---|---|---|
| 1 | Báo cáo đúng khuôn 6 ô, loại chỉ là `RESULT` / `CHALLENGE` / `DECISION_REQUEST` / `BLOCKED` | epistex, duchm1606/paseo-room, pi-paseo-orchestration | `peer.md` (khuôn), `lead.md` (xử lý theo loại) |
| 2 | Xong việc không phải chấp nhận; review đúng candidate SHA, code đổi thì review lại | alliance-work, epistex, paseo-team-orchestration | `lead.md` |
| 3 | Giới hạn đếm theo sự kiện: 2 lần làm lại, lần 3 hỏi người dùng; cùng lỗi 2 lần thì dừng | epistex, seatwork, duchm1606 | `lead.md`, `peer.md` |
| 4 | Ba lớp, ưu tiên một chiều: vai trò → giao thức project → bài giao; Peer chỉ đọc ràng buộc đã trích | paseo-slp-plugin, herdr-orchestrator | `lead.md`, `peer.md` |
| 5 | Supervisor chỉ đọc, mỗi vòng trả về đúng `quiet` / `attention` / `partial` / `failed` | webplode/paseo-slp (Watcher) | `supervisor.md` |
| 6 | Peer không có công cụ điều phối; mỗi phạm vi một người viết; trinh sát chỉ đọc trước khi chia việc lớn | cuongntr/paseo-room, paseo-team-orchestration, duchm1606 | `peer.md`, `lead.md` |

Khuôn báo cáo 6 ô: Kết quả · Candidate (base SHA, candidate SHA, nhánh, worktree) · Phạm vi đã đụng · Đã kiểm chứng · Chưa rõ/rủi ro · Bàn giao. Nguyên văn trong `slp/roles/peer.md`.

Đã bỏ qua có chủ ý: fork Paseo (webplode/paseo-slp, doctrine-downstream), installer sinh role-home (cuongntr, codex-room-setup), ledger/lease/desk (seatwork, seatworks, paseo-slp-plugin, Minnyat, alliance-work), gửi tin nhắn ra API ngoài (paseo-supervision), ticket-wave Claude-only (matt-with-paseo), hộp thư riêng (piggery). Phần lớn ghim Paseo 0.8; máy này chạy 0.15.3.

## 7c. Cấu trúc tài liệu so với cộng đồng (2026-11-07)

Đã đọc cấu trúc file thật của duchm1606/paseo-room, epistex, webplode/paseo-slp, pi-paseo-orchestration. Các mục xuất hiện ở cả 4: thẩm quyền (ai quyết gì), một người viết mỗi phạm vi, candidate theo SHA, bằng chứng kiểm chứng, loại trả lời (RESULT/CHALLENGE/DECISION_REQUEST/BLOCKED), không poll, header status/version, danh sách việc người dùng phải quyết, bài giao trung tính.

| Tầng | Cộng đồng có | Mình có | Đã bổ sung |
|---|---|---|---|
| Vai trò | 3 file vai trò (+ COMMON dùng chung ở epistex) | `slp/roles/*.md` | Không cần COMMON, phần chung ngắn, lặp trong từng file |
| Project | `WORKSPACE_PROTOCOL.md` < 40 dòng ở repo; notebook của Supervisor | Chỉ có `contract.md` cho project không Knowns; `supervisor-notes.md` | **`projects/<tên>/protocol.md`** tạo từ `slp/templates/protocol.md` cho mọi project (để trong Supervision, không đụng repo); khuôn ghi chép Supervisor |
| Bài giao việc | `assignment.md` với MUST HOLD / DECIDED / UNKNOWN / SCOPE write-held-stop / RESPOND | Chỉ liệt kê yêu cầu trong `lead.md` | **`slp/templates/assignment.md`** |
| Báo cáo | handback 6 ô, < 4000 ký tự | Khuôn 6 ô trong `peer.md` | Giới hạn 4000 ký tự |
| Bàn giao Lead thay Lead (`handoff.md`) | paseo-room có | Không | Bỏ qua, chưa cần |
| TARGET / PHILOSOPHY toàn cục | paseo-room có | README này | Đủ |

## 7d. Phân bổ model để không lỗ token

Chi phí thật nằm ở: Lead đọc quá nhiều, Peer đọc cả file lớn, vòng làm lại, Supervisor chạy dày. Các quy tắc đã đưa vào vai trò (báo cáo < 4000 ký tự, bài giao trích sẵn ràng buộc, 2 lần làm lại, `quiet` không gửi gì, Peer đọc có chủ đích) chính là để chặn bốn chỗ đó. Phân bổ model gợi ý:

| Việc | Model / provider | Lý do |
|---|---|---|
| Nhạc trưởng (Lead) | Claude Opus, chính session của bạn | Cần phán đoán. Giữ context gọn: không đọc code, chỉ đọc báo cáo và `git diff base..candidate` |
| Peer viết code, có Knowns, logic phức tạp | `claude` Sonnet | Tool use ổn định, cùng hạn mức gói Claude |
| Peer việc nhỏ, phạm vi rõ | `antigravity` Gemini 3.8 Flash medium, hoặc Sonnet | Rẻ hơn, đủ cho việc giới hạn |
| Trinh sát chỉ đọc, bản đồ phạm vi | Haiku hoặc Flash low | Đọc nhiều, trả về ngắn |
| Supervisor | Haiku, `paseo schedule --every 30m` | Mỗi vòng chỉ đọc log và notes; bắt đầu 30 phút, dày hơn khi cần |
| Review độc lập | Khác họ với người viết: Gemini (antigravity) hoặc GPT (opencode/OpenRouter) | Một lượt, đúng SHA; lỗi của hai họ model khác nhau |
| Thiết kế mù | 2 Peer khác họ | Chỉ khi khóa kiến trúc |

Lưu ý về hạn mức: agent `claude` ăn vào gói Claude của bạn; `antigravity` dùng hạn mức Google; `opencode` qua OpenRouter và `pi` với Grok trừ credit thật. Xem `paseo usage` để biết đang tiêu ở đâu. Chưa đo chi phí thực tế của từng provider trên máy này.

**Auto-compact 400k đã đặt toàn cục** trong `~/.claude/settings.json` (2026-11-07), nên mọi session Claude, kể cả Peer chạy trong repo project, đều compact ở khoảng 400k. Bản trong `.claude/settings.json` của Supervision chỉ trùng. Chỉ áp dụng cho provider `claude`; agent Gemini, GPT, Grok theo giới hạn riêng của chúng.

## 8. Cấu hình

`.claude/settings.json` của repo này:
```json
{ "autoCompactWindow": 400000, "worktree": { "baseRef": "head" } }
```
- `autoCompactWindow`: compact ở khoảng 400k token thay vì 1M (hợp lệ 100000–1000000). Chỉ áp dụng cho session mở trong repo này; muốn dùng chung thì đặt vào `~/.claude/settings.json`. Theo model: `modelSettings.<model>.autoCompactWindow` hoặc `/autocompact`. Một lần: `claude --autocompact 400k`.
- `worktree.baseRef: head`: worktree tạo từ HEAD cục bộ thay vì `origin/<nhánh>`.

## 9. Rủi ro và cách giảm

| Rủi ro | Cách giảm |
|---|---|
| Hết hạn mức hoặc rate limit khi nhiều agent chạy cùng lúc | Bắt đầu 1 Peer; Supervisor 15–30 phút một lần với model rẻ |
| Mất thông tin khi compact | Mọi thứ quan trọng trong Knowns hoặc Supervision; vai trò yêu cầu đọc lại sau compact |
| Peer xung đột code | Một worktree dùng chung, mỗi lúc một Peer ghi; Lead merge có người duyệt |
| Agent đứng chờ xin quyền | Claude dùng `bypassPermissions` (mặc định của script); hoặc `paseo attach` vào duyệt |
| Peer tự đóng task hoặc đổi phạm vi | Vai trò cấm `done` và cấm sửa contract; Supervisor so với contract |

## 10. Đã kiểm chứng và chưa kiểm chứng

**Đã chạy thử thành công:**
- `paseo run --no-wait` tạo agent Haiku; `paseo wait` chạy nền báo về nhạc trưởng (demo ping).
- Agent demo-2 đọc file vai trò, làm task, ghi báo cáo vào `inbox/`; xác nhận agent con **không** thấy hội thoại của nhạc trưởng (dòng `[Message received]` trong `paseo logs` chỉ là cách hiển thị).
- `slp.ps1`: `ls`, `add`, `rm`, `status`, và `run -DryRun` với ID Knowns đúng, ID sai, project không có Knowns.

**Chưa chạy thử:**
- `slp.ps1 run` thật (không `-DryRun`), nhất là với task Knowns và với `-Worktree`.
- Provider ngoài Claude (`antigravity`, `opencode`, `pi`) qua Paseo; sẽ tốn credit tương ứng.
- `paseo send` để dùng lại Peer; `paseo schedule` cho Supervisor.
- Hook `Stop`, `Monitor`, `SendMessage notify_when_idle`.
- Haiku với `autoCompactWindow` 400k.

## 11. Nhận định về mô hình SLP gốc

Giữ lại: câu hỏi trung tính giảm thiên vị và thói chiều lòng; thiết kế mù rồi hội tụ; Peer được phản biện; model rẻ cho giám sát.

Đã chỉnh: Supervisor không đọc được suy luận nội bộ của agent khác, chỉ đọc log, trạng thái, git và file; Lead chấm theo tiêu chí viết trước; Peer phản biện bằng file, không tự đổi hướng; vẫn giữ cổng duyệt của người dùng; giới hạn 3 vòng trao đổi mỗi chủ đề, Supervisor hỏi mỗi agent tối đa 1 câu mỗi vòng.

## Phụ lục A. Phương án dự phòng không dùng Paseo (chưa chạy thử)

`slp/start.ps1` tạo Lead, Peer, Supervisor bằng `claude --bg -n <tên> --model ... --append-system-prompt ...`, Peer dùng `-w` (worktree), Supervisor dùng `/loop 15m`. `slp/stop.ps1` dừng các session `slp-*`. `slp/lead.settings.json` tắt `worktree.bgIsolation` cho Lead vì session nền trong git repo mặc định bị chặn ghi ở checkout chính.

Lệnh liên quan: `claude agents [--json]`, `claude attach <tên>`, `claude logs <tên>`, `claude stop <id>`, `claude --resume <id>`. Điểm chưa rõ: `--bg` kết hợp `-w`; prompt `/loop` truyền lúc khởi động có chạy không; `claude stop` có nhận tên không; mọi session phải cùng permission mode để `SendMessage` được giao ngay.

## Phụ lục B. Gọi provider khác không qua Paseo

`opencode run -m openrouter/<provider>/<model> --format json "<việc>"` (opencode v2.1.4, đã lưu đăng nhập OpenRouter). Chạy nền từ phía nhạc trưởng, ghi kết quả vào `inbox/`. Không khuyến nghị proxy đổi `ANTHROPIC_BASE_URL` sang model khác vì dễ hỏng tool use.
