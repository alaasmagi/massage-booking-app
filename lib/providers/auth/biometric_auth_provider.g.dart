// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometric_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BiometricAuthNotifier)
const biometricAuthProvider = BiometricAuthNotifierProvider._();

final class BiometricAuthNotifierProvider
    extends $AsyncNotifierProvider<BiometricAuthNotifier, bool> {
  const BiometricAuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricAuthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricAuthNotifierHash();

  @$internal
  @override
  BiometricAuthNotifier create() => BiometricAuthNotifier();
}

String _$biometricAuthNotifierHash() =>
    r'888aac981361999a319c1c041de9af6e8de94a68';

abstract class _$BiometricAuthNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
