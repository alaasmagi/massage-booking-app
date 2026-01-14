import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/services/booking/booking_availability.dart';

import 'booking_service_provider.dart';

final bookingAvailabilityServiceProvider =
  Provider<BookingAvailabilityService>((ref) {
    final bookingService = ref.read(bookingServiceProvider);
    return BookingAvailabilityService(bookingService);
});