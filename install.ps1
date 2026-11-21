# ==============================================================================
# ELEGANS: 6-AGENT MASTER FRONTEND SWARM INSTALLER (WINDOWS POWERSHELL)
# 100% Rust Engine · Zero Python · Universal Agent Harness Compatibility
# ==============================================================================

param (
    [string]$TargetDir = "."
)

$TargetDir = (Resolve-Path $TargetDir).Path
Write-Host "✨ Đang cài đặt Elegans vào: $TargetDir" -ForegroundColor Cyan

# 1. Tạo cây thư mục chuẩn
$dirs = @(
    "$TargetDir\ai\bin",
    "$TargetDir\ai\skills",
    "$TargetDir\.claude\agents",
    "$TargetDir\.claude\skills",
    "$TargetDir\.agents\plugins\fe-master-team\agents",
    "$TargetDir\.opencode"
)
foreach ($d in $dirs) {
    if (-not (Test-Path $d)) {
        New-Item -ItemType Directory -Path $d -Force | Out-Null
    }
}

# 2. Cài đặt binary fe-core.exe
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (Test-Path "$ScriptDir\ai\bin\fe-core.exe") {
    Copy-Item "$ScriptDir\ai\bin\fe-core.exe" "$TargetDir\ai\bin\fe-core.exe" -Force
} elseif (Get-Command cargo -ErrorAction SilentlyContinue) {
    Write-Host "🦀 Đang biên dịch fe-core bằng Cargo trên Windows..." -ForegroundColor Yellow
    Push-Location $ScriptDir
    cargo build --release
    Copy-Item "target\release\fe-core.exe" "$TargetDir\ai\bin\fe-core.exe" -Force
    Pop-Location
} else {
    Write-Host "⬇️  Đang tải binary fe-core.exe cho Windows x64..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "https://github.com/vmaxmartis09/elegans/releases/latest/download/fe-core-windows-x86_64.exe" -OutFile "$TargetDir\ai\bin\fe-core.exe"
}

# 3. Sao chép Agents & Skills
if (Test-Path "$ScriptDir\agents") {
    Copy-Item "$ScriptDir\agents\*.md" "$TargetDir\.claude\agents\" -Force
    Copy-Item "$ScriptDir\agents\*.md" "$TargetDir\.agents\plugins\fe-master-team\agents\" -Force
}

if (Test-Path "$ScriptDir\skills") {
    Copy-Item -Recurse "$ScriptDir\skills\*" "$TargetDir\ai\skills\" -Force
    Copy-Item -Recurse "$ScriptDir\skills\*" "$TargetDir\.claude\skills\" -Force
}

# 4. Sao chép Templates & Hooks
if (Test-Path "$ScriptDir\templates") {
    Copy-Item "$ScriptDir\templates\.claude\settings.json" "$TargetDir\.claude\settings.json" -Force -ErrorAction SilentlyContinue
    Copy-Item "$ScriptDir\templates\.agents\hooks.json" "$TargetDir\.agents\hooks.json" -Force -ErrorAction SilentlyContinue
    Copy-Item "$ScriptDir\templates\.opencode\opencode.json" "$TargetDir\opencode.json" -Force -ErrorAction SilentlyContinue
    Copy-Item "$ScriptDir\templates\.cursorrules" "$TargetDir\.cursorrules" -Force -ErrorAction SilentlyContinue
    Copy-Item "$ScriptDir\templates\AGENTS.md" "$TargetDir\AGENTS.md" -Force -ErrorAction SilentlyContinue
}

# 5. Đồng bộ
if (Test-Path "$TargetDir\ai\bin\fe-core.exe") {
    Push-Location $TargetDir
    & ".\ai\bin\fe-core.exe" sync | Out-Null
    Pop-Location
}

Write-Host ""
Write-Host "==========================================================================" -ForegroundColor Green
Write-Host "🎉 CHÚC MỪNG NGÀI VMAX! HỆ THỐNG ELEGANS ĐÃ ĐƯỢC CÀI ĐẶT THÀNH CÔNG!" -ForegroundColor Green
Write-Host "==========================================================================" -ForegroundColor Green
Write-Host "🏷️  6 Subagents sẵn sàng trên Windows & Mac" -ForegroundColor Cyan
Write-Host "🌐 Trình duyệt Ego Lite: Tự động phát hiện qua %LOCALAPPDATA%\ego" -ForegroundColor Cyan
Write-Host "🤖 Tương thích 100%: Claude Code · Antigravity · OpenCode · Codex · Cursor" -ForegroundColor Cyan
Write-Host "⚡ Lõi Rust fe-core: Sẵn sàng tại .\ai\bin\fe-core.exe" -ForegroundColor Cyan
Write-Host "==========================================================================" -ForegroundColor Green
