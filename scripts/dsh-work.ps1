[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $DshArgument
)

$repoRoot = Split-Path -Parent $PSScriptRoot
$dshRoot = Join-Path $repoRoot 'packages/deepseek-harness'
$dshHome = Join-Path $repoRoot '.dsh'
$profileRoot = Join-Path $dshHome 'profiles/work'
$oauthPatch = Join-Path $repoRoot 'patches/dsh-oauth.patch'

if (-not (Test-Path (Join-Path $dshRoot 'package.json'))) {
    throw "The DeepSeek Harness submodule is missing. Run: git submodule update --init --recursive"
}

function Ensure-DshOauthPatch {
    if (-not (Test-Path $oauthPatch)) {
        return
    }

    Push-Location $dshRoot
    try {
        # The patch is product-owned source customization. A reverse check is
        # read-only and makes repeated launches idempotent; a forward check
        # refuses to overwrite unrelated submodule work.
        & git apply --reverse --check -- $oauthPatch 2>$null
        if ($LASTEXITCODE -eq 0) {
            return
        }

        & git apply --check -- $oauthPatch 2>$null
        if ($LASTEXITCODE -ne 0) {
            throw "DSH Work OAuth patch does not apply cleanly. Resolve the submodule changes or refresh patches/dsh-oauth.patch before starting."
        }

        & git apply -- $oauthPatch
        if ($LASTEXITCODE -ne 0) {
            throw "DSH Work OAuth patch application failed. The submodule was left unchanged by git apply."
        }
    }
    finally {
        Pop-Location
    }
}

Ensure-DshOauthPatch

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
