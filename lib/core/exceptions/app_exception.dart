import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_exception.freezed.dart';

/// アプリ全体で使用する例外
@freezed
sealed class AppException with _$AppException implements Exception {
  /// 通信失敗
  const factory AppException.network() = NetworkException;

  /// 認証失敗
  const factory AppException.unauthorized() = UnauthorizedException;

  /// 想定外の失敗
  const factory AppException.unexpected() = UnexpectedException;
}

/// AppException のユーザー向けメッセージ
extension AppExceptionMessage on AppException {
  /// 表示メッセージを取得
  String get message => switch (this) {
    NetworkException() => '通信に失敗しました',
    UnauthorizedException() => '認証に失敗しました',
    UnexpectedException() => '予期しないエラーが発生しました',
  };
}
