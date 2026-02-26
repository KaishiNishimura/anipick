// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_works_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 認証リポジトリを提供

@ProviderFor(seasonWorksService)
final seasonWorksServiceProvider = SeasonWorksServiceProvider._();

/// 認証リポジトリを提供

final class SeasonWorksServiceProvider
    extends
        $FunctionalProvider<
          SeasonWorksService,
          SeasonWorksService,
          SeasonWorksService
        >
    with $Provider<SeasonWorksService> {
  /// 認証リポジトリを提供
  SeasonWorksServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seasonWorksServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seasonWorksServiceHash();

  @$internal
  @override
  $ProviderElement<SeasonWorksService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SeasonWorksService create(Ref ref) {
    return seasonWorksService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SeasonWorksService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SeasonWorksService>(value),
    );
  }
}

String _$seasonWorksServiceHash() =>
    r'0a57fa99c8a6c8b42aa55a3d6b433f3f0664380a';
