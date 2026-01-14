import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/enums/auth/auth_method.dart';
import 'package:massage_booking_app/enums/auth/auth_result.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:massage_booking_app/services/loading_manager.dart';
import 'package:massage_booking_app/utils/snackbar_utils.dart';

class LoginController {
  final WidgetRef ref;
  final BuildContext context;

  LoginController({
    required this.ref,
    required this.context,
  });

  Future<void> attemptLogin(EAuthMethod method) async {
    final authProvider = ref.read(authenticationProvider.notifier);

    await LoadingManager.withLoading(ref, () async {
      await authProvider.signInWithAuthMethod(method);
    });
  }

  void handleAuthStateChange({
    required dynamic previous,
    required dynamic next,
  }) {
    if (next.result == EAuthResult.failure && !next.isLoading) {
      _showLoginError();
    }
  }

  void _showLoginError() {
    if (!context.mounted) return;
    SnackbarUtils.showError(context, LocalizedStrings.loginFailed);
  }
}