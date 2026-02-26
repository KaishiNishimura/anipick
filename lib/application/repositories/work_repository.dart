import 'package:anipick/core/error/failure.dart';
import 'package:anipick/domain/entities/work.dart';

/// 作品情報を取得するリポジトリを定義
abstract interface class WorkRepository {
  /// 指定シーズンの作品一覧を取得
  Future<(List<Work>?, Failure?)> getWorksBySeason({
    required String season,
    required String accessToken,
    int perPage = 50,
  });

  /// 作品IDから作品を取得
  Future<(Work?, Failure?)> getWorkById({
    required int workId,
    required String accessToken,
  });
}
