<#
  SLP - khởi động Lead, các Peer và Supervisor thành các session Claude Code độc lập chạy nền.
  BẢN NHÁP: chưa chạy thử. Xem docs/slp/README.md, mục "Những điểm chưa kiểm chứng".

  Ví dụ:
    .\slp\start.ps1
    .\slp\start.ps1 -Repo D:\CODE\DuAnKhac -Peers 1
    .\slp\start.ps1 -NoSupervisor
#>
param(
  [string]$Repo = (Split-Path $PSScriptRoot -Parent),
  [int]$Peers = 2,
  [string]$LeadModel = 'opus',
  [string]$PeerModel = 'sonnet',
  [string]$SupervisorModel = 'haiku',
  [string]$Heartbeat = '15m',
  # Mọi session dùng CÙNG một permission mode để tin nhắn SendMessage giữa chúng được giao ngay
  # (xem crossSessionInbound trong README).
  [string]$PermissionMode = 'acceptEdits',
  [switch]$NoSupervisor
)
$ErrorActionPreference = 'Stop'
Set-Location $Repo

if (-not (Test-Path (Join-Path $Repo '.git'))) {
  throw "$Repo chưa là git repo. Chạy: git init; git add -A; git commit -m 'init'"
}
foreach ($f in 'slp/roles/lead.md', 'slp/roles/peer.md', 'slp/roles/supervisor.md', 'slp/lead.settings.json') {
  if (-not (Test-Path (Join-Path $Repo $f))) { throw "Thiếu $f trong $Repo (sao chép thư mục slp/ sang repo này trước)." }
}

# Tạo các file trạng thái dùng chung nếu chưa có
$state = Join-Path $Repo 'slp/state'
New-Item -ItemType Directory -Force (Join-Path $state 'inbox') | Out-Null
foreach ($f in 'contract.md', 'decisions.md', 'tasks.md', 'supervisor-notes.md') {
  $p = Join-Path $state $f
  if (-not (Test-Path $p)) { Set-Content -Path $p -Value "# $f`n" -Encoding utf8 }
}

# Prompt hệ thống viết bằng tiếng Anh (ASCII) để tránh lỗi mã hóa khi truyền tham số trên PowerShell 5.1.
# Nội dung chi tiết nằm trong slp/roles/*.md (UTF-8), session tự đọc.
function Start-SlpSession([string[]]$ExtraArgs) {
  $cliArgs = @('--bg', '--permission-mode', $PermissionMode) + $ExtraArgs
  Write-Host "> claude $($cliArgs -join ' ')" -ForegroundColor DarkGray
  & claude @cliArgs
  if ($LASTEXITCODE -ne 0) { throw "claude exit $LASTEXITCODE" }
}

# Lead: chạy ở checkout chính (bgIsolation=none) vì cần ghi slp/state/
Start-SlpSession @(
  '-n', 'slp-lead', '--model', $LeadModel,
  '--settings', 'slp/lead.settings.json',
  '--append-system-prompt', 'You are the SLP Lead session. Before anything else, read and follow slp/roles/lead.md and CLAUDE.md.'
)

# Peer: mỗi Peer một worktree riêng
for ($i = 1; $i -le $Peers; $i++) {
  Start-SlpSession @(
    '-n', "slp-peer-$i", '-w', "slp-peer-$i", '--model', $PeerModel,
    '--append-system-prompt', "You are SLP Peer session slp-peer-$i. Before anything else, read and follow slp/roles/peer.md and CLAUDE.md."
  )
}

# Supervisor: model rẻ, kiểm tra theo nhịp tim bằng /loop
if (-not $NoSupervisor) {
  Start-SlpSession @(
    '-n', 'slp-supervisor', '--model', $SupervisorModel,
    '--append-system-prompt', 'You are the SLP Supervisor session. Read and follow slp/roles/supervisor.md. Never edit project files except slp/state/supervisor-notes.md.',
    "/loop $Heartbeat Run one SLP supervision pass as described in slp/roles/supervisor.md"
  )
}

Write-Host "`nĐã khởi động. Xem: claude agents   |   Mở Lead: claude attach slp-lead" -ForegroundColor Green
