#!/bin/bash

LOG_DIR="$HOME/.local/log"
LOG_FILE="$LOG_DIR/mr-sync.log"
LOCK_DIR="$HOME/.local/state/mr-sync.lock"
mkdir -p "$LOG_DIR"

echo "=== mr sync: $(date) ===" >> "$LOG_FILE"

# Avoid overlapping runs from manual kickstart/retry.
if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "skip: lock exists ($LOCK_DIR)" >> "$LOG_FILE"
  exit 0
fi
trap 'rmdir "$LOCK_DIR" 2>/dev/null || true' EXIT

# Extra spread to reduce simultaneous push races across devices.
sleep "$((RANDOM % 180))"

if ! mr sync >> "$LOG_FILE" 2>&1; then
  terminal-notifier \
    -title "mr sync 실패" \
    -message "로그를 확인하세요" \
    -open "file://$LOG_FILE" 2>/dev/null || \
  osascript -e "display notification \"mr sync 실패. 로그를 확인하세요.\" with title \"mr sync\""
fi

echo "=== done: $(date) ===" >> "$LOG_FILE"
