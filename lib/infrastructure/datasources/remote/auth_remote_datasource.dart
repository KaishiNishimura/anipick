import 'dart:convert';

import 'package:anipick/core/env/annict_env.dart';
import 'package:anipick/core/network/http_client_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_datasource.g.dart';

/// OAuth 認証を実行するリモートデータソースを定義
final class AuthRemoteDataSource {
  /// データソースを作成
  const AuthRemoteDataSource(this._httpClient);

  /// HTTP クライアントを保持
  final http.Client _httpClient;

  /// 認可コードを取得
  Future<String> requestAuthorizationCode() async {
    final state = _generateState();

    final authorizeUri = Uri.parse(AnnictEnv.authorizeEndpoint).replace(
      queryParameters: <String, String>{
        'client_id': AnnictEnv.clientId,
        'response_type': 'code',
        'redirect_uri': AnnictEnv.redirectUri,
        'scope': AnnictEnv.scope,
        'state': state,
      },
    );

    final callbackScheme = Uri.parse(AnnictEnv.redirectUri).scheme;

    final result = await FlutterWebAuth2.authenticate(
      url: authorizeUri.toString(),
      callbackUrlScheme: callbackScheme,
    );

    final resultUri = Uri.parse(result);

    final returnedState = resultUri.queryParameters['state'];
    if (returnedState != null && returnedState != state) {
      throw StateError('Invalid OAuth state');
    }

    final code = resultUri.queryParameters['code'];
    if (code == null || code.isEmpty) {
      throw StateError('Authorization code not found');
    }

    return code;
  }

  /// 認可コードをアクセストークンへ交換
  Future<String> exchangeAccessToken({required String code}) async {
    final uri = Uri.parse(AnnictEnv.tokenEndpoint);

    final response = await _httpClient.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'client_id': AnnictEnv.clientId,
        'client_secret': AnnictEnv.clientSecret,
        'grant_type': 'authorization_code',
        'redirect_uri': AnnictEnv.redirectUri,
        'code': code,
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(response.statusCode);
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final accessToken = json['access_token'] as String?;
    if (accessToken == null || accessToken.isEmpty) {
      throw StateError('access_token not found');
    }

    return accessToken;
  }

  String _generateState() {
    final bytes = utf8.encode(DateTime.now().microsecondsSinceEpoch.toString());
    return sha256.convert(bytes).toString();
  }
}

/// HTTP エラーを表す例外
final class HttpException implements Exception {
  /// 例外を作成
  const HttpException(this.statusCode);

  /// HTTP ステータスコードを保持
  final int statusCode;
}

/// 認証用リモートデータソースを提供
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final client = ref.watch(httpClientProvider);
  return AuthRemoteDataSource(client);
}
