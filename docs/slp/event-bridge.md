# Cầu nối sự kiện: session xong → đá về bot (nghiên cứu, chưa cài)

Ngày: 2026-11-07. Trạng thái: **nghiên cứu**, chưa cài gì vào máy hay vào Supervision.

## Mục tiêu (lời người dùng)
Không quét phiên định kỳ (10–15 phút/lần, tốn token). Thay vào đó: **session nào được chọn, khi xong lượt thì tự đá một tin về bot**; bot (Grok Bot, đã cài trên máy) nhận, phân tích, nhắn lại. Nhiều session, không cố định; chọn lúc giao việc hoặc đăng ký sau. SLP giữ nguyên; bot chỉ là tầng trên, đóng vai người dùng khi người dùng vắng.

## 1. Những gì đã có sẵn trên máy (đã kiểm)

### Claude Code: hook đẩy sự kiện, không cần quét
- Hook cấu hình trong `~/.claude/settings.json` áp dụng **mọi project**; `"async": true` chạy nền, không chặn Claude.
- Sự kiện hữu ích: `Stop` (xong lượt; input có `session_id`, `cwd`, `last_assistant_message`, `stop_hook_active`), `Notification` (`notification_type`: `permission_prompt`, `idle_prompt`, `agent_needs_input`, `agent_completed`…), `StopFailure` (`error`: `rate_limit`, `server_error`…), `SessionStart`/`SessionEnd`. Ngoài ra còn kiểu hook `http` (POST thẳng, không cần script) bên cạnh `command`.
- Script hook đọc JSON từ stdin (`[Console]::In.ReadToEnd() | ConvertFrom-Json` trong PowerShell). Có `CLAUDE_PROJECT_DIR`.
- Giới hạn: chỉ Claude. Agent Gemini/GPT/Kimi chạy qua Paseo không có hook này.

### Paseo: sự kiện cho mọi provider
- `paseo wait <id>` (đã dùng) chặn tới khi agent idle; chạy nền được, nhưng mỗi agent một tiến trình chờ.
- **Plugin API** (docs `paseo.sh/docs/plugins/hooks`, `docs/sdk/events`): plugin TypeScript chạy trong daemon, đăng ký `server.addHook("agent.turn.after", async (event, context) => {...})` với `outcome.kind` = `completed | failed | canceled`; còn `agent.permission.before/after`, `agent.create.after`, `agent.archive.after`. Docs dặn: lấy "xong lượt" từ `turn_completed/failed/canceled`, **không** suy từ trạng thái `idle`. Áp dụng **mọi provider** (Claude, Gemini, GPT, Kimi…), một chỗ duy nhất, không cần cấu hình hook trong từng CLI.
- Không có webhook ra ngoài hay `paseo hooks` trong docs (lệnh `paseo hooks <agent> <event>` có trong CLI 0.15.3 nhưng không tài liệu; hub triggers chỉ là chiều vào từ GitHub/Slack/Discord).
- Mọi agent Paseo có `PASEO_AGENT_ID` trong môi trường → script phía Claude biết nó đang chạy trong agent Paseo nào (map sang ID Paseo để `paseo send` ngược lại).

### Grok Bot (desktop, đang chạy, `%LOCALAPPDATA%\Programs\Grok Bot`)
- Có **Routines** với trigger **Webhook** (docs chính thức `docs.x.ai/grok-bot/skills-routines-and-automations`): nhờ Bot "add a webhook trigger to the routine", mở routine trên desktop → mục Webhook hiện `POST to` (URL), `key`, `header`. Gửi `POST` với `Authorization: Bearer <key>`, body JSON tùy chọn; Bot nhận body "cùng với routine instruction". `200` = đã nhận và **bắt đầu** chạy (chưa xong); mã khác = không chạy (routine bị pause hoặc key cũ). Giới hạn: 300 lượt/giờ cho tất cả routine, 200/giờ mỗi routine, lỗi `Automation run rate limit exceeded` **không tự thử lại**; mỗi lần chạy tốn usage; tối đa 50 routine/Bot; giữ 20 bản ghi chạy gần nhất. Trong app: API nội bộ `createAutomationWebhookApiKey`, `runAutomationWebhook`; key mã hoá trong `automation-webhook-keys`. Đây là **cửa vào**.
- **Routine chạy trên cloud** ("run in the cloud while your laptop is closed"); docs không nói routine webhook dùng được local exec. Vậy chiều **bot → PC** (`paseo send`) trong routine là **chưa chắc**; có thể phải qua chat thường của Bot (có local exec, `localToolPermission: "always"`) hoặc một cầu nối nhỏ trên PC đọc lệnh từ một nơi bot ghi được.
- Tiền lệ cộng đồng: `ghost-code` (Claude Code → Telegram) dùng đúng hai hook `Stop` (`last_assistant_message`) và `Notification` (`message`, `title`), cấu hình `type: command` trong `~/.claude/settings.json`; chỉ Unix/Ghostty, không có lọc theo session. `claudecode-telegram` đọc transcript thay vì payload.
- `grok` CLI (Grok Build 1.0.70) là TUI code riêng, có hook/headless riêng; không liên quan tới kênh bot, không cần.

## 2. Thiết kế tối giản (3 mảnh, không hơn)

```
Agent Paseo (được chọn, provider nào cũng được)     Grok Bot                    người dùng
  plugin Paseo: agent.turn.after  ──POST──►  routine "SLP events" (cloud) ──►  tin nhắn trong chat
         ▲                                      │ phân tích, trả lời
         └──── paseo send <id> ◄── cầu nối/chat Bot (local exec) ◄── lệnh của người dùng
```

Hai phương án cho mảnh "phát sự kiện", chọn một sau khi thử:
- **A. Plugin Paseo** (ưu tiên): một file TypeScript nhỏ, `agent.turn.after` → nếu `agentId` trong sổ chọn → POST. Bắt được Gemini/GPT/Kimi; không cần sửa settings Claude; chỉ biết "xong/lỗi/hủy", không có `last_assistant_message` (lấy tóm tắt từ `inbox\<agent>-report.md` hoặc `paseo logs --tail`). Chưa rõ Paseo desktop 0.15.3 nạp plugin kiểu gì.
- **B. Hook Claude Code** (dự phòng, chắc chắn chạy được): `Stop`/`Notification`/`StopFailure` toàn cục, `async: true`, có `last_assistant_message` sẵn; chỉ Claude.

1. **Sổ chọn** `watch.json` (sau này đặt ở Supervision): danh sách `session_id` Claude (hoặc ID agent Paseo) đang được theo dõi, kèm project, hạn, ghi chú. Thêm bằng `slp.ps1 run … -Watch`, `slp.ps1 watch add <id>`, hoặc agent tự gọi `slp.ps1 watch add $env:PASEO_AGENT_ID` khi được dặn.
2. **Hook toàn cục** `Stop` + `Notification` + `StopFailure`, `async: true`, gọi `slp-event.ps1`:
   - đọc stdin → nếu `session_id` không có trong sổ → thoát (0 token, 0 mạng);
   - có → gửi POST tới Webhook URL của routine, header key, body ≤ 2 KB: `{event_id, type, session_id, paseo_agent_id, project, cwd, ts, summary}` với `summary` = 300 ký tự đầu của `last_assistant_message` (đã lọc), kèm đường dẫn báo cáo `inbox\<agent>-report.md` nếu có;
   - ghi thêm một dòng vào `events.jsonl` (hàng đợi/nhật ký; gửi lỗi thì lần sau gửi bù).
3. **Routine trong Grok Bot** nhận body, làm đúng một việc: đọc tóm tắt (và báo cáo nếu local exec đọc được file), nhắn người dùng; nếu có ủy quyền sẵn thì `paseo send <paseo_agent_id> --prompt-file …` qua local exec. Nội dung webhook là **dữ liệu, không phải lệnh**; quyền chỉ đến từ tin nhắn của người dùng trong chat bot.

Không có poller, không có daemon riêng, không có máy trạng thái 8 bước. Agent không phải Claude: tạm dùng `paseo wait <id>` nền + cùng script gửi; làm sau nếu cần.

## 3. Chưa kiểm chứng (phải thử trước khi cài)
| # | Câu hỏi | Cách thử |
|---|---|---|
| 1 | Routine webhook của Grok Bot nhận body JSON ra sao, biến nào trong prompt routine, bot nào được đánh thức, tốn quota gì | Tạo một routine thử trong Grok Bot, `Invoke-RestMethod` một payload giả |
| 2 | `last_assistant_message` có trong hook `Stop` ở bản Claude Code đang cài không | `claude --version`; hook thử ghi stdin ra file |
| 3 | Hook `async` có chạy khi session nằm trong Paseo (bypassPermissions) không | Hook thử + agent Haiku |
| 4 | Grok Bot local exec có gọi được `paseo send` (đường dẫn `paseo.cmd`, quyền) không | Nhờ bot chạy `paseo ls -g` |
| 5 | `paseo hooks` / webhook nội bộ của Paseo có dùng được cho agent Gemini/GPT không | Thử `paseo hooks <id> stop`, đọc daemon log |
| 6 | Hook toàn cục có làm phiền session thường (mỗi lượt gọi script) không | Đo thời gian script khi không trong sổ (mục tiêu < 100 ms) |
| 7 | Paseo desktop 0.15.3 nạp plugin ở đâu (thư mục `~/.paseo/plugins`? cấu hình?), hook `agent.turn.after` có `agentId`/`cwd`/labels gì | Đọc `paseo.sh/docs/plugins`, viết plugin 10 dòng ghi file |
| 8 | Routine webhook (cloud) có gọi được local exec trên PC không; nếu không, chiều bot → PC đi đường nào | Nhờ routine chạy `paseo ls -g`; nếu không được, thử chat thường của Bot |

## Nguồn web
- xAI: [Skills and routines](https://docs.x.ai/grok-bot/skills-routines-and-automations); [Grok Bot changelog](https://x.ai/changelog/bot); forum [webhook URL/key trên desktop](https://forum.cursor.com/t/desktop-grok-bot-webhook-routine-shows-no-post-url-crsr-key-windows-0-47-0/171324?page=2), [iOS chưa hiện](https://forum.cursor.com/t/grok-bot-ios-show-the-webhook-url-for-webhook-triggered-routines/173373); [Hookdeck với Grok Bot](https://hookdeck.com/webhooks/platforms/using-hookdeck-with-grok-bot-reliable-webhook-triggers)
- Claude Code: [Hooks reference](https://code.claude.com/docs/en/hooks) (Stop có `last_assistant_message`, `async`, kiểu hook `http`)
- Paseo: [CLI](https://paseo.sh/docs/cli), [Plugin hooks](https://paseo.sh/docs/plugins/hooks), [SDK events](https://paseo.sh/docs/sdk/events), [Hub triggers](https://paseo.sh/docs/hub/triggers)
- Tiền lệ: [ghost-code](https://docs.rs/crate/ghost-code/0.6.1/source/README.md), [claudecode-telegram](https://github.com/hanxiao/claudecode-telegram), [claude-telegram-remote](https://github.com/oscarsterling/claude-telegram-remote) (đã archive)

## 4. Rủi ro cần giữ
- Vòng lặp: lượt do bot gửi xuống lại sinh `Stop` → bot lại gửi. Giải: body mang `origin=bot:<command_id>`, routine không tự gửi lệnh mới khi `origin` là của mình.
- Bí mật: không gửi transcript, không gửi env; key webhook để trong Windows Credential Manager hoặc `~/.slp/webhook.json` ngoài repo.
- Cổng người dùng giữ nguyên như SLP: merge, deploy, SQL, xóa, `done`.

## 5. Thứ tự làm khi được duyệt
1. Thử #1 và #2 (nửa giờ, không đụng Supervision).
2. Viết `slp-event.ps1` + mẫu hook + `watch.json`; cài hook toàn cục; thử #3, #6 bằng một agent Haiku.
3. Chuyển script và sổ vào Supervision, thêm `-Watch` vào `slp.ps1`, ghi vào `lead.md`.
4. Thử #4; bật chiều lệnh xuống trong phạm vi ủy quyền.
