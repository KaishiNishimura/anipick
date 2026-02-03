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
* UIイベント（SnackBar / Navigation 等）：**Stateに混ぜず、UI側で `ref.listen` による副作用で処理**
* エラー設計：**domain は Failure、presentation は UiError**

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

### Provider（DI）配置ルール（決定）

* feature内の依存関係（Repository実装 / DataSource / UseCase / Controller Provider）は、原則として **`features/<feature>/di/` 配下に集約**する
* Controller本体は `presentation/controllers/` に置き、**DI配線（Provider定義）とは分離**する
* `core` の基盤Provider（HTTPクライアント、Storage等）は `core/` に置く
* Providerは **feature外へ漏らさない**（`core` を除く）

### 命名ルール

* feature名：`snake_case` 推奨（例：`today_recommendations`, `anime_detail`）
* UseCase：**動詞 + 目的語 + `UseCase`**（例：`GetTodayRecommendationsUseCase`, `ToggleShelfUseCase`）
* Controller Provider：`xxxControllerProvider`
* State：`XxxUiState`
* Repository interface：`XxxRepository`
* Repository 実装：`XxxRepositoryImpl`
* DataSource：`XxxRemoteDataSource`, `XxxLocalDataSource`

---

## Riverpod 設計（決定）

### Controller の使い分け

#### 画面の状態（非同期あり）

* **`AutoDisposeAsyncNotifier<XxxUiState>`**
* 初期ロードは `build()` に書く（初回に自動で走る）

#### 軽量ローカル状態（同期のみ）

* **`AutoDisposeNotifier<XxxUiState>`**
* タブ選択、フィルタ、入力中の値など

### AutoDispose 方針

* **基本は autoDispose**
* “状態を保持したい” は Controller で頑張らず、**Repository側でキャッシュ**する
  （画面寿命に状態保持を依存させない）

---

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

---

## UIイベント（副作用）の扱い（決定）

### 方針

* SnackBar、Dialog、画面遷移などの“一回だけやりたいこと”は **Stateに混ぜない**
* UI側で `ref.listen` し、差分を検知して副作用を実行する

### 理由

* Stateに混ぜると、再描画・再購読で **二度発火**しやすい
* 「状態」と「副作用」を分離すると事故が激減する

---

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
* Providerは **feature外へ漏らさない**（coreを除く）

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
