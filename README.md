# AniPick

iOS/Android 向けの Annict クライアント（Flutter）。

---

## 概要

- Annict の OAuth 認証でサインイン
- 状態管理/DI：Riverpod（Generator 利用）
- UI：`adaptive_platform_ui`（iOS/Android の見た目を自動選択）

---

## 画面収録

https://github.com/user-attachments/assets/2a18280b-ab78-4dcf-bd87-8a4e74570d71

https://github.com/user-attachments/assets/dd7d52a7-3d20-4537-b3bf-664d14876203

https://github.com/user-attachments/assets/6434f684-b756-4c55-8cba-f6f1a39ea436

---

## 注意事項（現状の制限）

- 実装済み画面は「ログイン画面」と「ホーム（Discover）画面」のみ
- 「見たい」や「視聴中」などのステータス登録、各作品の詳細表示は未対応
- 動作確認は iOS のみ
- 一部サムネイルが表示されない場合あり（API 側で URL が保存されていないケース）
- 画面全体のパフォーマンス最適化は未実施

---

## 必要要件

- FVM
- Flutter SDK（FVM 管理 / `.fvmrc`：`3.38.9`）
- iOS / Android のビルド環境
  - iOS：Xcode
  - Android：Android Studio

---

## セットアップ

### 1) 依存関係を取得

```bash
fvm install
fvm flutter pub get
```

### 2) Annict OAuth の環境変数（必須）

環境変数は `--dart-define-from-file` で読み込みます。

OAuth で使用するクライアントID/クライアントシークレット（アプリケーション作成・管理方法）は、以下に記載があります。

- [Annict OAuth applications](https://annict.com/oauth/applications)

1. `env/dev.json.example` をコピーして `env/dev.json` を作成
2. `env/dev.json` に値を設定

参照元：`lib/core/env/annict_env.dart`

- `ANNICT_CLIENT_ID`
- `ANNICT_CLIENT_SECRET`
- `ANNICT_REDIRECT_URI`（例：`anipick://oauth-callback`）
- `ANNICT_SCOPE`（省略可。デフォルト：`read write`）

---

## 実行

```bash
fvm flutter run --dart-define-from-file=env/dev.json
```

---

## コード生成（Riverpod / Freezed など）

```bash
fvm dart run build_runner build -d
```

---

## アーキテクチャ

設計方針は以下を参照してください。

- `docs/architecture.md`
- `docs/architecture_example.md`

エントリポイント：

- `lib/main.dart`
  - `authControllerProvider` の状態に応じて初期画面（`HomePage` / `LoginPage`）を切り替えます

---

## 認証（OAuth）の実装位置

- 横断状態（セッション）：`lib/features/auth/provider/auth_controller.dart`
- feature 実装：`lib/features/auth/`
  - Remote：`lib/features/auth/data/datasources/remote/auth_remote_datasource.dart`
  - Local：`lib/features/auth/data/datasources/local/auth_local_datasource.dart`
  - Repository：`lib/features/auth/data/repositories/auth_repository_impl.dart`
  - UseCase：`lib/features/auth/domain/usecases/*`

---

## よくあるトラブル

### OAuth が失敗する / 画面が戻ってこない

- `ANNICT_REDIRECT_URI` が Annict 側の設定と一致しているか確認してください
- iOS/Android の URL Scheme 設定が必要な場合があります（`redirect_uri` の scheme を使用）

### 生成ファイルが見つからない（`*.g.dart` など）

- `fvm dart run build_runner build -d` を実行してください
