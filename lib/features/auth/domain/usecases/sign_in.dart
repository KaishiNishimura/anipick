import 'package:anipick/core/error/failure.dart';
import 'package:anipick/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:anipick/features/auth/domain/entities/access_token.dart';
import 'package:anipick/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in.g.dart';

/// サインインしてアクセストークンを取得するユースケースを定義
final class SignInUseCase {
  /// ユースケースを作成
  const SignInUseCase(this._repository);

  /// 認証リポジトリを保持
  final AuthRepository _repository;

  /// サインインを実行
  Future<(AccessToken?, Failure?)> call() => _repository.signIn();
}

/// サインインユースケースを提供
@riverpod
SignInUseCase signIn(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  return SignInUseCase(repo);
}
