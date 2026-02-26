import 'package:anipick/application/repositories/work_repository.dart';
import 'package:anipick/core/error/failure.dart';
import 'package:anipick/core/error/ui_error.dart';
import 'package:anipick/domain/entities/season_works.dart';
import 'package:anipick/domain/services/season_works_service.dart';
import 'package:anipick/infrastructure/repositories/work_repository_impl.dart';
import 'package:anipick/provider/auth_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_season_works.g.dart';

/// シーズン作品一覧を取得するユースケースを定義
final class GetSeasonWorksUseCase {
  /// ユースケースを作成
  const GetSeasonWorksUseCase(this._auth, this._repository, this._service);

  /// リポジトリを保持
  final AuthState _auth;
  final WorkRepository _repository;
  final SeasonWorksService _service;

  /// シーズン作品一覧を取得
  Future<SeasonWorks> call(int index) async {
    final token = _auth.accessToken?.value;
    if (token == null || token.isEmpty) {
      throw _mapFailureToUiError(const UnauthorizedFailure());
    }

    final seasonName = _service.getSeasonName(index);
    final (works, failure) = await _repository.getWorksBySeason(
      season: seasonName,
      accessToken: token,
    );

    if (failure != null || works == null) {
      throw _mapFailureToUiError(failure ?? const UnexpectedFailure());
    }
    final seasonText = works.isEmpty ? seasonName : works.first.seasonNameText;

    return SeasonWorks(
      season: seasonName,
      seasonText: seasonText,
      works: works,
    );
  }

  UiError _mapFailureToUiError(Failure failure) {
    return switch (failure) {
      NetworkFailure() => const UiError(message: '通信に失敗しました'),
      UnauthorizedFailure() => const UiError(message: '認証に失敗しました'),
      UnexpectedFailure() => const UiError(message: '予期しないエラーが発生しました'),
    };
  }
}

/// シーズン作品一覧取得ユースケースを提供
@riverpod
Future<GetSeasonWorksUseCase> getSeasonWorksUseCase(Ref ref) async {
  final auth = await ref.read(authControllerProvider.future);
  final repo = ref.read(workRepositoryProvider);
  final service = ref.read(seasonWorksServiceProvider);
  return GetSeasonWorksUseCase(auth, repo, service);
}
