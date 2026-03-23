#!/usr/bin/env bash
# Same as build_playstore_appbundle.ps1 — for macOS/Linux CI.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
DEFINES="$ROOT/playstore_dart_defines.json"
EXAMPLE="$ROOT/playstore_dart_defines.json.example"
if [[ ! -f "$DEFINES" ]]; then
  echo "Missing playstore_dart_defines.json"
  if [[ -f "$EXAMPLE" ]]; then
    cp "$EXAMPLE" "$DEFINES"
    echo "Copied from example — edit with real values, then re-run."
  fi
  exit 1
fi
flutter build appbundle --release --dart-define-from-file="$DEFINES"
echo "Done. AAB: build/app/outputs/bundle/release/"
