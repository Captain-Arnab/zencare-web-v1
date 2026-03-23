# Build Android App Bundle with Google Play reviewer login (no OTP for test account).
# Intended for the playstore-android branch / Play uploads only — not for general android branch builds.
#
# Setup:
#   1. Copy playstore_dart_defines.json.example to playstore_dart_defines.json in repo root.
#   2. Fill real values (same phone+password you will type in Play Console → App access).
#   3. Run: powershell -ExecutionPolicy Bypass -File tool/build_playstore_appbundle.ps1
#
# Git branch (run once):
#   git checkout android && git pull
#   git checkout -b playstore-android
#   git push -u origin playstore-android
#   Commit: example JSON, this script, tool/PLAY_CONSOLE_APP_ACCESS.txt — never commit playstore_dart_defines.json
#
$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
Set-Location $root

$definesFile = Join-Path $root "playstore_dart_defines.json"
$exampleFile = Join-Path $root "playstore_dart_defines.json.example"

if (-not (Test-Path $definesFile)) {
  Write-Host "Missing playstore_dart_defines.json"
  if (Test-Path $exampleFile) {
    Write-Host "Copying from playstore_dart_defines.json.example — edit it with real review credentials, then re-run."
    Copy-Item $exampleFile $definesFile
  }
  exit 1
}

flutter build appbundle --release --dart-define-from-file=$definesFile
Write-Host "Done. AAB under build/app/outputs/bundle/release/"
Write-Host "Paste reviewer instructions in Play Console using tool/PLAY_CONSOLE_APP_ACCESS.txt as a template."
