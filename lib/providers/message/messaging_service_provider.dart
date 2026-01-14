import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/services/message/messaging_service.dart';

final messagingServiceProvider = Provider<MessagingService>((ref) {
  return const MessagingService();
});
