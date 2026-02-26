import 'package:anipick/application/usecases/auth/get_saved_access_token.dart';
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
@Riverpod(keepAlive: true)
final class AuthController extends _$AuthController {
  @override
  /// 認証セッションの初期状態を取得
  Future<AuthState> build() async {
    final usecase = ref.read(getSavedAccessTokenProvider);
    final token = await usecase();
    return AuthState(accessToken: token);
  }

  /// AccessTokenを更新
  void updateAccessToken(AccessToken? token) {
    state = AsyncData<AuthState>(AuthState(accessToken: token));
  }
}
