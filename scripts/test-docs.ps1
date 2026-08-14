Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$markdownFiles = Get-ChildItem -Path $repoRoot -Recurse -File -Filter '*.md'
$brokenLinks = [System.Collections.Generic.List[string]]::new()

foreach ($file in $markdownFiles) {
    $content = Get-Content -Raw $file.FullName
    $matches = [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')

    foreach ($match in $matches) {
        $target = $match.Groups[1].Value
        if ($target -match '^(https?:|mailto:|#)') {
            continue
        }

        $relativePath = ($target -split '#', 2)[0]
        if ([string]::IsNullOrWhiteSpace($relativePath)) {
            continue
        }

        if (-not (Test-Path (Join-Path $file.DirectoryName $relativePath))) {
            $brokenLinks.Add("$($file.FullName): $target")
        }
    }
}

if ($brokenLinks.Count -gt 0) {
    $brokenLinks | ForEach-Object { Write-Error "Broken relative Markdown link: $_" }
    exit 1
}

Write-Output 'Documentation links are valid.'
