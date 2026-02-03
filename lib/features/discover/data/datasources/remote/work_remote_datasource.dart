import 'dart:convert';

import 'package:http/http.dart' as http;

/// 作品情報を取得するリモートデータソースを定義
final class WorkRemoteDataSource {
  /// データソースを作成
  const WorkRemoteDataSource(this._httpClient);

  /// HTTPクライアントを保持
  final http.Client _httpClient;

  /// 指定シーズンの作品一覧を取得
  Future<Map<String, dynamic>> fetchWorksBySeason({
    required String season,
    required String accessToken,
    required int perPage,
  }) async {
    final uri = Uri.parse('https://api.annict.com/v1/works').replace(
      queryParameters: <String, String>{
        'filter_season': season,
        'fields': 'id,title,season_name,season_name_text,watchers_count,images',
        'per_page': perPage.toString(),
        'sort_watchers_count': 'desc',
      },
    );

    final response = await _httpClient.get(
      uri,
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(response.statusCode);
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// 作品IDリストから作品一覧を取得
  Future<Map<String, dynamic>> fetchWorksByIds({
    required List<int> workIds,
    required String accessToken,
  }) async {
    final uri = Uri.parse('https://api.annict.com/v1/works').replace(
      queryParameters: <String, String>{
        'filter_ids': workIds.join(','),
        'fields': 'id,title,season_name,season_name_text,watchers_count,images',
        'per_page': workIds.length.toString(),
      },
    );

    final response = await _httpClient.get(
      uri,
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(response.statusCode);
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}

/// HTTP エラーを表す例外
final class HttpException implements Exception {
  /// 例外を作成
  const HttpException(this.statusCode);

  /// HTTP ステータスコードを保持
  final int statusCode;
}
