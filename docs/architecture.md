# Flutter アーキテクチャ方針（Clean Architecture寄り + Riverpod）

## 目的

* 画面・機能が増えても **コードの置き場がブレない**
* UI / ビジネスロジック / 外部I/O の責務を分離して **変更に強くする**
* 非同期（ロード/成功/失敗）を **型で扱い、UIの事故を減らす**
* テストしやすい（特に domain のユースケース）

実例（認証機能を題材にした実装例）：

* `docs/architecture_example.md`

---

## 採用スタック

* 状態管理 / DI：**Riverpod**
* Provider定義：**Riverpod Generator（`riverpod_annotation` + `riverpod_generator`）**
* 状態管理：**`@riverpod` で生成される Provider / Notifier を利用する**
* 層構造：**UI（views） / domain / data**
* 依存方向：**UI →（Controller/UseCase/Repository）→ data**（現状の実コードに合わせる）
* UI基盤：**adaptive_platform_ui**（iOS/Androidでプラットフォームに応じた見た目を自動選択）
* UIイベント（SnackBar / Navigation 等）：**Stateに混ぜず、UI側で副作用で処理**
* エラー設計：**domain は Failure、presentation は UiError**

---

## 画面・機能の基本方針（運用ルール）

* 状態は **Controller（Notifier）で管理**する
* Controller は **機能（feature）単位**または **ページ単位**で作成してよい（現状：`HomeController` など）

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
* どうしても分岐が必要な場合のみ UI層で分岐する
* domain/data 層には platform 分岐を持ち込まない

---

## 全体の考え方

### 1) 層の責務

* **UI（views）**：Widget（画面/部品）
* **provider（Controller）**：状態管理・画面操作（`@riverpod` で生成される Notifier）
* **domain**：アプリのルール（Entity, UseCase, Repository interface）
* **data**：外部I/O（API, DB, DTO, Mapper, Repository実装）

### 2) 依存方向ルール

* UI（views）は provider（Controller）を呼ぶ（`ref.watch` / `ref.read`）
* provider（Controller）は domain の UseCase を呼ぶ
* data は domain の Repository interface を実装する
* Provider（DI配線）の都合で、domain 側の `@riverpod` provider が data 側の provider を import することがある（現状の実装に合わせる）

> “内側（domain）が最強で、外側（UI/provider/data）が従う”
> これが崩れると、拡張時に破滅します。

---

## ディレクトリ構成

```text
lib/
  core/
    env/
    error/
    network/
    theme/
  features/
    <feature>/
      provider/
      domain/
        entities/
        usecases/
        repositories/
      data/
        datasources/
          remote/
          local/
        dtos/
        repositories/
  views/
    pages/
      <page>/
    ui/
      <ui>/
```

### UI（Page/Widget）配置ルール

* **Page**：**Routeのエントリ**（画面単位）
* `views/pages/<page>/widgets/` は **page専用部品**とし、**同ページ以外からの import を禁止**する
* 同じUIを **2回使ったら昇格**させる
  * 複数ページから使う → `views/ui/` 配下で共通化
  * アプリ全体で使う → `core/ui/widgets/`
* “たぶん使うかも” を理由に昇格しない
* `core/ui/widgets/`（アプリ共通UI）には **Provider/State を生やさない**（原則pureにして引数で受け取る）

### Provider（DI）配置ルール

* feature内の依存関係（Repository実装 / DataSource / UseCase / Controller Provider）は、原則として **`features/<feature>/` 配下に閉じる**
* Provider定義は `@riverpod` を用いて **各実装ファイルで提供**する（例：DataSource/Repository/UseCase/Controller のファイル内）
* Controller は `features/<feature>/provider/` に置く
* `core` の基盤Provider（HTTPクライアント、Storage等）は `core/` に置く
* Controller/Provider は **複数画面から参照される前提**のため、必要に応じて feature を跨いで参照してよい

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

## Riverpod 設計

### Controller の使い分け

#### 実装方針

* Controller は `@riverpod` を付けた class（`extends _$XxxController`）として実装する
* `build()` の戻り値に応じて Generator が Notifier の型を決める
  * `Future<T>` を返す場合は非同期（`AsyncValue<T>`）として扱う
  * `T` を返す場合は同期として扱う
* 状態は **複数画面から共有される前提**で設計する

### AutoDispose 方針

* `autoDispose` を使うかどうかは **Providerごとに判断**する

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
* UI側で副作用を実行する
  * 現状の実装：Controller メソッドが `UiError?` を返し、UIで受けて `AdaptiveSnackBar.show` する

## Error 設計（決定）

### domain：Failure

* 例：`NetworkFailure`, `UnauthorizedFailure`, `NotFoundFailure`, `ValidationFailure`
* 技術都合（例外メッセージやHTTPコード）を直接UIに漏らさない

### presentation：UiError

* ユーザーに見せる文言、再試行可否、アクション（ログイン誘導等）を持つ
* `Failure -> UiError` 変換は provider（Controller）で行う

---

## 依存注入（DI）方針

* Riverpod を DI コンテナとして使う
* `core` で基盤（Dio/DB/env）を提供し、feature内で積み上げる
* Controller/Provider は **複数画面から参照される前提**のため、必要に応じて feature を跨いで参照してよい

---

## Riverpod Generator 運用

* Provider定義は `@riverpod` を用いて記述し、`*.g.dart` は自動生成する
* 生成コードは手で編集しない

### 生成手順

* `dart run build_runner build -d`

### ファイル構成

* Provider定義ファイルには以下を含める
  * `import 'package:riverpod_annotation/riverpod_annotation.dart';`
  * `part '<file_name>.g.dart';`
