import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:massage_booking_app/typedef/user_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_id_provider.g.dart';

@riverpod
UserId? userId(Ref ref) {
  final authProvider = ref.watch(authenticationProvider);
  return authProvider.userId;
}