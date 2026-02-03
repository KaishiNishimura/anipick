import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/features/auth/di/providers.dart';
import 'package:anipick/features/auth/domain/entities/access_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 認証セッション（横断状態）を管理する Controller を提供
final authSessionControllerProvider =
    AsyncNotifierProvider<AuthSessionController, AuthSessionState>(
      AuthSessionController.new,
    );

/// 横断状態として扱う認証セッションの状態
final class AuthSessionState {
  /// 認証セッションの状態を作成
  const AuthSessionState({required this.accessToken});

  /// サインイン済みの場合に保持するアクセストークン
  final AccessToken? accessToken;

  /// サインイン済みかどうかを判定
  bool get isSignedIn => accessToken != null;
}

/// 認証セッション（横断状態）を管理する Controller
final class AuthSessionController extends AsyncNotifier<AuthSessionState> {
  @override
  /// 認証セッションの初期状態を取得
  Future<AuthSessionState> build() async {
    final usecase = ref.read(getSavedAccessTokenProvider);
    final token = await usecase();
    return AuthSessionState(accessToken: token);
  }

  /// サインインを実行
  Future<UiError?> signIn() async {
    final usecase = ref.read(signInProvider);

    state = const AsyncLoading<AuthSessionState>();

    final (token, failure) = await usecase();
    if (failure != null) {
      state = const AsyncData<AuthSessionState>(
        AuthSessionState(accessToken: null),
      );
      return _mapFailureToUiError(failure);
    }

    state = AsyncData(AuthSessionState(accessToken: token));
    return null;
  }

  /// サインアウトを実行
  Future<void> signOut() async {
    final usecase = ref.read(signOutProvider);
    await usecase();
    state = const AsyncData<AuthSessionState>(
      AuthSessionState(accessToken: null),
    );
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
