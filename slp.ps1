<#
  slp - một lệnh duy nhất để chạy SLP trên Paseo cho nhiều project.
  Kho dữ liệu (git riêng): D:\CODE\Supervision, hoặc biến SLP_HOME
    projects.json            sổ project (tên -> đường dẫn)
    projects\<tên>\          protocol, agents, supervisor-notes, inbox\ (tự tạo)
    .knowns\                 Knowns của kho: decision xuyên project; docs/task của project không có Knowns
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
    -Name <tên-agent>   -Wait (chờ xong rồi in báo cáo)   -DryRun (chỉ in lệnh)
    -Worktree [-Base <nhánh>]   làm trong worktree DÙNG CHUNG của project do Paseo quản lý (slug slp-<tên>, nhánh slp/<tên>,
                                nằm dưới project trong sidebar Paseo),
                                tách từ -Base (mặc định dev nếu có, không thì nhánh hiện tại). Tạo một lần, dùng lại mãi.
  MỘT project = MỘT workspace Paseo: run luôn tìm workspace đang mở đúng thư mục chạy và dùng lại; chỉ tạo mới khi
  chưa có. Không bao giờ tạo worktree/workspace riêng cho từng agent.
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
  [string]$Base,
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

function Invoke-Paseo([string[]]$argList) {
  # Gọi paseo, gộp stderr vào output mà không để PowerShell 5.1 biến dòng stderr thành lỗi (NativeCommandError).
  $prev = $ErrorActionPreference; $ErrorActionPreference = 'Continue'
  try { $o = & $Paseo @argList 2>&1 | ForEach-Object { "$_" } | Out-String } finally { $ErrorActionPreference = $prev }
  return $o
}

function Find-Workspace([string]$dir) {
  # Workspace Paseo đang mở đúng thư mục $dir (không tính cái đã archive). Trả về ID hoặc $null.
  $raw = & $Paseo workspace ls --json | Out-String
  if ($LASTEXITCODE -ne 0 -or -not $raw.Trim()) { return $null }
  $want = $dir.TrimEnd('\').ToLowerInvariant()
  $hit = ($raw | ConvertFrom-Json) | ForEach-Object { $_ } | Where-Object { ([string]$_.cwd).TrimEnd('\').ToLowerInvariant() -eq $want } | Select-Object -First 1
  if ($hit) { return $hit.workspaceId } else { return $null }
}

function Get-SharedWorktree([string]$repo, [string]$proj, [string]$base, [bool]$dry) {
  # Worktree DÙNG CHUNG duy nhất của project, do PASEO tạo và quản lý (nằm dưới project trong sidebar Paseo,
  # thư mục ~\.paseo\worktrees\<hash>\slp-<proj>, nhánh slp/<proj>). KHÔNG tự tạo bằng git worktree add:
  # Paseo sẽ coi thư mục đó là một project riêng. Có rồi thì dùng lại, chưa có mới tạo (một lần).
  if (-not (Test-Path (Join-Path $repo '.git'))) { throw "$repo chưa là git repo, không tạo worktree được." }
  $slug = "slp-$proj"; $branch = "slp/$proj"
  if (-not $base) {
    & git -C $repo show-ref --verify --quiet refs/heads/dev
    $base = if ($LASTEXITCODE -eq 0) { 'dev' } else { (& git -C $repo rev-parse --abbrev-ref HEAD).Trim() }
  }
  $raw = & $Paseo workspace ls --json | Out-String
  $hit = ($raw | ConvertFrom-Json) | ForEach-Object { $_ } | Where-Object { $_.isolation -eq 'worktree' -and (Split-Path ([string]$_.cwd) -Leaf) -eq $slug } | Select-Object -First 1
  if ($hit) { return @{ Path = ([string]$hit.cwd).TrimEnd('\'); Branch = $branch; Base = $base; WorkspaceId = $hit.workspaceId } }
  if ($dry) { Write-Host "[DryRun] paseo workspace create --isolation worktree --path $repo --new-branch $branch --base $base --worktree-slug $slug"; return @{ Path = "<paseo worktree $slug>"; Branch = $branch; Base = $base; WorkspaceId = $null } }
  & git -C $repo show-ref --verify --quiet "refs/heads/$branch"
  $wsArgs = if ($LASTEXITCODE -eq 0) { @('--mode', 'checkout-branch', '--branch', $branch) } else { @('--mode', 'branch-off', '--new-branch', $branch, '--base', $base) }
  $out = Invoke-Paseo (@('workspace', 'create', '--isolation', 'worktree', '--path', $repo) + $wsArgs + @('--worktree-slug', $slug, '--title', "SLP $proj", '--json'))
  if ($LASTEXITCODE -ne 0) { throw "Paseo không tạo được worktree ${slug}: $out" }
  $ws = $out.Substring([Math]::Max(0, $out.IndexOf('{'))) | ConvertFrom-Json
  return @{ Path = ([string]$ws.cwd).TrimEnd('\'); Branch = $branch; Base = $base; WorkspaceId = $ws.workspaceId }
}

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
  # Docs/task/decision: project có Knowns -> .knowns của project; không có -> Knowns của kho ($Data). Không tạo bản trùng ở đây
  $files = @('supervisor-notes.md')
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

    # Thư mục chạy: repo, hoặc worktree DÙNG CHUNG của project (một cái duy nhất, tạo một lần).
    $runDir = $projPath; $wtNote = ''; $wtWs = $null
    if ($Worktree) {
      $wt = Get-SharedWorktree $projPath $Project $Base $DryRun.IsPresent
      $runDir = $wt.Path; $wtWs = $wt.WorkspaceId
      $wtNote = " (the single shared SLP worktree of the repo, branch $($wt.Branch), based on $($wt.Base); agents use it one writer at a time)"
    }

    $prompt = "You are SLP $Role '$Name' for project '$Project'. " +
    "Role instructions: $Roles\$Role.md - read and follow them first. " +
    "SLP orchestration folder for this project (inbox, reports, agents): $state - this is the 'SLP folder' your role file refers to. " +
    "Short project protocol (test commands, forbidden areas, anti-patterns): $state\protocol.md - read it once before starting. " +
    "Project repo: $projPath. Your working directory must be $runDir$wtNote. Work only there. First check your working directory; if it is not $runDir, do not change anything: write a BLOCKED report and end your turn. Never create another worktree, branch-per-agent or Paseo workspace."
    if ($hasKnowns) {
      $prompt += " This project uses Knowns (.knowns/) as the source of truth for docs, tasks and decisions - see the 'Knowns' section of your role file. " +
      "Before starting, pull relevant context with: knowns retrieve 'TOPIC' --plain (also: knowns doc list --plain, knowns doc 'PATH' --plain). Do not copy project docs into the SLP folder."
    }
    else {
      $prompt += " This project has no Knowns of its own; its docs and decisions live in the hub Knowns at $Data (tag project:$Project). " +
      "Run from that directory: cd $Data; knowns retrieve '$Project TOPIC' --plain; knowns decision list --plain. Read only, except status, notes and acceptance checks of the tasks you are assigned; do not create or edit other entries there."
    }
    if ($knownsTask) {
      $prompt += " Your task is Knowns task $knownsTask - read it with: knowns task $knownsTask --plain. Follow the Knowns task workflow in your role file (in-progress -> plan/notes -> check ACs -> in-review; never set done)."
    }
    if ($taskFile) { $prompt += " Your task is in $taskFile - read it fully before starting." }
    $prompt += " When finished, write your report to $state\inbox\$Name-report.md and end your turn; the conductor is notified automatically."

    $cliArgs = @('run', '--no-wait', '--json', '--title', "SLP $Project $Role $Name",
      '--label', "slp=$Role", '--label', "slp-project=$Project", '--label', "slp-name=$Name",
      '--provider', $Provider, '--cwd', $runDir)
    if ($Model) { $cliArgs += @('--model', $Model) }
    if ($Mode) { $cliArgs += @('--mode', $Mode) }
    # MỘT workspace cho mỗi thư mục chạy: dùng lại cái đang mở, chỉ tạo khi chưa có. Phải chỉ định rõ, vì gọi từ
    # trong một agent Paseo thì Paseo mặc định gắn agent con vào workspace của agent gọi và BỎ QUA --cwd.
    $wsId = if ($wtWs) { $wtWs } else { Find-Workspace $runDir }
    if ($wsId) { $cliArgs += @('--workspace', $wsId) } else { $cliArgs += @('--new-workspace', 'local') }
    $cliArgs += $prompt

    if ($DryRun) { Write-Host "[DryRun] paseo $($cliArgs -join ' | ')"; break }
    if ($taskText) { [IO.File]::WriteAllText($taskFile, $taskText, (New-Object Text.UTF8Encoding $false)) }

    $out = Invoke-Paseo $cliArgs   # paseo in "Using/Created workspace ..." ra stderr; PS 5.1 coi đó là lỗi
    if ($LASTEXITCODE -ne 0) { throw "paseo run lỗi (exit $LASTEXITCODE): $out" }
    $json = $out.Substring([Math]::Max(0, $out.IndexOf('{'))) | ConvertFrom-Json   # paseo in thêm dòng 'Created workspace ...' trước JSON
    $id = $json.agentId
    # Kiểm agent chạy đúng chỗ: cwd phải đúng thư mục chạy (repo hoặc worktree dùng chung).
    $cwd = ([string]$json.cwd).TrimEnd('\')
    if (-not $wsId) {   # workspace mới tạo: đặt tên dễ nhìn
      $ws = Find-Workspace $runDir
      if ($ws) { & $Paseo workspace rename $ws "SLP $Project" | Out-Null }
    }
    if ($cwd -ne $runDir.TrimEnd('\')) {
      & $Paseo stop $id | Out-Null; & $Paseo archive $id | Out-Null
      throw "Agent $id chạy sai thư mục (cwd='$cwd', cần '$runDir'). Đã stop + archive, không giao việc."
    }
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
