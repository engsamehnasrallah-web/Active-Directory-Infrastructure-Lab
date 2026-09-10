<#
.SYNOPSIS
    Runs dcdiag on the local Domain Controller and saves the output to a timestamped report file.

.DESCRIPTION
    Part of the adlab.local infrastructure lab. Run this on a Domain Controller (e.g., DC01)
    with an account that has permission to run diagnostic tools (typically Domain Admin).

.NOTES
    Run from an elevated PowerShell prompt on the Domain Controller.
    Output is saved under a local "reports" folder next to this script.
#>

$ReportsFolder = Join-Path -Path $PSScriptRoot -ChildPath "reports"
if (-not (Test-Path $ReportsFolder)) {
    New-Item -ItemType Directory -Path $ReportsFolder | Out-Null
}

$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$ReportPath = Join-Path -Path $ReportsFolder -ChildPath "dcdiag-report_$Timestamp.txt"

Write-Host "Running dcdiag..." -ForegroundColor Cyan
dcdiag /v | Out-File -FilePath $ReportPath -Encoding UTF8

Write-Host "Report saved to: $ReportPath" -ForegroundColor Green
