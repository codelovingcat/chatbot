$emptyDirs = @()

$dirs = Get-ChildItem -Path '.' -Directory -Recurse | Sort-Object FullName -Descending

foreach ($dir in $dirs) {
    $files = Get-ChildItem -Path $dir.FullName
    if ($files.Count -eq 0) {
        $emptyDirs += $dir.FullName
    }
}

foreach ($dir in $emptyDirs) {
    New-Item -ItemType File -Path (Join-Path $dir '.gitkeep') -Force | Out-Null
}

Write-Output $emptyDirs
