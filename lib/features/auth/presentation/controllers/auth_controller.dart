import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/core/network/http_client_provider.dart';
import 'package:anipick/core/persistence/secure_storage_provider.dart';
import 'package:anipick/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:anipick/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:anipick/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';
import 'package:anipick/features/auth/domain/usecases/get_saved_access_token.dart';
import 'package:anipick/features/auth/domain/usecases/sign_in.dart';
import 'package:anipick/features/auth/domain/usecases/sign_out.dart';
import 'package:anipick/features/auth/presentation/states/auth_ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 認証状態を管理するコントローラを提供
final AsyncNotifierProvider<AuthController, AuthUiState>
authControllerProvider =
    AsyncNotifierProvider.autoDispose<AuthController, AuthUiState>(
      AuthController.new,
    );

/// 認証状態を管理
class AuthController extends AsyncNotifier<AuthUiState> {
  @override
  /// 初期状態を構築
  Future<AuthUiState> build() async {
    final usecase = ref.read(getSavedAccessTokenProvider);
    final token = await usecase();
    return AuthUiState(accessToken: token);
  }

  /// サインインを実行
  Future<UiError?> signIn() async {
    final usecase = ref.read(signInProvider);

    state = const AsyncLoading<AuthUiState>();

    final (token, failure) = await usecase();
    if (failure != null) {
      state = const AsyncData<AuthUiState>(AuthUiState(accessToken: null));
      return _mapFailureToUiError(failure);
    }

    state = AsyncData(AuthUiState(accessToken: token));
    return null;
  }

  /// サインアウトを実行
  Future<void> signOut() async {
    final usecase = ref.read(signOutProvider);
    await usecase();
    state = const AsyncData<AuthUiState>(AuthUiState(accessToken: null));
  }

  UiError _mapFailureToUiError(Failure failure) {
    return switch (failure) {
      NetworkFailure() => const UiError(message: '通信に失敗しました'),
      UnauthorizedFailure() => const UiError(
        message: '認証に失敗しました',
      ),
      UnexpectedFailure() => const UiError(
        message: '予期しないエラーが発生しました',
      ),
    };
  }
}

/// 保存済みアクセストークン取得ユースケースを提供
final getSavedAccessTokenProvider = Provider<GetSavedAccessToken>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return GetSavedAccessToken(repo);
});

/// サインインユースケースを提供
final signInProvider = Provider<SignIn>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return SignIn(repo);
});

/// サインアウトユースケースを提供
final signOutProvider = Provider<SignOut>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return SignOut(repo);
});

/// 認証リポジトリを提供
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.read(authRemoteDataSourceProvider);
  final local = ref.read(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remote: remote, local: local);
});

/// 認証リモートデータソースを提供
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final client = ref.read(httpClientProvider);
  return AuthRemoteDataSource(client);
});

/// 認証ローカルデータソースを提供
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final storage = ref.read(secureStorageProvider);
  return AuthLocalDataSource(storage);
});
