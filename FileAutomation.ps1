$source  = Join-Path $PSScriptRoot "SampleFiles"
$archive = Join-Path $PSScriptRoot "Archive"
 
$cutoff = (Get-Date).AddDays(-30)
 
if (-not (Test-Path $archive)) {
    New-Item -Path $archive -ItemType Directory | Out-Null
}
 
$oldFiles = Get-ChildItem -Path $source -File |
    Where-Object { $_.LastWriteTime -lt $cutoff }
 
Write-Host "Cutoff date: $cutoff"
Write-Host "Found $($oldFiles.Count) file(s) older than 30 days."
 
foreach ($file in $oldFiles) {
    Move-Item -Path $file.FullName -Destination $archive -WhatIf
}