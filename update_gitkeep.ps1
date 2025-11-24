# PowerShell script to create/update .gitkeep files with content in empty directories or directories only containing .gitkeep or empty dirs

$directories = Get-ChildItem -Path '.' -Directory -Recurse | Sort-Object FullName -Descending

$updatedDirs = @()

function Is-DirEmptyOrHasOnlyGitkeepOrEmptyFolders($dir) {
    $items = Get-ChildItem -Path $dir.FullName -Force
    foreach ($item in $items) {
        if ($item.PSIsContainer) {
            if (-not (Is-DirEmptyOrHasOnlyGitkeepOrEmptyFolders $item)) {
                return $false
            }
        } else {
            if ($item.Name -ne '.gitkeep') {
                return $false
            }
        }
    }
    return $true
}

foreach ($dir in $directories) {
    if (Is-DirEmptyOrHasOnlyGitkeepOrEmptyFolders $dir) {
        $gitkeepPath = Join-Path $dir.FullName '.gitkeep'
        $content = "# This file ensures the directory is tracked by Git.`n"
        $existingContent = ""
        if (Test-Path $gitkeepPath) {
            $existingContent = Get-Content $gitkeepPath -Raw
        }
        if ($existingContent -ne $content) {
            Set-Content -Path $gitkeepPath -Value $content -Force
            $updatedDirs += $dir.FullName
        }
    }
}

Write-Output $updatedDirs
