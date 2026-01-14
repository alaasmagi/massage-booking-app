import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:massage_booking_app/providers/auth/user_id_provider.dart';
import 'package:massage_booking_app/providers/settings/settings_provider.dart';
import 'package:massage_booking_app/providers/user/user_service_provider.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/services/loading_manager.dart';
import 'package:massage_booking_app/utils/snackbar_utils.dart';
import 'package:massage_booking_app/views/widgets/dialogs/confirmation_dialog.dart';

class SettingsController {
  final WidgetRef ref;
  final BuildContext context;

  SettingsController({
    required this.ref,
    required this.context,
  });

  Future<void> handleBiometricToggle(bool newValue) async {
    final ok = await ref.read(settingsProvider.notifier).toggleBiometricAuth(newValue);

    if (!context.mounted) return;

    if (newValue && !ok) {
      SnackbarUtils.showError(context, LocalizedStrings.biometricAuthenticationUnavailable);
    }
  }

  Future<void> handleNotificationToggle(bool newValue) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) return;

    final ok = await LoadingManager.withLoading(ref, () async {
      await ref.read(settingsProvider.notifier).toggleNotifications(
        userId: userId,
        enabled: newValue,
      );
    });

    if (!context.mounted) return;

    if (newValue && !ok) {
      SnackbarUtils.showWarning(context, LocalizedStrings.pushNotificationsUnavailable);
    }
  }

  Future<void> attemptLogOut() async {
    final confirmed = await ConfirmationDialog.show(
      context,
      title: LocalizedStrings.signOutConfirmationButton,
      content: LocalizedStrings.signOutConfirmation,
      confirmText: LocalizedStrings.signOutConfirmationButton,
    );

    if (confirmed) {
      await LoadingManager.withLoading(ref, () async {
        final authProvider = ref.read(authenticationProvider.notifier);
        authProvider.signOut();
      });

      router.go("/");
    }
  }

  Future<void> attemptDeleteData() async {
    final confirmed = await ConfirmationDialog.show(
      context,
      title: LocalizedStrings.deleteMyDataConfirmationLink,
      content: LocalizedStrings.deleteMyDataConfirmation,
      confirmText: LocalizedStrings.deleteMyDataConfirmationLink,
      isDestructive: true,
    );

    if (confirmed) {
      try {
        await LoadingManager.withLoading(ref, () async {
          final userService = ref.read(userServiceProvider);
          await userService.deleteAccount();
          final authProvider = ref.read(authenticationProvider.notifier);
          authProvider.signOut();
        });
        router.go("/");
      } catch (e) {
        if (context.mounted) {
          SnackbarUtils.showError(
            context,
            '${LocalizedStrings.deleteMyDataFailure}: $e',
          );
        }
      }
    }
  }

  String get displayName {
    final userService = ref.read(userServiceProvider);
    return userService.currentUser?.displayName ?? "";
  }

  String get displayEmail {
    final userService = ref.read(userServiceProvider);
    return userService.currentUser?.email ?? "";
  }

  void reloadSettings() {
    ref.read(settingsProvider.notifier).reload();
  }
}
