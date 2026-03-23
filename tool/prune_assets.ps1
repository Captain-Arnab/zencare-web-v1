# Keeps only asset files referenced by the Flutter app. Run from repo root:
#   powershell -ExecutionPolicy Bypass -File tool/prune_assets.ps1
$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
$assets = Join-Path $root "assets"
if (-not (Test-Path $assets)) { throw "assets folder not found" }

$keep = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
function Add-Keep([string]$rel) {
  $p = [System.IO.Path]::GetFullPath((Join-Path $assets ($rel -replace "/", [IO.Path]::DirectorySeparatorChar)))
  [void]$keep.Add($p)
}

Add-Keep "fonts/Feather144f144f.ttf"
Add-Keep "about/whychooseus.jpg"

foreach ($n in 1..4) { Add-Keep "AC_Service/ACService$n.png" }
foreach ($n in 1..8) { Add-Keep "Chimneyservice/$n.png" }
foreach ($n in 1..5) { Add-Keep "CleaningServices/$n.png" }
foreach ($n in 1..6) { Add-Keep "MenSalon/$n.png" }
foreach ($n in 1..7) { Add-Keep "PestControl/$n.png" }
foreach ($n in 1..9) { Add-Keep "RefrigeratorService/$n.png" }
foreach ($n in 1..5) { Add-Keep "WashingMachine/$n.png" }
foreach ($n in 1..8) { Add-Keep "WaterPurifierService/$n.png" }
foreach ($n in 1..6) { Add-Keep "WomenSalon/$n.png" }
foreach ($n in 1..7) { Add-Keep "carpentry_service/$n.png" }

Add-Keep "img/logos.jpg"
Add-Keep "img/banner.png"
Add-Keep "img/scan-img.png"
foreach ($n in 1..5) { Add-Keep ("img/partner/partner-{0:D2}.svg" -f $n) }
Add-Keep "img/profiles/avatar-01.jpg"
Add-Keep "img/profiles/avatar-02.jpg"
Add-Keep "img/profiles/avatar-03.jpg"
Add-Keep "img/bg/ellipse-01.png"
Add-Keep "img/bg/ellipse-02.png"
Add-Keep "img/bg/dot-white.png"
Add-Keep "img/bg/phone.png"
Add-Keep "img/bg/work-bg-01.svg"
Add-Keep "img/bg/work-bg-02.svg"
Add-Keep "img/services/service-75.jpg"
Add-Keep "img/providers/provider-23.jpg"

$icons = @(
  "about-hands.svg", "about-documents.svg", "about-book.svg", "group-stars.svg", "expert-team.svg",
  "expereience.svg", "app-store.svg", "google-play.svg", "fb.svg", "instagram.svg", "twitter.svg",
  "whatsapp.svg", "youtube.svg", "linkedin.svg"
)
foreach ($i in $icons) { Add-Keep "img/icons/$i" }

Add-Keep "icons/work-01.svg"
Add-Keep "icons/work-icon-01.svg"
Add-Keep "icons/work-03.svg"
foreach ($n in 1..9) { Add-Keep "icons/home/$n.png" }

$removed = 0

# If img/profiles was restored from git, drop unused avatars (app only uses 01–03).
$profilesDir = Join-Path $assets "img/profiles"
if (Test-Path $profilesDir) {
  Get-ChildItem $profilesDir -File -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -notmatch '^avatar-0[123]\.jpg$' } |
    ForEach-Object { Remove-Item $_.FullName -Force; $script:removed++ }
}

Get-ChildItem $assets -Recurse -File | ForEach-Object {
  if (-not $keep.Contains($_.FullName)) {
    Remove-Item $_.FullName -Force
    $script:removed++
  }
}

Get-ChildItem $assets -Recurse -Directory | Sort-Object { $_.FullName.Length } -Descending | ForEach-Object {
  if (-not (Get-ChildItem $_.FullName -Force -ErrorAction SilentlyContinue)) {
    Remove-Item $_.FullName -Force -ErrorAction SilentlyContinue
  }
}

Write-Host "Prune complete. Removed $removed files. Kept $($keep.Count) paths."
