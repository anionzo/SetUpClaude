<#
  SLP - dừng mọi session có tên bắt đầu bằng "slp-". Hội thoại vẫn được giữ lại (claude attach / --resume để mở lại).
  BẢN NHÁP: chưa chạy thử.
#>
$ErrorActionPreference = 'Stop'
$sessions = claude agents --json | Out-String | ConvertFrom-Json
$slp = @($sessions | Where-Object { $_.name -like 'slp-*' })
if ($slp.Count -eq 0) { Write-Host 'Không có session slp-* nào đang chạy.'; return }
foreach ($s in $slp) {
  Write-Host "Dừng $($s.name) ($($s.sessionId))"
  # Nếu 'claude stop' không nhận tên, thay bằng $s.sessionId hoặc short id lấy từ 'claude agents'
  claude stop $s.name
}
