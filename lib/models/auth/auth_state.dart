import 'package:massage_booking_app/enums/auth/auth_result.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class AuthState {
  final EAuthResult? result;
  final bool isLoading;
  final UserId? userId;

  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  factory AuthState.unknown() => const AuthState(
    result: null,
    isLoading: false,
    userId: null,
  );
}