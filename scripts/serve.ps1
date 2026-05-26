$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

& (Join-Path $PSScriptRoot 'build.ps1')

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
    $python = Get-Command py -ErrorAction SilentlyContinue
}

if (-not $python) {
    throw 'Python is required to serve the generated book directory.'
}

$port = 3001
$url = "http://localhost:$port/"
$buildScript = Join-Path $PSScriptRoot 'build.ps1'

$watcherJob = Start-Job -ArgumentList $repoRoot, $buildScript -ScriptBlock {
    param($repoRoot, $buildScript)

    Set-Location $repoRoot

    function Get-SourceStamp {
        $files = @(Get-ChildItem -LiteralPath (Join-Path $repoRoot 'src') -Recurse -File)
        $files += Get-Item -LiteralPath (Join-Path $repoRoot 'book.toml')

        $latest = $files | Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
        return "$($files.Count):$($latest.LastWriteTimeUtc.Ticks)"
    }

    $lastStamp = Get-SourceStamp

    while ($true) {
        Start-Sleep -Milliseconds 750
        $currentStamp = Get-SourceStamp

        if ($currentStamp -ne $lastStamp) {
            Start-Sleep -Milliseconds 500

            try {
                powershell -ExecutionPolicy Bypass -File $buildScript
            }
            catch {
                Write-Error $_
            }

            $lastStamp = Get-SourceStamp
        }
    }
}

$serverArgs = @('-m', 'http.server', "$port", '--directory', 'book')
if ($python.Name -eq 'py.exe') {
    $serverArgs = @('-3') + $serverArgs
}

$server = $null

try {
    $server = Start-Process $python.Source -ArgumentList $serverArgs -WorkingDirectory $repoRoot -PassThru -WindowStyle Hidden

    Start-Sleep -Seconds 1
    Start-Process $url

    Write-Host "Serving generated book at $url"
    Write-Host 'Press Ctrl+C to stop.'

    Wait-Process -Id $server.Id
}
finally {
    if ($server -and -not $server.HasExited) {
        Stop-Process -Id $server.Id -Force
    }

    if ($watcherJob) {
        Stop-Job $watcherJob -ErrorAction SilentlyContinue
        Remove-Job $watcherJob -Force -ErrorAction SilentlyContinue
    }
}
