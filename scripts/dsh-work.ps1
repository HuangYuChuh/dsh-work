[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $DshArgument
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$dshRoot = Join-Path $repoRoot 'packages/deepseek-harness'
$dshHome = Join-Path $repoRoot '.dsh'
$profileRoot = Join-Path $dshHome 'profiles/work'

if (-not (Test-Path (Join-Path $dshRoot 'package.json'))) {
    throw "The DeepSeek Harness submodule is missing. Run: git submodule update --init --recursive"
}

if (-not (Test-Path (Join-Path $dshRoot 'node_modules'))) {
    throw "DSH dependencies are missing. Run: Set-Location packages/deepseek-harness; pnpm install --ignore-scripts; pnpm run build"
}

if (-not (Test-Path (Join-Path $profileRoot 'node_modules/@huiliyi37/dsh-office/package.json'))) {
    throw "DSH Work profile dependencies are missing. Run: Set-Location .dsh/profiles/work; pnpm install --ignore-scripts"
}

$env:DSH_HOME = $dshHome
Push-Location $dshRoot
try {
    & pnpm dsh --profile work @DshArgument
    exit $LASTEXITCODE
}
finally {
    Pop-Location
}
