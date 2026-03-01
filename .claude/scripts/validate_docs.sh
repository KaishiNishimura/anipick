#!/bin/bash
# CLAUDE.md / README.md と実装の整合性チェック（Stop Hook 用）
#
# 不整合があれば {"decision":"block","reason":"..."} を出力して
# Claude にドキュメント修正を促す。

set -euo pipefail

# 無限ループ防止: 2回目以降はスキップ
input=$(cat)
stop_hook_active=$(echo "$input" | jq -r '.stop_hook_active // false')
if [ "$stop_hook_active" = "true" ]; then
  exit 0
fi

cd "$(echo "$input" | jq -r '.cwd')"

errors=()

# --- 1. ファイルパスの存在チェック ---
# CLAUDE.md と README.md から lib/ で始まるパスを抽出し、実在するか確認
for doc in CLAUDE.md README.md; do
  [ -f "$doc" ] || continue
  # バッククォート内の lib/ パスを抽出（ディレクトリツリーのASCII art行は除外）
  paths=$(grep -oE '`lib/[^`]+`' "$doc" | tr -d '`' | sort -u)
  for p in $paths; do
    # ワイルドカードやプレースホルダーはスキップ
    [[ "$p" == *'*'* || "$p" == *'<'* ]] && continue
    if [ ! -e "$p" ]; then
      errors+=("$doc: パス '$p' が存在しません")
    fi
  done
done

# --- 2. feature ディレクトリの網羅チェック ---
# lib/features/ 配下のディレクトリが CLAUDE.md に記載されているか
if [ -d lib/features ] && [ -f CLAUDE.md ]; then
  for dir in lib/features/*/; do
    [ -d "$dir" ] || continue
    feature_name=$(basename "$dir")
    if ! grep -q "$feature_name" CLAUDE.md; then
      errors+=("CLAUDE.md: feature '$feature_name' が記載されていません")
    fi
  done
fi

# --- 3. 設計パターンの整合性チェック ---
# 各ファイルタイプが適切なディレクトリに配置されているか
while IFS= read -r -d '' file; do
  rel=${file#./}
  base=$(basename "$file")
  dir=$(dirname "$rel")

  case "$base" in
    *_controller.dart)
      [[ "$dir" == *presentation* ]] || \
        errors+=("設計違反: $rel — Controller は presentation/ 配下に配置してください")
      ;;
    *_repository.dart)
      [[ "$dir" == *data* ]] || \
        errors+=("設計違反: $rel — Repository は data/ 配下に配置してください")
      ;;
    *_datasource.dart)
      [[ "$dir" == *data* ]] || \
        errors+=("設計違反: $rel — DataSource は data/ 配下に配置してください")
      ;;
    *_service.dart)
      [[ "$dir" == *domain* ]] || \
        errors+=("設計違反: $rel — Service は domain/ 配下に配置してください")
      ;;
  esac
done < <(find lib/features -name '*.dart' ! -name '*.g.dart' ! -name '*.freezed.dart' -print0 2>/dev/null)

# --- 4. StatefulWidget 禁止チェック ---
stateful_files=$(grep -rl "extends StatefulWidget\|extends State<" lib/ --include="*.dart" 2>/dev/null || true)
if [ -n "$stateful_files" ]; then
  for f in $stateful_files; do
    errors+=("設計違反: $f — StatefulWidget は禁止です")
  done
fi

# --- 5. final class 使用チェック（freezed/abstract/sealed/mixin 除外） ---
while IFS= read -r line; do
  [ -z "$line" ] && continue
  errors+=("設計違反: final class を使用してください — $line")
done < <(grep -rn "^class \b" lib/features/ --include="*.dart" 2>/dev/null \
  | grep -v "\.g\.dart\|\.freezed\.dart" || true)

# --- 6. 手動 Provider 定義チェック ---
# @riverpod を使わず手動で Provider を定義しているファイルを検出
manual_providers=$(grep -rn \
  'final .*Provider\s*=\s*\(Provider\|StateProvider\|FutureProvider\|StreamProvider\|NotifierProvider\|AsyncNotifierProvider\|StateNotifierProvider\|ChangeNotifierProvider\)\b' \
  lib/ --include="*.dart" 2>/dev/null \
  | grep -v '\.g\.dart\|\.freezed\.dart' || true)
if [ -n "$manual_providers" ]; then
  while IFS= read -r line; do
    [ -z "$line" ] && continue
    errors+=("設計違反: 手動 Provider 定義を @riverpod アノテーションに置き換えてください — $line")
  done <<< "$manual_providers"
fi

# --- 7. 生成ファイル欠落チェック ---
# @riverpod → .g.dart が必要
while IFS= read -r f; do
  [ -z "$f" ] && continue
  g="${f%.dart}.g.dart"
  [ -f "$g" ] || errors+=("生成ファイル欠落: ${g} (build_runner を実行してください)")
done < <(grep -rl "@riverpod\|@Riverpod" lib/ --include="*.dart" 2>/dev/null \
  | grep -v "\.g\.dart\|\.freezed\.dart" || true)
# @freezed → .freezed.dart が必要
while IFS= read -r f; do
  [ -z "$f" ] && continue
  g="${f%.dart}.freezed.dart"
  [ -f "$g" ] || errors+=("生成ファイル欠落: ${g} (build_runner を実行してください)")
done < <(grep -rl "@freezed\|@Freezed" lib/ --include="*.dart" 2>/dev/null \
  | grep -v "\.g\.dart\|\.freezed\.dart" || true)

# --- 結果出力 ---
if [ ${#errors[@]} -gt 0 ]; then
  reason="ドキュメントと実装に不整合があります。修正してからセッションを終了してください:\n"
  for e in "${errors[@]}"; do
    reason+="- $e\n"
  done
  printf '{"decision":"block","reason":"%s"}' "$(echo -e "$reason" | sed 's/"/\\"/g')"
fi

exit 0
