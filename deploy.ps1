param (
    [string]$Username
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " ⚡ DATAWIRE.CC GITHUB PROFILE DEPLOYER " -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan

if (-not $Username) {
    $Username = Read-Host "Enter your exact GitHub username"
}

if (-not $Username) {
    Write-Host "[!] Error: GitHub username cannot be empty." -ForegroundColor Red
    exit 1
}

$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ReadmePath = Join-Path $CurrentDir "README.md"

if (Test-Path $ReadmePath) {
    Write-Host "[*] Patching README.md with username: $Username..." -ForegroundColor Yellow
    $content = Get-Content -Raw $ReadmePath
    $updated = $content -replace "YOUR_GITHUB_USERNAME", $Username
    Set-Content -Path $ReadmePath -Value $updated -NoNewline
    Write-Host "[+] README.md successfully updated." -ForegroundColor Green
} else {
    Write-Host "[!] Warning: README.md not found at $ReadmePath" -ForegroundColor Red
}

Write-Host "`n[*] Initializing local Git repository..." -ForegroundColor Yellow
Set-Location $CurrentDir

if (-not (Test-Path ".git")) {
    git init -b main
} else {
    git branch -M main
}

git add .
git commit -m "feat: deploy elite interactive cyber profile readme and snake workflow"

Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host " 🚀 NEXT STEP: PUSH TO GITHUB" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "1. Create a PUBLIC repository on GitHub named exactly: $Username" -ForegroundColor White
Write-Host "   (URL: https://github.com/new -> Repository name: $Username -> Public -> Create)" -ForegroundColor DarkGray
Write-Host ""
Write-Host "2. Link and push from this terminal with:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/$Username/$Username.git" -ForegroundColor Cyan
Write-Host "   git push -u origin main" -ForegroundColor Cyan
Write-Host ""
Write-Host "[!] NOTE ON AUTHENTICATION:" -ForegroundColor Yellow
Write-Host "    GitHub does NOT accept account passwords for git push operations."
Write-Host "    When prompted for password, paste a Personal Access Token (PAT):"
Write-Host "    Generate here: https://github.com/settings/tokens (classic token with 'repo' and 'workflow' scopes)." -ForegroundColor DarkGray
Write-Host "==================================================" -ForegroundColor Cyan
