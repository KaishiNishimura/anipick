import 'package:anipick/application/usecases/get_saved_access_token.dart';
import 'package:anipick/application/usecases/sign_in.dart';
import 'package:anipick/application/usecases/sign_out.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/domain/entities/access_token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// 横断状態として扱う認証セッションの状態
final class AuthState {
  /// 認証セッションの状態を作成
  const AuthState({required this.accessToken});

  /// サインイン済みの場合に保持するアクセストークン
  final AccessToken? accessToken;

  /// サインイン済みかどうかを判定
  bool get isSignedIn => accessToken != null;
}

/// 認証セッション（横断状態）を管理する Controller
@riverpod
final class AuthController extends _$AuthController {
  @override
  /// 認証セッションの初期状態を取得
  Future<AuthState> build() async {
    final usecase = ref.read(getSavedAccessTokenProvider);
    final token = await usecase();
    return AuthState(accessToken: token);
  }

  /// サインインを実行
  Future<UiError?> signIn() async {
    final usecase = ref.read(signInProvider);

    state = const AsyncLoading<AuthState>();

    final (token, failure) = await usecase();
    if (failure != null) {
      state = const AsyncData<AuthState>(
        AuthState(accessToken: null),
      );
      return _mapFailureToUiError(failure);
    }

    state = AsyncData(AuthState(accessToken: token));
    return null;
  }

  /// サインアウトを実行
  Future<void> signOut() async {
    final usecase = ref.read(signOutProvider);
    await usecase();
    state = const AsyncData<AuthState>(
      AuthState(accessToken: null),
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
