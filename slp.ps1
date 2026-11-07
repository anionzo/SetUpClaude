<#
  slp - một lệnh duy nhất để chạy SLP trên Paseo cho nhiều project.
  Kho dữ liệu (git riêng): D:\CODE\Supervision, hoặc biến SLP_HOME
    projects.json            sổ project (tên -> đường dẫn)
    projects\<tên>\          contract, decisions, tasks, agents, inbox\, notes\ (tự tạo)
  Hướng dẫn vai trò dùng chung: slp\roles\*.md (một bản duy nhất cho mọi project và mọi provider).

  .\slp.ps1 ls                                   # xem các project đã nhớ
  .\slp.ps1 add <tên> <đường-dẫn>                # nhớ thêm một project
  .\slp.ps1 rm <tên>                             # bỏ nhớ (không xóa gì trong project)
  .\slp.ps1 run <tên> "<việc cần làm>"           # tạo Peer trên Paseo làm việc đó
  .\slp.ps1 run <tên> <file-task.md>             # hoặc đưa file mô tả việc
  .\slp.ps1 status [<tên>]                       # các agent SLP đang có trên Paseo

  Tùy chọn cho run:
    -Role peer|supervisor|lead   (mặc định peer)
    -Provider claude|opencode|antigravity|pi  -Model <model>   (xem: paseo provider models <provider>)
    -Mode <mode>   (claude mặc định bypassPermissions)
    -Name <tên-agent>   -Worktree   -Wait (chờ xong rồi in báo cáo)   -DryRun (chỉ in lệnh)
#>
param(
  [Parameter(Position = 0)][ValidateSet('ls', 'add', 'rm', 'run', 'status', 'help')][string]$Cmd = 'help',
  [Parameter(Position = 1)][string]$Project,
  [Parameter(Position = 2)][string]$Arg,
  [ValidateSet('peer', 'supervisor', 'lead')][string]$Role = 'peer',
  [ValidatePattern('^[a-z0-9-]*$')][string]$Name,
  [string]$Provider = 'claude',
  [string]$Model,
  [string]$Mode,
  [switch]$Worktree,
  [switch]$Wait,
  [switch]$DryRun
)
$ErrorActionPreference = 'Stop'
$Hub = $PSScriptRoot                                   # bộ công cụ: slp.ps1, slp\roles
$Data = if ($env:SLP_HOME) { $env:SLP_HOME } else { 'D:\CODE\Supervision' }   # kho dữ liệu: sổ project, doc, note, task, inbox
if (-not (Test-Path $Data)) { throw "Không thấy kho dữ liệu SLP: $Data (đặt biến SLP_HOME nếu để chỗ khác)" }
$Registry = Join-Path $Data 'projects.json'
$Roles = Join-Path $Hub 'slp\roles'
$Paseo = 'C:\Program Files\Paseo\resources\bin\paseo.cmd'

function Read-Registry {
  $h = [ordered]@{}
  if (Test-Path $Registry) {
    (Get-Content $Registry -Raw -Encoding utf8 | ConvertFrom-Json).PSObject.Properties | ForEach-Object { $h[$_.Name] = $_.Value }
  }
  $h
}
function Save-Registry($h) {
  $sorted = [ordered]@{}; $h.Keys | Sort-Object | ForEach-Object { $sorted[$_] = $h[$_] }
  [IO.File]::WriteAllText($Registry, ($sorted | ConvertTo-Json), (New-Object Text.UTF8Encoding $false))
}
function Get-ProjectPath($name) {
  $reg = Read-Registry
  if (-not $name) { throw "Thiếu tên project. Xem: .\slp.ps1 ls" }
  if (-not $reg.Contains($name)) { throw "Chưa nhớ project '$name'. Thêm bằng: .\slp.ps1 add $name <đường-dẫn>" }
  $p = $reg[$name]
  if (-not (Test-Path $p)) { throw "Đường dẫn của '$name' không còn tồn tại: $p" }
  $p
}
function Initialize-State($name, [bool]$hasKnowns) {
  $state = Join-Path $Data "projects\$name"
  New-Item -ItemType Directory -Force (Join-Path $state 'inbox') | Out-Null
  # Project có Knowns: docs/tasks/decisions nằm trong .knowns của project -> không tạo bản trùng ở đây
  $files = if ($hasKnowns) { @('supervisor-notes.md') } else { @('contract.md', 'decisions.md', 'tasks.md', 'supervisor-notes.md') }
  if (-not $hasKnowns) { New-Item -ItemType Directory -Force (Join-Path $state 'notes') | Out-Null }
  foreach ($f in $files) {
    $p = Join-Path $state $f
    if (-not (Test-Path $p)) { Set-Content -Path $p -Value "# $f ($name)`n" -Encoding utf8 }
  }
  # Giao thức ngắn của project (mọi project, kể cả có Knowns): tạo từ mẫu, người dùng và Lead điền sau
  $proto = Join-Path $state 'protocol.md'
  if (-not (Test-Path $proto)) {
    $tpl = Join-Path $Hub 'slp\templates\protocol.md'
    if (Test-Path $tpl) { (Get-Content $tpl -Raw -Encoding utf8).Replace('<tên>', $name) | Set-Content $proto -Encoding utf8 -NoNewline }
  }
  $agents = Join-Path $state 'agents.md'
  if (-not (Test-Path $agents)) {
    Set-Content $agents "# SLP agents ($name)`n`n| Thời điểm | Tên | Vai trò | Provider | Model | Agent ID | Task | Trạng thái |`n|---|---|---|---|---|---|---|---|" -Encoding utf8
  }
  $state
}

switch ($Cmd) {
  'help' { Get-Help $PSCommandPath -Detailed | Out-String | Write-Host; break }

  'ls' {
    $reg = Read-Registry
    $reg.Keys | ForEach-Object {
      [pscustomobject]@{ Project = $_; Path = $reg[$_]; Exists = (Test-Path $reg[$_]); Git = (Test-Path (Join-Path $reg[$_] '.git')); Knowns = (Test-Path (Join-Path $reg[$_] '.knowns')) }
    } | Format-Table -AutoSize
    break
  }

  'add' {
    if (-not $Project -or -not $Arg) { throw 'Dùng: .\slp.ps1 add <tên> <đường-dẫn>' }
    if ($Project -notmatch '^[a-z0-9-]+$') { throw 'Tên project chỉ gồm chữ thường, số và dấu gạch ngang.' }
    $full = (Resolve-Path $Arg).Path
    $reg = Read-Registry; $reg[$Project] = $full; Save-Registry $reg
    Write-Host "Đã nhớ: $Project -> $full"
    break
  }

  'rm' {
    $reg = Read-Registry
    if (-not $reg.Contains($Project)) { throw "Chưa nhớ project '$Project'." }
    $reg.Remove($Project); Save-Registry $reg
    Write-Host "Đã bỏ nhớ '$Project' (không đụng vào project và projects\$Project\)."
    break
  }

  'status' {
    # paseo ls mặc định chỉ liệt kê agent của thư mục hiện tại -> dùng -g (mọi thư mục) và lọc theo nhãn
    $cliArgs = @('ls', '-g')
    if ($Project) { $cliArgs += @('--label', "slp-project=$Project") }
    & $Paseo @cliArgs | Where-Object { $_ -match '^AGENT ID' -or $_ -match 'SLP ' }
    break
  }

  'run' {
    $projPath = Get-ProjectPath $Project
    $hasKnowns = Test-Path (Join-Path $projPath '.knowns')
    $state = Initialize-State $Project $hasKnowns
    if (-not $Name) { $Name = "$Role-" + (Get-Date -Format 'MMdd-HHmmss') }

    # Việc cần làm: ID task Knowns, file có sẵn, hoặc chữ -> ghi ra file UTF-8 (tránh lỗi mã hóa khi truyền qua paseo.cmd)
    $taskFile = $null; $knownsTask = $null
    if ($Arg -and $hasKnowns -and $Arg -match '^(KN-)?[A-Za-z0-9]{6}$') {
      Push-Location $projPath
      $prevEap = $ErrorActionPreference; $ErrorActionPreference = 'Continue'   # knowns có thể in cảnh báo ra stderr (vd: cần migrate)
      try { $null = & knowns task $Arg --plain 2>&1; $ok = ($LASTEXITCODE -eq 0) } finally { $ErrorActionPreference = $prevEap; Pop-Location }
      if (-not $ok) { throw "Không tìm thấy task Knowns '$Arg' trong $Project (xem: knowns task list --plain)" }
      $knownsTask = $Arg
    }
    if ($knownsTask) { }
    elseif ($Arg) {
      if (Test-Path $Arg -PathType Leaf) { $taskFile = (Resolve-Path $Arg).Path }
      else {
        $taskFile = Join-Path $state "inbox\task-$Name.md"
        $taskText = "# Task $Name ($Project)`n`n$Arg`n"   # ghi ra file sau bước DryRun
      }
    }
    elseif ($Role -eq 'peer') { throw 'Peer cần việc cần làm: .\slp.ps1 run <tên> "<việc>" hoặc <file.md>' }

    if ($Provider -eq 'claude' -and -not $Mode) { $Mode = 'bypassPermissions' }

    $prompt = "You are SLP $Role '$Name' for project '$Project'. " +
    "Role instructions: $Roles\$Role.md - read and follow them first. " +
    "SLP orchestration folder for this project (inbox, reports, agents): $state - this is the 'SLP folder' your role file refers to. " +
    "Short project protocol (test commands, forbidden areas, anti-patterns): $state\protocol.md - read it once before starting. " +
    "Work in the current directory (the project repo)."
    if ($hasKnowns) {
      $prompt += " This project uses Knowns (.knowns/) as the source of truth for docs, tasks and decisions - see the 'Knowns' section of your role file. " +
      "Before starting, pull relevant context with: knowns retrieve `"<topic>`" --plain (also: knowns doc list --plain, knowns doc `"<path>`" --plain). Do not copy project docs into the SLP folder."
    }
    else {
      $prompt += " Project docs and notes (deployment info, environments, conventions): $state\notes - check them when relevant."
    }
    if ($knownsTask) {
      $prompt += " Your task is Knowns task $knownsTask - read it with: knowns task $knownsTask --plain. Follow the Knowns task workflow in your role file (in-progress -> plan/notes -> check ACs -> in-review; never set done)."
    }
    if ($taskFile) { $prompt += " Your task is in $taskFile - read it fully before starting." }
    $prompt += " When finished, write your report to $state\inbox\$Name-report.md and end your turn; the conductor is notified automatically."

    $cliArgs = @('run', '--no-wait', '--json', '--title', "SLP $Project $Role $Name",
      '--label', "slp=$Role", '--label', "slp-project=$Project", '--label', "slp-name=$Name",
      '--provider', $Provider, '--cwd', $projPath)
    if ($Model) { $cliArgs += @('--model', $Model) }
    if ($Mode) { $cliArgs += @('--mode', $Mode) }
    if ($Worktree) {
      if (-not (Test-Path (Join-Path $projPath '.git'))) { throw "$projPath chưa là git repo, không tạo worktree được." }
      $cliArgs += @('--new-workspace', 'worktree', '--worktree-slug', "slp-$Name", '--new-branch', "slp/$Name")
    }
    $cliArgs += $prompt

    if ($DryRun) { Write-Host "[DryRun] paseo $($cliArgs -join ' | ')"; break }
    if ($taskText) { [IO.File]::WriteAllText($taskFile, $taskText, (New-Object Text.UTF8Encoding $false)) }

    $out = & $Paseo @cliArgs | Out-String
    if ($LASTEXITCODE -ne 0) { throw "paseo run lỗi (exit $LASTEXITCODE): $out" }
    $id = ($out | ConvertFrom-Json).agentId
    $taskRel = if ($knownsTask) { "knowns:$knownsTask" } elseif ($taskFile) { $taskFile.Replace("$Data\", '') } else { '' }
    Add-Content (Join-Path $state 'agents.md') ("| {0} | {1} | {2} | {3} | {4} | {5} | {6} | đang làm |" -f (Get-Date -Format 'yyyy-MM-dd HH:mm'), $Name, $Role, $Provider, $Model, $id, $taskRel) -Encoding utf8
    Write-Host "Đã tạo agent '$Name' cho '$Project' trên Paseo: $id"

    if ($Wait) {
      & $Paseo wait $id | Out-Null
      $report = Join-Path $state "inbox\$Name-report.md"
      if (Test-Path $report) { Get-Content $report -Raw -Encoding utf8 } else { Write-Host "Agent đã xong nhưng chưa thấy báo cáo $report" }
    }
    else { $id }
    break
  }
}
