// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Home画面の状態を管理

@ProviderFor(HomeController)
final homeControllerProvider = HomeControllerFamily._();

/// Home画面の状態を管理
final class HomeControllerProvider
    extends $AsyncNotifierProvider<HomeController, SeasonWorks> {
  /// Home画面の状態を管理
  HomeControllerProvider._({
    required HomeControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'homeControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$homeControllerHash();

  @override
  String toString() {
    return r'homeControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HomeController create() => HomeController();

  @override
  bool operator ==(Object other) {
    return other is HomeControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeControllerHash() => r'ace05f3fd380e4ac4c29191641487604f8cc358e';

/// Home画面の状態を管理

final class HomeControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          HomeController,
          AsyncValue<SeasonWorks>,
          SeasonWorks,
          FutureOr<SeasonWorks>,
          int
        > {
  HomeControllerFamily._()
    : super(
        retry: null,
        name: r'homeControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Home画面の状態を管理

  HomeControllerProvider call(int back) =>
      HomeControllerProvider._(argument: back, from: this);

  @override
  String toString() => r'homeControllerProvider';
}

/// Home画面の状態を管理

abstract class _$HomeController extends $AsyncNotifier<SeasonWorks> {
  late final _$args = ref.$arg as int;
  int get back => _$args;

  FutureOr<SeasonWorks> build(int back);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SeasonWorks>, SeasonWorks>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SeasonWorks>, SeasonWorks>,
              AsyncValue<SeasonWorks>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
