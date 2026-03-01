// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_works_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// シーズン作品の状態を管理

@ProviderFor(SeasonWorksController)
final seasonWorksControllerProvider = SeasonWorksControllerFamily._();

/// シーズン作品の状態を管理
final class SeasonWorksControllerProvider
    extends $AsyncNotifierProvider<SeasonWorksController, SeasonWorks> {
  /// シーズン作品の状態を管理
  SeasonWorksControllerProvider._({
    required SeasonWorksControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'seasonWorksControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$seasonWorksControllerHash();

  @override
  String toString() {
    return r'seasonWorksControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SeasonWorksController create() => SeasonWorksController();

  @override
  bool operator ==(Object other) {
    return other is SeasonWorksControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$seasonWorksControllerHash() =>
    r'20752b0639c6ec7cfb3cbf64c4c80c50cd523dde';

/// シーズン作品の状態を管理

final class SeasonWorksControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SeasonWorksController,
          AsyncValue<SeasonWorks>,
          SeasonWorks,
          FutureOr<SeasonWorks>,
          int
        > {
  SeasonWorksControllerFamily._()
    : super(
        retry: null,
        name: r'seasonWorksControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// シーズン作品の状態を管理

  SeasonWorksControllerProvider call(int back) =>
      SeasonWorksControllerProvider._(argument: back, from: this);

  @override
  String toString() => r'seasonWorksControllerProvider';
}

/// シーズン作品の状態を管理

abstract class _$SeasonWorksController extends $AsyncNotifier<SeasonWorks> {
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
