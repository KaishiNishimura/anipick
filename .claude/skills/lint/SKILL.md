---
name: lint
description: プロジェクト全体の Dart format・静的解析・Markdown lint を実行し、警告があれば修正
allowed-tools:
  - Bash
  - Read
  - Edit
  - Grep
  - Glob
---

# プロジェクト全体 lint

Dart のフォーマット・静的解析と Markdown の lint をプロジェクト全体に実行する。
警告があれば修正まで行う。

## 手順

1. 共通スクリプトを引数なしで実行する（プロジェクト全体モード）:

   ```bash
   bash .claude/scripts/lint.sh
   ```

2. 結果を分析する:
   - 警告・エラーがなければ結果を報告して終了
   - 警告がある場合、該当ファイルを読んで修正

3. 修正後、再度スクリプトを実行して警告ゼロを確認する

## 注意事項

- 自動生成ファイル（`.g.dart` / `.freezed.dart`）の警告は無視する
- フォーマットの変更は意図的なスタイルなので、そのまま適用する
- 解析エラーが `build_runner` 未実行に起因する場合は先に生成を促す

$ARGUMENTS
