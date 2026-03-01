---
name: validate
description: ドキュメント整合性とアーキテクチャルールを一括チェックし、違反があれば修正
allowed-tools:
  - Bash
  - Read
  - Edit
  - Grep
  - Glob
---

# プロジェクトバリデーション

ドキュメントと実装の整合性、およびアーキテクチャルールを一括チェックする。
違反があれば修正まで行う。

## 手順

1. バリデーションスクリプトを実行する:

   ```bash
   bash .claude/scripts/validate_docs.sh <<< '{}'
   ```

2. 出力を分析する:
   - JSON 出力がなければ全チェック通過。結果を報告して終了
   - `{"decision":"block","reason":"..."}` が出力された場合、各エラーを分類して対応

3. エラーを修正する:
   - 各エラーについて該当ファイルを読み、適切に修正
   - 修正後、再度スクリプトを実行して通過を確認

## チェック項目

スクリプトは以下の7カテゴリをチェックする:

### ドキュメント整合性

- **パス存在確認**: CLAUDE.md / README.md 内のバッククォート記法 `lib/...` パスが実在するか
- **feature 網羅**: `lib/features/` 配下の全ディレクトリが CLAUDE.md に記載されているか

### アーキテクチャルール

- **配置ルール**: Controller は `presentation/`、Repository・DataSource は `data/`、Service は `domain/` に配置されているか
- **StatefulWidget 禁止**: `lib/` 配下に `StatefulWidget` / `State<>` が存在しないか
- **final class**: 具象クラスが `final class` で宣言されているか（freezed / abstract / sealed 除外）

### Provider 定義

- **手動 Provider 禁止**: `final xxxProvider = Provider(...)` 等の手動定義がないか（`@riverpod` アノテーションを使用すること）

### コード生成

- **生成ファイル欠落**: `@riverpod` には `.g.dart`、`@freezed` には `.freezed.dart` が存在するか

## 注意事項

- 生成ファイル欠落の場合は `fvm dart run build_runner build -d` を実行して解決する
- ドキュメントのパス修正時は、実装側とドキュメント側のどちらを直すべきか判断する

$ARGUMENTS
