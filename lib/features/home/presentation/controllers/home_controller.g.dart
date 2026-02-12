// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Home画面の状態を管理

@ProviderFor(HomeController)
final homeControllerProvider = HomeControllerProvider._();

/// Home画面の状態を管理
final class HomeControllerProvider
    extends $AsyncNotifierProvider<HomeController, HomeUiState> {
  /// Home画面の状態を管理
  HomeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeControllerHash();

  @$internal
  @override
  HomeController create() => HomeController();
}

String _$homeControllerHash() => r'd7a9f6c3239f1bfbd2bf5e1a08fc5ad904e3bf53';

/// Home画面の状態を管理

abstract class _$HomeController extends $AsyncNotifier<HomeUiState> {
  FutureOr<HomeUiState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HomeUiState>, HomeUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeUiState>, HomeUiState>,
              AsyncValue<HomeUiState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
