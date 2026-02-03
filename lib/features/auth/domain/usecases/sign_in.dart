import 'package:anipick/core/error/failure.dart';
import 'package:anipick/features/auth/domain/entities/access_token.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';

/// サインインしてアクセストークンを取得するユースケースを定義
final class SignInUseCase {
  /// ユースケースを作成
  const SignInUseCase(this._repository);

  /// 認証リポジトリを保持
  final AuthRepository _repository;

  /// サインインを実行
  Future<(AccessToken?, Failure?)> call() => _repository.signIn();
}
