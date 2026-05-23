$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

mdbook build
mdbook build src/es
mdbook build src/en

New-Item -ItemType File -Path 'book/.nojekyll' -Force | Out-Null
