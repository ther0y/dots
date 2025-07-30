#!/bin/bash

VAULT_DIR="$HOME/Notes"
LOG_DIR="$VAULT_DIR/+/inbox"

# ساخت لاگ از Obsidian
open -g "obsidian://adv-uri?vault=Notes&commandid=quickadd%3Achoice%3A2b7ae7d0-df59-4c63-a012-e054a0331d08"
sleep 0.7

# پیدا کردن آخرین فایل
LAST_LOG=$(find "$LOG_DIR" -type f -name "*.md" -exec stat -f "%B %N" {} + |
  sort -n | tail -1 | cut -d' ' -f2-)

if [ -z "$LAST_LOG" ] || [ ! -f "$LAST_LOG" ]; then
  echo "❌ No valid log file found"
  exit 1
fi

# اجرای مستقیم Ghostty بدون دخالت macOS open
/Applications/Ghostty.app/Contents/MacOS/ghostty -e nvim "$LAST_LOG" &
