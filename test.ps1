$env:FE1_PATHS = "apps/fe1, tools"
$env:FE2_PATHS = "apps/fe2, tools"
Write-Host "FE1_PATHS: $env:FE1_PATHS"
Write-Host "FE2_PATHS: $env:FE2_PATHS"


$apps = @('FE1_PATHS', 'FE2_PATHS')

foreach ($app in $apps) {
    $paths = ([System.Environment]::GetEnvironmentVariable($app) -split ",") | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
    echo $paths
}