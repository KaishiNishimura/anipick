import 'package:anipick/provider/home_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_season_works.g.dart';

/// シーズン作品一覧を取得するユースケースを定義
final class RefreshSeasonWorksUseCase {
  /// ユースケースを作成
  const RefreshSeasonWorksUseCase(this.ref);

  /// リポジトリを保持
  final Ref ref;

  /// シーズン作品一覧を取得
  void call() {
    final _ = ref.refresh(seasonWorksControllerProvider(0));
    final _ = ref.refresh(seasonWorksControllerProvider(1));
    final _ = ref.refresh(seasonWorksControllerProvider(2));
    final _ = ref.refresh(seasonWorksControllerProvider(3));
  }
}

/// シーズン作品一覧取得ユースケースを提供
@riverpod
RefreshSeasonWorksUseCase refreshSeasonWorksUseCase(Ref ref) {
  return RefreshSeasonWorksUseCase(ref);
}
