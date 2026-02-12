// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Discover画面の状態を管理

@ProviderFor(DiscoverController)
final discoverControllerProvider = DiscoverControllerProvider._();

/// Discover画面の状態を管理
final class DiscoverControllerProvider
    extends $AsyncNotifierProvider<DiscoverController, DiscoverUiState> {
  /// Discover画面の状態を管理
  DiscoverControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverControllerHash();

  @$internal
  @override
  DiscoverController create() => DiscoverController();
}

String _$discoverControllerHash() =>
    r'edd737a8792da585c0b8aa0758da75b6b197d0e7';

/// Discover画面の状態を管理

abstract class _$DiscoverController extends $AsyncNotifier<DiscoverUiState> {
  FutureOr<DiscoverUiState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DiscoverUiState>, DiscoverUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DiscoverUiState>, DiscoverUiState>,
              AsyncValue<DiscoverUiState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
