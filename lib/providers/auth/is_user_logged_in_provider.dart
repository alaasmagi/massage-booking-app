import 'package:massage_booking_app/enums/auth/auth_result.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_user_logged_in_provider.g.dart';

@riverpod
bool isLoggedIn(Ref ref) {
  final authProvider = ref.watch(authenticationProvider);
  return authProvider.result == EAuthResult.success;
}