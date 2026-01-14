import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/providers/locations/location_service_provider.dart';
import 'package:massage_booking_app/providers/service_providers/service_provider_service_provider.dart';
import 'package:massage_booking_app/providers/services/service_service_provider.dart';
import 'package:massage_booking_app/repositories/bookings/booking_repository.dart';
import 'package:massage_booking_app/services/booking/booking_service.dart';

final bookingServiceProvider = Provider<BookingService>((ref) {
  final bookingRepository = BookingRepository();
  final locationService = ref.read(locationServiceProvider);
  final serviceService = ref.read(serviceServiceProvider);
  final serviceProviderService = ref.read(serviceProviderServiceProvider);

  return BookingService(
    repository: bookingRepository,
    locationService: locationService,
    serviceService: serviceService,
    providerService: serviceProviderService,
  );
});