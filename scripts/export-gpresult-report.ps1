<#
.SYNOPSIS
    Runs gpresult for the currently logged-on user/computer and saves the output to a timestamped
    report file, in both a human-readable text format and an HTML format.

.DESCRIPTION
    Part of the adlab.local infrastructure lab. Run this on a domain-joined client (e.g., CLIENT01)
    while logged in as the user whose applied Group Policy you want to document.

.NOTES
    Run from a standard (non-elevated) PowerShell prompt — gpresult for the current user/computer
    does not require elevation.
    Output is saved under a local "reports" folder next to this script.
#>

$ReportsFolder = Join-Path -Path $PSScriptRoot -ChildPath "reports"
if (-not (Test-Path $ReportsFolder)) {
    New-Item -ItemType Directory -Path $ReportsFolder | Out-Null
}

$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$TextReportPath = Join-Path -Path $ReportsFolder -ChildPath "gpresult-report_$Timestamp.txt"
$HtmlReportPath = Join-Path -Path $ReportsFolder -ChildPath "gpresult-report_$Timestamp.html"

Write-Host "Running gpresult (text report)..." -ForegroundColor Cyan
gpresult /r | Out-File -FilePath $TextReportPath -Encoding UTF8

Write-Host "Running gpresult (HTML report)..." -ForegroundColor Cyan
gpresult /h $HtmlReportPath /f

Write-Host "Text report saved to: $TextReportPath" -ForegroundColor Green
Write-Host "HTML report saved to: $HtmlReportPath" -ForegroundColor Green
