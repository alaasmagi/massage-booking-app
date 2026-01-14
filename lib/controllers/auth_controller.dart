import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/providers/auth/biometric_auth_provider.dart';
import 'package:massage_booking_app/providers/auth/is_user_logged_in_provider.dart';
import 'package:massage_booking_app/providers/settings/settings_provider.dart';
import 'package:massage_booking_app/services/loading_manager.dart';

class AuthController {
  final WidgetRef ref;
  final BuildContext context;
  final VoidCallback onBiometricPromptTriggered;

  AuthController({
    required this.ref,
    required this.context,
    required this.onBiometricPromptTriggered,
  });

  bool shouldTriggerBiometric({
    required bool isLoggedIn,
    required bool biometricPromptTriggered,
  }) {
    return isLoggedIn && !biometricPromptTriggered;
  }

  Future<void> triggerBiometricAuthIfNeeded({
    required bool biometricPromptTriggered,
  }) async {
    final isLoggedIn = ref.read(isLoggedInProvider);

    if (!isLoggedIn || biometricPromptTriggered) {
      return;
    }

    onBiometricPromptTriggered();

    if (!context.mounted) return;

    await LoadingManager.withLoading(ref, () async {
      await _performBiometricAuth();
    });
  }

  Future<void> _performBiometricAuth() async {
    final settings = await ref.read(settingsProvider.future);

    if (!settings.biometricAuthEnabled) {
      return;
    }

    await ref
        .read(biometricAuthProvider.notifier)
        .authenticateAndLogoutOnFailure();
  }

  bool isUserLoggedIn() {
    return ref.read(isLoggedInProvider);
  }
}