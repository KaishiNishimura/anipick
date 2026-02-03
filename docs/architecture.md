# Flutter アーキテクチャ方針（Clean Architecture寄り + Riverpod）

## 目的

* 画面・機能が増えても **コードの置き場がブレない**
* UI / ビジネスロジック / 外部I/O の責務を分離して **変更に強くする**
* 非同期（ロード/成功/失敗）を **型で扱い、UIの事故を減らす**
* テストしやすい（特に domain のユースケース）

---

## 採用スタック（決定事項）

* 状態管理 / DI：**Riverpod**
* Provider定義：**Riverpod Generator（`riverpod_annotation` + `riverpod_generator`）**
* ViewModel相当：**`AutoDisposeAsyncNotifier` / `AutoDisposeNotifier`**
* 層構造：**presentation / domain / data**
* 依存方向：**presentation → domain ← data**（domain は外側を知らない）
* UI基盤：**adaptive_platform_ui**（iOS/Androidでプラットフォームに応じた見た目を自動選択）
* UIイベント（SnackBar / Navigation 等）：**Stateに混ぜず、UI側で `ref.listen` による副作用で処理**
* エラー設計：**domain は Failure、presentation は UiError**

---

## 画面・機能の基本方針（運用ルール）

* 基本は **feature中心（画面ごとのAPI取得が多い）** とし、画面ごとに UseCase を呼び出してUIを組み立てる
* 画面の状態は原則 **1 Page = 1 Controller**（その画面の入力・ロード状態・表示データを集約）
* ただし **認証（セッション）など複数画面で共有される状態は「横断状態」**として扱い、特定のPageに閉じない

---

## UI（Adaptive UI）設計

### ルート構成

* アプリのルートは **`AdaptiveApp`** を使用する（`MaterialApp` / `CupertinoApp` を直接使わない）
* `themeMode` / Materialテーマ / Cupertinoテーマは **`core/theme/AppTheme`** で一元管理する
* 色/配色/テーマ定義は **`lib/core/theme`**（`AppTheme` / `AppColorScheme` / `AppColors`）を参照する

### 画面の基本ウィジェット

* 画面の骨格は原則 **`AdaptiveScaffold`** を使用する
* AppBar は原則 **`AdaptiveAppBar`** を使用し、アクションは **`AdaptiveAppBarAction`** を使用する
* ボタンは原則 **`AdaptiveButton`** を使用する
* トースト/通知は原則 **`AdaptiveSnackBar.show`** を使用する

### Platform差分を入れる場所

* 基本は `adaptive_platform_ui` の自動判定に任せる
* どうしても分岐が必要な場合のみ `PlatformInfo` を用いて UI層で分岐する
* domain/data 層には platform 分岐を持ち込まない

---

## 全体の考え方（最重要）

### 1) 層の責務

* **presentation**：Widget / 画面状態（UiState）/ 画面操作（Controller）
* **domain**：アプリのルール（Entity, UseCase, Repository interface）
* **data**：外部I/O（API, DB, DTO, Mapper, Repository実装）

### 2) 依存方向ルール

* presentation は domain を呼ぶ（UseCase）
* data は domain の Repository interface を実装する
* domain は data/presentation を **一切 import しない**

> “内側（domain）が最強で、外側（presentation/data）が従う”
> これが崩れると、拡張時に破滅します。

---

## ディレクトリ構成（決定）

```text
lib/
  core/
    env/
    error/
    network/
    persistence/
    ui/
      widgets/
    utils/
  features/
    <feature>/
      di/
        providers.dart
      presentation/
        pages/
        widgets/
        controllers/
        states/
      domain/
        entities/
        usecases/
        repositories/
      data/
        datasources/
          remote/
          local/
        dtos/
        mappers/
        repositories/
```

### UI（Page/Widget）配置ルール（決定）

* **Page**：**Routeのエントリ**（画面単位）
* `features/<feature>/presentation/pages/<page>/widgets/` は **page専用部品**とし、**同ページ以外からの import を禁止**する
* 同じUIを **2回使ったら昇格**させる
  * feature内で複数ページから使う → `features/<feature>/presentation/widgets/`
  * アプリ全体で使う → `core/ui/widgets/`
* “たぶん使うかも” を理由に昇格しない
* `core/ui/widgets/`（アプリ共通UI）には **Provider/State を生やさない**（原則pureにして引数で受け取る）

### Provider（DI）配置ルール（決定）

* feature内の依存関係（Repository実装 / DataSource / UseCase / Controller Provider）は、原則として **`features/<feature>/di/` 配下に集約**する
* Controller本体は `presentation/controllers/` に置き、**DI配線（Provider定義）とは分離**する
* `core` の基盤Provider（HTTPクライアント、Storage等）は `core/` に置く
* Providerは **feature外へ漏らさない**（`core` / `app` 相当の横断状態を除く）

#### 横断状態（認証/セッション等）の例外ルール（決定）

* 認証状態のように **複数画面で参照・更新される状態**は、単一featureの画面に閉じず「横断状態」として扱う
* 横断状態のProviderは **`core/`（または `app/` 相当）**に配置してよい
* 横断状態を扱う feature（例：`features/auth`）は
  * UseCase / Repository / DataSource などの実装を持つ（featureとして完結）
  * 横断状態Providerから利用されることを前提にしてよい
* UI（page）は原則として **横断状態Providerを watch**し、画面遷移や表示分岐に利用する

### 命名ルール

* feature名：`snake_case` 推奨（例：`today_recommendations`, `anime_detail`）
* UseCase：**動詞 + 目的語 + `UseCase`**（例：`GetTodayRecommendationsUseCase`, `ToggleShelfUseCase`）
* Controller Provider：`xxxControllerProvider`
* State：`XxxUiState`
* Repository interface：`XxxRepository`
* Repository 実装：`XxxRepositoryImpl`
* DataSource：`XxxRemoteDataSource`, `XxxLocalDataSource`

### クラス宣言ルール

* 具体クラスは原則 **`final class`** とする
* `abstract` / `sealed` / `mixin` は `final class` にできないため例外

---

## Riverpod 設計（決定）

### Controller の使い分け

#### 画面の状態（非同期あり）

* **`AutoDisposeAsyncNotifier<XxxUiState>`**
* 初期ロードは `build()` に書く（初回に自動で走る）

#### 横断状態（認証/セッション等）

* 複数ページで共有する状態は「Page専用Controller」とは別に扱う
* Providerは **`core/`（または `app/`）**に置き、どのfeature/pageからも参照できる入口にする
* UIの都合で保持したい場合でも、原則として **画面寿命に依存しない設計**にする

#### 軽量ローカル状態（同期のみ）

* **`AutoDisposeNotifier<XxxUiState>`**
* タブ選択、フィルタ、入力中の値など

### AutoDispose 方針

* **基本は autoDispose**
* “状態を保持したい” は Controller で頑張らず、**Repository側でキャッシュ**する
  （画面寿命に状態保持を依存させない）

## State 設計（決定）

### UiState に含めるもの

* 表示用データ（UI都合に整形されたモデルでもOK）
* ローディング/エラー（AsyncValueと組み合わせて表現）
* UI操作に必要なフラグ（例：`isEditing`, `selectedTab` 等）

### UiState に含めないもの（禁止）

* `BuildContext`
* `Widget`
* `TextEditingController` や `FocusNode`（UI層に置く）
* `Dio` / DB / DataSource / Repository（Controller は UseCase だけを見る）

## UIイベント（副作用）の扱い（決定）

### 方針

* SnackBar、Dialog、画面遷移などの“一回だけやりたいこと”は **Stateに混ぜない**
* UI側で `ref.listen` し、差分を検知して副作用を実行する

## Error 設計（決定）

### domain：Failure

* 例：`NetworkFailure`, `UnauthorizedFailure`, `NotFoundFailure`, `ValidationFailure`
* 技術都合（例外メッセージやHTTPコード）を直接UIに漏らさない

### presentation：UiError

* ユーザーに見せる文言、再試行可否、アクション（ログイン誘導等）を持つ
* `Failure -> UiError` 変換は presentation（Controller）で行う

---

## 依存注入（DI）方針（決定）

* Riverpod を DI コンテナとして使う
* `core` で基盤（Dio/DB/env）を提供し、feature内で積み上げる
* Providerは **feature外へ漏らさない**（`core` / `app` 相当の横断状態を除く）

---

## Riverpod Generator 運用（決定）

* Provider定義は `@riverpod` を用いて記述し、`*.g.dart` は自動生成する
* 生成コードは手で編集しない

### 生成手順

* `dart run build_runner build -d`

### ファイル構成

* Provider定義ファイルには以下を含める
  * `import 'package:riverpod_annotation/riverpod_annotation.dart';`
  * `part '<file_name>.g.dart';`
