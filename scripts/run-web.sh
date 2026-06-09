#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
config_file="$repo_root/.env.local"

if [[ ! -f "$config_file" ]]; then
  echo "Missing $config_file. Copy .env.example and add the Supabase publishable configuration."
  exit 1
fi

cd "$repo_root/mobile_app"

flutter run \
  -d chrome \
  --dart-define-from-file="$config_file"
