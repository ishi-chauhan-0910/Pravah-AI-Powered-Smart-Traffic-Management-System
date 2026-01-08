# Pravah RL Training Startup Script
# This script sets up the environment and starts training

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  PRAVAH - AI Traffic Management" -ForegroundColor Cyan
Write-Host "  Starting RL Training..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set SUMO environment for current session
$env:SUMO_HOME = "C:\Program Files (x86)\Eclipse\Sumo"
$env:PATH += ";C:\Program Files (x86)\Eclipse\Sumo\bin"

# Verify SUMO
Write-Host "Checking SUMO..." -ForegroundColor Yellow
try {
    $version = & sumo --version 2>&1 | Select-Object -First 1
    Write-Host "SUCCESS: SUMO found - $version" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "ERROR: SUMO not found. Please check installation." -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Navigate to src directory
Set-Location -Path "src"

# Start training
Write-Host "Starting training..." -ForegroundColor Yellow
Write-Host "Training will take approximately 8-10 hours on CPU or 2-3 hours on GPU" -ForegroundColor Cyan
Write-Host ""

python train.py
