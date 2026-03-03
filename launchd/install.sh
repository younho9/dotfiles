#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_DIR="$HOME/Library/LaunchAgents"
LOG_DIR="$HOME/.local/log"

mkdir -p "$PLIST_DIR" "$LOG_DIR"

# Ensure PATH includes Homebrew
for dir in /opt/homebrew/bin /usr/local/bin; do
  [[ ":$PATH:" != *":$dir:"* ]] && export PATH="$dir:$PATH"
done

# Make scripts executable
chmod +x "$SCRIPT_DIR"/mr-sync.sh

# Stagger schedule across devices: choose a stable minute by hostname.
if [[ -z "${MR_SYNC_MINUTE:-}" ]]; then
  host_name="$(scutil --get LocalHostName 2>/dev/null || hostname)"
  MR_SYNC_MINUTE="$(( $(printf '%s' "$host_name" | cksum | awk '{print $1}') % 60 ))"
fi
export MR_SYNC_MINUTE

# Validate required vars
for var in HOME PATH MR_SYNC_MINUTE; do
  if [[ -z "${!var:-}" ]]; then
    echo "error: $var is not set" >&2
    exit 1
  fi
done

if ! [[ "$MR_SYNC_MINUTE" =~ ^[0-9]+$ ]] || (( MR_SYNC_MINUTE < 0 || MR_SYNC_MINUTE > 59 )); then
  echo "error: MR_SYNC_MINUTE must be 0..59 (current: $MR_SYNC_MINUTE)" >&2
  exit 1
fi

# Install plist templates
for template in "$SCRIPT_DIR"/*.plist.template; do
  [ -f "$template" ] || continue
  name=$(basename "$template" .template)
  label="${name%.plist}"
  target="$PLIST_DIR/$name"

  envsubst < "$template" > "$target"

  launchctl bootout "gui/$(id -u)/$label" 2>/dev/null || true
  launchctl bootstrap "gui/$(id -u)" "$target"
  echo "Installed and loaded $label (daily at 08:${MR_SYNC_MINUTE})"
done
