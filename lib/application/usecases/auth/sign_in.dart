import 'package:anipick/application/repositories/auth_repository.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/infrastructure/repositories/auth_repository_impl.dart';
import 'package:anipick/provider/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in.g.dart';

/// サインインしてアクセストークンを取得するユースケースを定義
final class SignInUseCase {
  /// ユースケースを作成
  const SignInUseCase(this._controller, this._repository);

  final AuthController _controller;
  final AuthRepository _repository;

  /// サインインを実行
  Future<UiError?> call() async {
    final (token, failure) = await _repository.signIn();
    _controller.updateAccessToken(token);
    if (failure != null) {
      return _mapFailureToUiError(failure);
    }
    return null;
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

/// サインインユースケースを提供
@riverpod
SignInUseCase signInUseCase(Ref ref) {
  final controller = ref.read(authControllerProvider.notifier);
  final repo = ref.read(authRepositoryProvider);
  return SignInUseCase(controller, repo);
}
