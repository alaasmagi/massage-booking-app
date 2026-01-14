// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoadingState)
const loadingStateProvider = LoadingStateProvider._();

final class LoadingStateProvider extends $NotifierProvider<LoadingState, bool> {
  const LoadingStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loadingStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loadingStateHash();

  @$internal
  @override
  LoadingState create() => LoadingState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$loadingStateHash() => r'8d1092b4bb336646f9df4fe732e1f20bf845d477';

abstract class _$LoadingState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(isLoadingNotifier)
const isLoadingProvider = IsLoadingNotifierProvider._();

final class IsLoadingNotifierProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsLoadingNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoadingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoadingNotifierHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoadingNotifier(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoadingNotifierHash() => r'9021fcae0e44a0e96bfea85f6cd0286ac73218c3';
