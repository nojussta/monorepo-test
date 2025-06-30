Write-Host "Checking for changes in frontend apps..."

if ($env:GITHUB_REF_NAME -ne "main") {
    $baseRef = $env:GITHUB_EVENT_BEFORE
    $headRef = $env:GITHUB_SHA
}
else {
    $baseRef = "origin/main~1"
    $headRef = "origin/main"
}

$changedFiles = git diff --name-only $baseRef $headRef
                              
$apps = @("FE1_PATHS", "FE2_PATHS")
foreach ($app in $apps) {
    $changed = $false
    $paths = ${env:$app} -split "`n" | Where-Object { $_ -ne "" }
    foreach ($path in $paths) {
        if ($changedFiles -match "^$path") {
            $changed = $true
            break
        }
    }
    $key = $app.ToLower() -replace "_paths", ""
    Add-Content -Path $env:GITHUB_OUTPUT -Value "$key`_changed=$changed"
}