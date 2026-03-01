#!/bin/bash
# Dart format / Flutter analyze / Markdown lint の共通スクリプト
#
# 使い方:
#   bash .claude/scripts/lint.sh              # プロジェクト全体
#   bash .claude/scripts/lint.sh path/to/file # 単一ファイル（Hook 用）

set -euo pipefail

DART_BIN=".fvm/flutter_sdk/bin/dart"
FLUTTER_BIN=".fvm/flutter_sdk/bin/flutter"
TARGET="${1:-}"

if [ -n "$TARGET" ]; then
  # --- 単一ファイル モード（PostToolUse Hook 用） ---
  case "$TARGET" in
    *.g.dart|*.freezed.dart)
      # 自動生成ファイルはスキップ
      ;;
    *.dart)
      "$DART_BIN" format "$TARGET" 2>&1
      "$FLUTTER_BIN" analyze "$TARGET" 2>&1 | head -20
      ;;
    *.md)
      npx --yes markdownlint-cli --fix "$TARGET" 2>&1
      npx --yes markdownlint-cli "$TARGET" 2>&1
      ;;
  esac
else
  # --- プロジェクト全体モード（Skill 用） ---
  echo "=== Dart format ==="
  "$DART_BIN" format lib/ 2>&1

  echo ""
  echo "=== Flutter analyze ==="
  "$FLUTTER_BIN" analyze 2>&1

  echo ""
  echo "=== Markdown lint ==="
  npx --yes markdownlint-cli --fix ./*.md 2>&1 || true
  npx --yes markdownlint-cli ./*.md 2>&1 || true
fi
