import 'package:massage_booking_app/models/booking/booking.dart';
import 'package:massage_booking_app/providers/auth/user_id_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'booking_service_provider.dart';

part 'user_bookings_provider.g.dart';

@riverpod
Future<List<Booking>> userBookings(Ref ref) async {
  final userId = ref.watch(userIdProvider);
  final bookingService = ref.watch(bookingServiceProvider);

  if (userId == null) return [];

  return bookingService.getUserBookings(userId);
}

