import 'package:firebase_auth/firebase_auth.dart';
import 'package:massage_booking_app/enums/auth/auth_result.dart';
import 'package:massage_booking_app/services/user/user_service.dart';
import 'package:massage_booking_app/typedef/user_id.dart';
import 'google_auth_service.dart';
import 'microsoft_auth_service.dart';

class AuthService {
  final UserService _userService;
  const AuthService({
    required UserService userService
  }) : _userService = userService;

  bool get isAlreadyLoggedIn => FirebaseAuth.instance.currentUser != null;

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;

  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Future<EAuthResult> signInWithGoogle() async {
    try {
      final credential = await GoogleAuthService.signInWithGoogle();

      if (credential.user == null) {
        return EAuthResult.failure;
      }

      await _userService.createUserIfNeeded(credential.user!);
      return EAuthResult.success;
    } catch(e) {
      print("Error logging in with Google: $e");
      return EAuthResult.failure;
    }
  }

  Future<EAuthResult> signInWithMicrosoft() async {

    try {
      final credential = await MicrosoftAuthService.signInWithMicrosoft();

      if (credential.user == null) {
        return EAuthResult.failure;
      }

      await _userService.createUserIfNeeded(credential.user!);
      return EAuthResult.success;
    } catch(e) {
      print("Error logging in with Microsoft: $e");
      return EAuthResult.failure;
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleAuthService.signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();
  }
}
