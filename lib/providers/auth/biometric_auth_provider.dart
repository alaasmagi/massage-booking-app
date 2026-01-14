import 'package:massage_booking_app/services/auth/biometric_auth_service.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'biometric_auth_provider.g.dart';

@riverpod
class BiometricAuthNotifier extends _$BiometricAuthNotifier {
  final _biometricService = BiometricAuthService();

  @override
  Future<bool> build() async {
    return false;
  }

  Future<bool> _authenticate() async {
    if (!ref.mounted) return false;
    state = const AsyncValue.loading();

    final result = await AsyncValue.guard(
          () => _biometricService.authenticateWithBiometrics(),
    );

    if (!ref.mounted) return false;
    state = result;

    return result.maybeWhen(
      data: (success) => success,
      orElse: () => false,
    );
  }

  Future<bool> authenticateAndLogoutOnFailure() async {
    final success = await _authenticate();

    if (!ref.mounted) return false;

    if (!success) {
      await ref.read(authenticationProvider.notifier).signOut();
    }

    return success;
  }
}