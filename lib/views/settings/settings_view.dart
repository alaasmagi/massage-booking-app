import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:massage_booking_app/controllers/settings_controller.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:massage_booking_app/providers/settings/settings_provider.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/views/widgets/common/error_display.dart';
import 'package:massage_booking_app/views/widgets/common/standard_button.dart';
import 'package:massage_booking_app/views/widgets/common/standard_app_bar.dart';
import 'package:massage_booking_app/views/widgets/toggles/toggle.dart';
import 'package:massage_booking_app/views/widgets/user/user_profile_card.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authenticationProvider);
    final settingsAsync = ref.watch(settingsProvider);
    final controller = SettingsController(ref: ref, context: context);

    return Scaffold(
      appBar: StandardAppBar(
        title: LocalizedStrings.settingsTitle,
        onBackPressed: () => router.pop(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: settingsAsync.when(
              data: (settings) => _buildSettingsContent(
                context,
                controller,
                settings,
              ),
              loading: () => _buildLoadingState(),
              error: (error, stack) => _buildErrorState(controller),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsContent(
      BuildContext context,
      SettingsController controller,
      dynamic settings,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        UserProfileCard(
          fullName: controller.displayName,
          email: controller.displayEmail,
        ),
        const SizedBox(height: 40),
        Toggle(
          label: LocalizedStrings.pushNotificationsTitle,
          value: settings.notificationsEnabled,
          onChanged: controller.handleNotificationToggle,
        ),
        const SizedBox(height: 16),
        Toggle(
          label: LocalizedStrings.biometricAuthenticationTitle,
          value: settings.biometricAuthEnabled,
          onChanged: controller.handleBiometricToggle,
        ),
        const SizedBox(height: 60),
        StandardButton(
          label: LocalizedStrings.signOutConfirmationButton,
          icon: FontAwesomeIcons.arrowRightFromBracket,
          onPressed: controller.attemptLogOut,
          height: AppSizeParameters.defaultButtonHeight,
          width: AppSizeParameters.primaryButtonWidth(context),
        ),
        const SizedBox(height: 12),
        _buildDeleteDataButton(context, controller),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildDeleteDataButton(
      BuildContext context,
      SettingsController controller,
      ) {
    return Center(
      child: TextButton(
        onPressed: controller.attemptDeleteData,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          LocalizedStrings.deleteMyDataConfirmationLink,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(SettingsController controller) {
    return ErrorDisplay(
      message: LocalizedStrings.deleteMyDataFailure,
      onRetry: controller.reloadSettings,
      retryLabel: LocalizedStrings.generalTryAgain,
    );
  }
}