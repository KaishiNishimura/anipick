# Architecture Example: 認証（auth feature）

このファイルは `docs/architecture.md` の方針を、`features/auth` の実装に当てはめた **実例（最小コンテキスト）** です。

---

## 目的（この例で分かること）

- **presentation → domain ← data** の依存方向を、実コードのファイルパスで確認できる
- Riverpod（Generator含む）で **DI配線 → Controller → UI** をどう繋ぐかが分かる
- 「横断状態（セッション）」を **core** に置くときの使い方が分かる

---

## ファイル対応表（auth）

### Domain（ルール）

- **Entity**
  - `lib/features/auth/domain/entities/access_token.dart`
- **Repository interface**
  - `lib/features/auth/domain/repositories/auth_repository.dart`
- **UseCase**
  - `lib/features/auth/domain/usecases/get_saved_access_token.dart`
  - `lib/features/auth/domain/usecases/sign_in.dart`
  - `lib/features/auth/domain/usecases/sign_out.dart`

### Data（外部I/O）

- **RemoteDataSource（OAuth）**
  - `lib/features/auth/data/datasources/remote/auth_remote_datasource.dart`
- **LocalDataSource（SecureStorage）**
  - `lib/features/auth/data/datasources/local/auth_local_datasource.dart`
- **Repository implementation**
  - `lib/features/auth/data/repositories/auth_repository_impl.dart`

### Presentation（UI）

- **UI State**
  - `lib/features/auth/presentation/states/auth_ui_state.dart`
- **Controller（画面or機能の状態管理）**
  - `lib/features/auth/presentation/controllers/auth_controller.dart`
- **Page**
  - `lib/features/auth/presentation/pages/login_page.dart`

### 横断状態（認証セッション）

- **AuthSessionController（coreに置く横断状態）**
  - `lib/core/auth/auth_session_controller.dart`

---

## 依存方向の実例

- presentation（`auth_controller.dart`, `login_page.dart`）は domain（UseCase）を呼ぶ
- data（`auth_repository_impl.dart`）は domain（`AuthRepository`）を実装する
- domain は presentation/data を import しない

---

## DI（providers.dart）で「積み上げる」実例

入口：`lib/features/auth/di/providers.dart`

- `authRemoteDataSourceProvider`
  - 依存：`core/network/http_client_provider.dart`
- `authLocalDataSourceProvider`
  - 依存：`core/persistence/secure_storage_provider.dart`
- `authRepositoryProvider`
  - 依存：Remote + Local
- `signInProvider` / `signOutProvider` / `getSavedAccessTokenProvider`
  - 依存：Repository

このように **DataSource → Repository → UseCase** の順に provider を組み立てる。

---

## 横断状態（セッション）の扱い：AuthSessionController

ファイル：`lib/core/auth/auth_session_controller.dart`

### 役割

- アプリ全体で参照される **ログイン状態**（`accessToken` の有無）を保持する
- 初期化時に `getSavedAccessTokenProvider` を呼んで、保存済みトークンを復元する

### UIからの利用（正）

- **参照**：`ref.watch(authSessionControllerProvider)`
- **操作**：`ref.read(authSessionControllerProvider.notifier).signIn()` / `.signOut()`

> 「複数画面で共有される状態」は、feature配下のPage専用Controllerではなく、`core` の横断状態として扱う。

---

## 画面（LoginPage）から見た処理の流れ（最小）

### サインイン

1. UI（`login_page.dart`）でボタン押下
2. `AuthSessionController.signIn()` を呼ぶ
3. Controller が `state = AsyncLoading()` にしてローディング開始
4. `SignInUseCase` → `AuthRepositoryImpl.signIn()` → Remote(OAuth) + Local(永続化)
5. 成功：`state = AsyncData(AuthSessionState(accessToken: token))`
6. 失敗：`UiError` を返し、UI側で `AdaptiveSnackBar.show` 等を実行

---

## エラーの分離（Failure → UiError）

- domain/data：`Failure`（例：`NetworkFailure`, `UnauthorizedFailure`, `UnexpectedFailure`）
  - 定義：`lib/core/error/failure.dart`
- presentation：`UiError`
  - 定義：`lib/core/error/ui_error.dart`

実例：

- `AuthSessionController._mapFailureToUiError()`
- `AuthController._mapFailureToUiError()`

---

## この例をコピペして新機能を作るときのチェックリスト

- **[Domain]** `entities/`, `repositories/`, `usecases/` を先に作る
- **[Data]** `datasources/` と `repositories/*_impl.dart` を作る（domain interface を実装）
- **[DI]** `features/<feature>/di/providers.dart` に DataSource→Repo→UseCase→Controller の順で provider を積む
- **[Presentation]** `UiState` と `Controller` を作り、UIは `ref.watch` / `ref.listen` でつなぐ
- **[横断状態]** 複数画面共有なら `core/` に AsyncNotifier を置く
