# SUMO Verification Script
# Run this in a NEW PowerShell window

Write-Host "`n=== SUMO Installation Verification ===" -ForegroundColor Cyan

# Check SUMO_HOME
Write-Host "`n1. Checking SUMO_HOME..." -ForegroundColor Yellow
$sumoHome = $env:SUMO_HOME
if ($sumoHome) {
    Write-Host "   ✓ SUMO_HOME is set to: $sumoHome" -ForegroundColor Green
} else {
    Write-Host "   ✗ SUMO_HOME is not set" -ForegroundColor Red
    Write-Host "   Run: setx SUMO_HOME 'C:\Program Files (x86)\Eclipse\Sumo'" -ForegroundColor Yellow
}

# Check if SUMO binary exists
Write-Host "`n2. Checking SUMO binary..." -ForegroundColor Yellow
$sumoBinary = "C:\Program Files (x86)\Eclipse\Sumo\bin\sumo.exe"
if (Test-Path $sumoBinary) {
    Write-Host "   ✓ SUMO binary found at: $sumoBinary" -ForegroundColor Green
} else {
    Write-Host "   ✗ SUMO binary not found" -ForegroundColor Red
    Write-Host "   Please check SUMO installation" -ForegroundColor Yellow
}

# Check if SUMO is in PATH
Write-Host "`n3. Checking if SUMO is in PATH..." -ForegroundColor Yellow
try {
    $version = & sumo --version 2>&1
    Write-Host "   ✓ SUMO is accessible from PATH" -ForegroundColor Green
    Write-Host "   Version: $version" -ForegroundColor Cyan
} catch {
    Write-Host "   ✗ SUMO is not in PATH" -ForegroundColor Red
    Write-Host "   Please restart PowerShell and try again" -ForegroundColor Yellow
}

# Check Python packages
Write-Host "`n4. Checking Python packages..." -ForegroundColor Yellow
try {
    $packages = pip list 2>&1 | Select-String -Pattern "stable-baselines3|gymnasium|torch"
    if ($packages) {
        Write-Host "   ✓ Required packages found:" -ForegroundColor Green
        $packages | ForEach-Object { Write-Host "     $_" -ForegroundColor Cyan }
    } else {
        Write-Host "   ✗ Required packages not installed" -ForegroundColor Red
        Write-Host "   Run: pip install -r requirements.txt" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ⚠ Could not check Python packages" -ForegroundColor Yellow
}

Write-Host "`n=== Summary ===" -ForegroundColor Cyan
Write-Host "If all checks passed (✓), you're ready to train!" -ForegroundColor Green
Write-Host "If any failed (✗), follow the suggestions above.`n" -ForegroundColor Yellow

Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. If SUMO is not in PATH, CLOSE this PowerShell and open a NEW one" -ForegroundColor White
Write-Host "2. Run: pip install -r requirements.txt" -ForegroundColor White
Write-Host "3. Run: cd src" -ForegroundColor White
Write-Host "4. Run: python train.py`n" -ForegroundColor White
