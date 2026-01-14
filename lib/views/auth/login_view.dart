import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:massage_booking_app/controllers/login_controller.dart';
import 'package:massage_booking_app/enums/auth/auth_method.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:massage_booking_app/views/widgets/common/standard_button.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController(
      ref: ref,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authenticationProvider,
          (previous, next) => _controller.handleAuthStateChange(
        previous: previous,
        next: next,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _buildLoginContent(),
        ),
      ),
    );
  }

  Widget _buildLoginContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLogo(),
          _buildSpacer(),
          _buildGoogleLoginButton(),
          const SizedBox(height: 16),
          _buildMicrosoftLoginButton(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset('assets/logo/app_logo.png');
  }

  Widget _buildSpacer() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.25);
  }

  Widget _buildGoogleLoginButton() {
    return StandardButton(
      label: LocalizedStrings.loginWithGoogle,
      icon: FontAwesomeIcons.google,
      onPressed: () => _controller.attemptLogin(EAuthMethod.google),
      height: AppSizeParameters.defaultButtonHeight,
      width: AppSizeParameters.primaryButtonWidth(context),
    );
  }

  Widget _buildMicrosoftLoginButton() {
    return StandardButton(
      label: LocalizedStrings.loginWithMicrosoft,
      icon: FontAwesomeIcons.microsoft,
      onPressed: () => _controller.attemptLogin(EAuthMethod.microsoft),
      height: AppSizeParameters.defaultButtonHeight,
      width: AppSizeParameters.primaryButtonWidth(context),
    );
  }
}