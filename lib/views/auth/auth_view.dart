import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/controllers/auth_controller.dart';
import 'package:massage_booking_app/providers/auth/biometric_auth_provider.dart';
import 'package:massage_booking_app/providers/auth/is_user_logged_in_provider.dart';
import 'package:massage_booking_app/views/auth/login_view.dart';
import 'package:massage_booking_app/views/bookings/bookings_view.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> with WidgetsBindingObserver {
  late final AuthController _controller;
  bool _biometricPromptTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AuthController(
      ref: ref,
      context: context,
      onBiometricPromptTriggered: _markBiometricPromptTriggered,
    );
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleBiometricAuth();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!_biometricPromptTriggered) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleBiometricAuth();
        });
      }
    }
  }

  void _markBiometricPromptTriggered() {
    _biometricPromptTriggered = true;
  }

  void _resetBiometricPrompt() {
    _biometricPromptTriggered = false;
  }

  Future<void> _handleBiometricAuth() async {
    await _controller.triggerBiometricAuthIfNeeded(
      biometricPromptTriggered: _biometricPromptTriggered,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    ref.watch(biometricAuthProvider);

    if (_controller.shouldTriggerBiometric(
      isLoggedIn: isLoggedIn,
      biometricPromptTriggered: _biometricPromptTriggered,
    )) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleBiometricAuth();
      });
    }

    if (isLoggedIn) {
      return const BookingsView();
    } else {
      _resetBiometricPrompt();
      return const LoginView();
    }
  }
}