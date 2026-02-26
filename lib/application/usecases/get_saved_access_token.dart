import 'package:anipick/application/repositories/auth_repository.dart';
import 'package:anipick/domain/entities/access_token.dart';
import 'package:anipick/infrastructure/repositories/auth_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_saved_access_token.g.dart';

/// 保存済みアクセストークンを取得するユースケースを定義
final class GetSavedAccessTokenUseCase {
  /// ユースケースを作成
  const GetSavedAccessTokenUseCase(this._repository);

  /// 認証リポジトリを保持
  final AuthRepository _repository;

  /// 保存済みアクセストークンを取得
  Future<AccessToken?> call() => _repository.getSavedAccessToken();
}

/// 保存済みアクセストークン取得ユースケースを提供
@riverpod
GetSavedAccessTokenUseCase getSavedAccessToken(Ref ref) {
  final repo = ref.watch(authRepositoryProvider);
  return GetSavedAccessTokenUseCase(repo);
}
