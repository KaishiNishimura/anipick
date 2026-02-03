import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/features/auth/di/providers.dart';
import 'package:anipick/features/auth/presentation/states/auth_ui_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// 認証状態を管理
@riverpod
class AuthController extends _$AuthController {
  @override
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
