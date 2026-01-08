# RL vs Fixed Timer Comparison - Quick Start Script
# This script helps you run the comparison step-by-step

Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "🚦 RL vs FIXED TIMER COMPARISON - QUICK START" -ForegroundColor Cyan
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

Write-Host "This will guide you through comparing RL and Fixed Timer systems." -ForegroundColor Yellow
Write-Host ""
Write-Host "Both simulations will use:" -ForegroundColor Green
Write-Host "  ✅ Same traffic file (routes.rou.xml)" -ForegroundColor Green
Write-Host "  ✅ Same vehicle frequencies" -ForegroundColor Green
Write-Host "  ✅ Same simulation duration" -ForegroundColor Green
Write-Host ""
Write-Host "Only difference:" -ForegroundColor Yellow
Write-Host "  📍 Fixed Timer: 65-second constant green light" -ForegroundColor Red
Write-Host "  🤖 RL Agent: 15-60 second dynamic green light (AI-predicted)" -ForegroundColor Magenta
Write-Host ""
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""

# Step 1: Fixed Timer
Write-Host "📍 STEP 1: Run Fixed Timer Simulation" -ForegroundColor Red
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""
Write-Host "This will run the fixed-timer traffic control (65s green)." -ForegroundColor White
Write-Host "Watch the SUMO GUI window and dashboard." -ForegroundColor White
Write-Host ""
$response = Read-Host "Press ENTER to start Fixed Timer simulation (or 'skip' to skip)"

if ($response -ne "skip") {
    Write-Host "🚀 Starting Fixed Timer..." -ForegroundColor Yellow
    cd src
    python demo_fixed.py
    cd ..
    Write-Host ""
    Write-Host "✅ Fixed Timer simulation complete!" -ForegroundColor Green
    Write-Host "📁 Metrics saved to: comparison_results/fixed_timer_metrics.json" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "⏭️  Skipped Fixed Timer simulation" -ForegroundColor Yellow
    Write-Host ""
}

# Step 2: RL
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "🤖 STEP 2: Run RL Simulation" -ForegroundColor Magenta
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""
Write-Host "This will run the RL-based traffic control (dynamic 15-60s green)." -ForegroundColor White
Write-Host "Watch the SUMO GUI window and dashboard." -ForegroundColor White
Write-Host ""
$response = Read-Host "Press ENTER to start RL simulation (or 'skip' to skip)"

if ($response -ne "skip") {
    Write-Host "🚀 Starting RL Agent..." -ForegroundColor Yellow
    cd src
    python demo_rl.py
    cd ..
    Write-Host ""
    Write-Host "✅ RL simulation complete!" -ForegroundColor Green
    Write-Host "📁 Metrics saved to: comparison_results/rl_metrics.json" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "⏭️  Skipped RL simulation" -ForegroundColor Yellow
    Write-Host ""
}

# Step 3: Generate Report
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "📊 STEP 3: Generate Comparison Report" -ForegroundColor Magenta
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""
Write-Host "This will create a detailed comparison report with charts." -ForegroundColor White
Write-Host ""
$response = Read-Host "Press ENTER to generate report (or 'skip' to skip)"

if ($response -ne "skip") {
    Write-Host "🚀 Generating comparison report..." -ForegroundColor Yellow
    cd src
    python generate_comparison_report.py
    cd ..
    Write-Host ""
    Write-Host "✅ Report generation complete!" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "⏭️  Skipped report generation" -ForegroundColor Yellow
    Write-Host ""
}

# Summary
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host "🎉 COMPARISON COMPLETE!" -ForegroundColor Green
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""
Write-Host "📁 Your results are in:" -ForegroundColor Yellow
Write-Host "   ➡️  comparison_results/comparison_report.md" -ForegroundColor White
Write-Host "   ➡️  comparison_results/comparison_charts/" -ForegroundColor White
Write-Host ""
Write-Host "👀 To view the report:" -ForegroundColor Yellow
Write-Host "   start comparison_results\comparison_report.md" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 To view the charts:" -ForegroundColor Yellow
Write-Host "   start comparison_results\comparison_charts" -ForegroundColor Cyan
Write-Host ""
Write-Host "=" * 70 -ForegroundColor Cyan
Write-Host ""
Write-Host "Ready to present to evaluators! 🎯" -ForegroundColor Green
Write-Host ""
