import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/services/booking/booking_service.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class BookingAvailabilityService {
  final BookingService _bookingService;
  BookingAvailabilityService(this._bookingService);

  Future<bool> isBookingAvailable({
    required UserId userId,
    required Location location,
    required ServiceProviderId providerId,
    required DateTime start,
    required DateTime end,
  }) async {

    if (!_isWithinBusinessHours(location, start, end)) {
      return false;
    }

    final hasConflict =
    await _bookingService.hasConflict(
      userId: userId,
      providerId: providerId,
      startTime: start,
      endTime: end,
    );

    return !hasConflict;
  }

  bool _isWithinBusinessHours(
      Location location,
      DateTime start,
      DateTime end,
      ) {
    final hours = location.businessHours;
    final dayKey = start.weekday.toString();

    if (!hours.containsKey(dayKey)) return false;

    final day = hours[dayKey];
    final open = _buildTime(start, day['start']);
    final close = _buildTime(start, day['end']);

    return !start.isBefore(open) && !end.isAfter(close);
  }

  DateTime _buildTime(DateTime base, String hhmm) {
    final parts = hhmm.split(':');
    return DateTime(
      base.year,
      base.month,
      base.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
}
