# CLAUDE.md

このファイルは Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイドです。

## プロジェクト概要

AniPick は iOS/Android 向け Annict（アニメ視聴記録サービス）クライアント。
Flutter + Riverpod + Hooks でフィーチャーファースト構成で構築。

## よく使うコマンド

```bash
# セットアップ
fvm install
fvm flutter pub get

# コード生成（@riverpod / @freezed 変更後に必須）
fvm dart run build_runner build -d

# Markdown lint チェック（CLAUDE.md 等を編集した場合）
npx markdownlint-cli <file.md>

# アプリ実行（env/dev.json に OAuth 認証情報が必要）
fvm flutter run --dart-define-from-file=env/dev.json
```

## アーキテクチャ

**フィーチャーファースト構成:**

```text
lib/
├── app/              # App widget + GoRouter
├── core/             # 共有基盤
│   ├── env/          # 環境設定（Annict OAuth）
│   ├── exceptions/   # AppException（freezed sealed class）
│   ├── network/      # HTTP クライアント、HTTP 例外
│   ├── persistence/  # SecureStorage Provider
│   ├── theme/        # カラー、テキストスタイル、テーマ
│   └── widgets/      # 共通 Widget（NetworkImageWithFallback 等）
├── features/
│   ├── auth/         # 認証機能
│   │   ├── data/     # DataSource, Repository
│   │   ├── domain/   # Entity（freezed）
│   │   └── presentation/  # Controller, Page
│   └── season_works/ # シーズン作品機能
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── home_page.dart
│           ├── season_works_controller.dart
│           └── widgets/  # UI パーツ（10 ファイル）
├── gen/              # flutter_gen 自動生成
└── main.dart
```

**責務分離:**

| 層 | 責務 |
| --- | --- |
| Controller (AsyncNotifier) | AsyncValue 状態管理、UIアクション受付 |
| Service | ドメインロジック（計算・変換）、ステートレス |
| Repository | データ取得/保存 + JSON→Entity変換 + AppException throw |
| DataSource | API通信/ローカル永続化、生データを返す |

**主要パターン:**

- Provider は **必ず** `@riverpod` アノテーションで定義
  （手動の `final xxxProvider = Provider(...)` は禁止）
- Controller は `AsyncNotifier<T>` を拡張、状態は `AsyncValue<T>`
- モデルは全て `@freezed` で定義（copyWith, ==, hashCode 自動生成）。
  Entity は `fromJson` ファクトリで JSON パースも担う（DTO 層は不要）
- エラー処理: Repository が `AppException`（freezed sealed class）を throw →
  Riverpod が `AsyncValue.error` に変換 → UI が `.when(error:)` で表示
- ルーティング: `go_router` + `authControllerProvider` を watch して認証リダイレクト
- UI は `adaptive_platform_ui` でプラットフォーム対応
- Widget は `ConsumerWidget`, `HookConsumerWidget`, `HookWidget`,
  `StatelessWidget` のみ使用（StatefulWidget 禁止）

**依存スタック:**

```text
UI (Provider を watch)
  ↓
Controller (@riverpod AsyncNotifier)
  ↓
Repository + Service
  ↓
DataSource → API / LocalStorage
```

## Widget 設計ルール

**Widget 分割:**

- 1 Widget = 1 責務。build メソッドのネストが 5 段を超えたら private Widget クラスに分割
- helper メソッド（`Widget _buildXxx()`）ではなく private Widget クラスを使う
  （`const` コンストラクタで rebuild スキップ可能、DevTools で見やすい）
- `const` コンストラクタを付けられる Widget はすべて `const` にする

**Widget 型の選択:**

- Provider を watch/read + hooks → `HookConsumerWidget`
- Provider を watch/read のみ → `ConsumerWidget`
- hooks のみ → `HookWidget`
- どちらも不要 → `StatelessWidget`
- `StatefulWidget` は禁止

**条件分岐:**

- **switch 式を最優先**で使う（2 分岐でも switch）
- 三項演算子は使わない
- `...[]` で複数 Widget を条件付きで挿入
- Widget ツリー外のロジックは if-else

**Controller アクセス:**

- 子 Widget は基本的に Controller Provider を直接 watch/read する
- コールバックやデータのバケツリレーは行わない
- 例外: 汎用 Widget（PosterRow 等）はデータを props で受け取る

**AsyncValue:**

- 1 つの AsyncValue に対して `.when()` / switch は 1 回のみ
- 「何も表示しない」は `const SizedBox.shrink()`

**スペーサー:**

- スペーサーは `Gap(N)`（`gap` パッケージ）を使用
- `SizedBox(height:)` / `SizedBox(width:)` のスペーサー用途は禁止

**マジックナンバー禁止:**

- 数値リテラルを Widget に直接書かない
- `static const _名前 = 値;` で Widget クラスに定義する
- 対象: width, height, padding, borderRadius, iconSize,
  strokeWidth, opacity, spacing 等すべてのレイアウト数値
- Gap の引数も定数を使う（`const Gap(_sectionGap)`）
- 対象外: 0, 1 のような自明な値、アスペクト比（16/9）、
  clamp 境界値（0.0, 1.0）

**共通 Widget:**

- `NetworkImageWithFallback`（`lib/core/widgets/`）: ネットワーク画像の表示

**UI フレームワーク:**

- 画面の骨格: `AdaptiveScaffold`、AppBar: `AdaptiveAppBar`、ボタン: `AdaptiveButton`
- トースト: `AdaptiveSnackBar.show`
- Platform 差分は `adaptive_platform_ui` の自動判定に任せる（domain/data 層に持ち込まない）

## State 設計

- Controller の状態に含めないもの: `BuildContext`, `Widget`,
  `TextEditingController`, `FocusNode`, DataSource/Repository
- UIイベント（SnackBar 等）は State に混ぜず、UI 側で `AppException` を catch して処理

## 新機能作成チェックリスト

1. `domain/` に Entity（`@freezed` + `fromJson`）と Service を作る
2. `data/` に DataSource と Repository（`final class`）を作る
3. `@riverpod` で DataSource → Repository → Controller の順に provider を定義
4. `presentation/` に Controller（AsyncNotifier）と Page/Widget を作る

## 命名規則

- Controller: `XxxController` と `xxxControllerProvider`
- Service: `XxxService`（ステートレスなドメインロジック）
- Repository: `XxxRepository`（interface なし、直接実装）
- DataSource: `XxxRemoteDataSource`、`XxxLocalDataSource`
- Entity: `@freezed abstract class`
- クラス: 具体クラスは `final class` を使用（freezed 除く）
- ドキュメントコメント: 「〜する」ではなく「〜」で終わる（例: `/// 値を取得`）

## 主要ファイル

- エントリポイント: `lib/main.dart`
- ルーティング: `lib/app/router.dart`（GoRouter + 認証リダイレクト）
- アプリウィジェット: `lib/app/app.dart`（AdaptiveApp.router）
- 統一例外: `lib/core/exceptions/app_exception.dart`
- HTTP クライアント: `lib/core/network/http_client_provider.dart`
- SecureStorage: `lib/core/persistence/secure_storage_provider.dart`
- テーマ: `lib/core/theme/app_theme.dart`
- 環境設定: `lib/core/env/annict_env.dart`
- 共通 Widget: `lib/core/widgets/network_image_with_fallback.dart`

## 環境変数

`--dart-define-from-file` で OAuth 認証情報を読み込み:

- `ANNICT_CLIENT_ID`
- `ANNICT_CLIENT_SECRET`
- `ANNICT_REDIRECT_URI`（例：`anipick://oauth-callback`）
- `ANNICT_SCOPE`（省略可、デフォルト：`read write`）

`env/dev.json.example` をコピーして `env/dev.json` を作成。

## 編集時の注意

Hook（`.claude/settings.local.json`）により、ファイル編集後に自動で lint が実行される。
警告が出たら修正し、警告ゼロになるまで繰り返すこと。
