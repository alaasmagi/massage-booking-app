// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_id_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userId)
const userIdProvider = UserIdProvider._();

final class UserIdProvider
    extends $FunctionalProvider<UserId?, UserId?, UserId?>
    with $Provider<UserId?> {
  const UserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userIdHash();

  @$internal
  @override
  $ProviderElement<UserId?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserId? create(Ref ref) {
    return userId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserId? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserId?>(value),
    );
  }
}

String _$userIdHash() => r'823a1df4b9b43c04defe32d0f94921302ec923e2';
