import 'package:massage_booking_app/enums/auth/auth_method.dart';
import 'package:massage_booking_app/enums/auth/auth_result.dart';
import 'package:massage_booking_app/models/auth/auth_state.dart';
import 'package:massage_booking_app/providers/user/user_service_provider.dart';
import 'package:massage_booking_app/services/auth/auth_service.dart';
import 'package:massage_booking_app/providers/settings/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Authentication extends _$Authentication {
  AuthService? _authenticator;

  @override
  AuthState build() {
    final userService = ref.read(userServiceProvider);
    _authenticator ??= AuthService(userService: userService);

    if(_authenticator!.isAlreadyLoggedIn) {
      return AuthState(
          result: EAuthResult.success,
          isLoading: false,
          userId: _authenticator!.userId
      );
    }

    return AuthState.unknown();
  }

  Future<void> signInWithAuthMethod(EAuthMethod method) async {
    state = AuthState(
      result: state.result,
      isLoading: true,
      userId: state.userId,
    );

    EAuthResult result;
    switch(method) {
      case EAuthMethod.google:
        result = await _authenticator!.signInWithGoogle();
        break;
      case EAuthMethod.microsoft:
        result = await _authenticator!.signInWithMicrosoft();
        break;
    }

    state = AuthState(
        result: result,
        isLoading: false,
        userId: _authenticator!.userId
    );
  }

  Future<void> signOut() async {
    state = AuthState(
      result: state.result,
      isLoading: true,
      userId: state.userId,
    );

    try {
      final settingsService = ref.read(settingsProvider.notifier).settingsService;
      await settingsService.deleteSettings();
      print('Settings deleted on sign out');
    } catch (e) {
      print('Error deleting settings on sign out: $e');
    }

    ref.invalidate(settingsProvider);

    await _authenticator!.signOut();
    state = AuthState.unknown();
  }
}
