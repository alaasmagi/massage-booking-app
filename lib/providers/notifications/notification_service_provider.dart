import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/providers/user/user_service_provider.dart';
import 'package:massage_booking_app/services/notification/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final userService = ref.watch(userServiceProvider);
  return NotificationService(ref, userService);
});