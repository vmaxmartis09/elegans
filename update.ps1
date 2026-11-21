# ==============================================================================
# ELEGANS UPDATE SCRIPT (WINDOWS POWERSHELL 1-LINE UPDATE)
# ==============================================================================
param (
    [string]$TargetDir = "."
)
Write-Host "🔄 Đang cập nhật Elegans tại thư mục: $TargetDir..." -ForegroundColor Cyan
irm https://raw.githubusercontent.com/vmaxmartis09/elegans/main/install.ps1 | iex
