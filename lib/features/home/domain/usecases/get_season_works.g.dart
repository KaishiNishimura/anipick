// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_season_works.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// シーズン作品一覧取得ユースケースを提供

@ProviderFor(getSeasonWorks)
final getSeasonWorksProvider = GetSeasonWorksProvider._();

/// シーズン作品一覧取得ユースケースを提供

final class GetSeasonWorksProvider
    extends
        $FunctionalProvider<
          GetSeasonWorksUseCase,
          GetSeasonWorksUseCase,
          GetSeasonWorksUseCase
        >
    with $Provider<GetSeasonWorksUseCase> {
  /// シーズン作品一覧取得ユースケースを提供
  GetSeasonWorksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSeasonWorksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSeasonWorksHash();

  @$internal
  @override
  $ProviderElement<GetSeasonWorksUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetSeasonWorksUseCase create(Ref ref) {
    return getSeasonWorks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetSeasonWorksUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetSeasonWorksUseCase>(value),
    );
  }
}

String _$getSeasonWorksHash() => r'54d8fa359c7b3154b249e2854a3ab9a66e904cfd';
