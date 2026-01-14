import 'package:massage_booking_app/typedef/location_id.dart';
import 'package:massage_booking_app/typedef/service_id.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class BookingDraft {
  final LocationId? locationId;
  final ServiceId? serviceId;
  final ServiceProviderId? serviceProviderId;
  final DateTime? startTime;
  final int? duration;
  final UserId? userId;

  const BookingDraft({
    this.locationId,
    this.serviceId,
    this.serviceProviderId,
    this.startTime,
    this.duration,
    this.userId,
  });

  BookingDraft copyWith({
    LocationId? locationId,
    ServiceId? serviceId,
    ServiceProviderId? serviceProviderId,
    DateTime? startTime,
    int? duration,
    UserId? userId,
  }) {
    return BookingDraft(
      locationId: locationId ?? this.locationId,
      serviceId: serviceId ?? this.serviceId,
      serviceProviderId:
      serviceProviderId ?? this.serviceProviderId,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      userId: userId ?? this.userId,
    );
  }
}