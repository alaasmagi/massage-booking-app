import 'package:massage_booking_app/models/booking/booking.dart';
import 'package:massage_booking_app/models/booking/booking_creation.dart';
import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/models/service/service.dart';
import 'package:massage_booking_app/models/service_provider/service_provider.dart';
import 'package:massage_booking_app/repositories/bookings/booking_repository.dart';
import 'package:massage_booking_app/services/location/location_service.dart';
import 'package:massage_booking_app/services/service/service_service.dart';
import 'package:massage_booking_app/services/service_provider/service_provider_service.dart';
import 'package:massage_booking_app/typedef/booking_id.dart';
import 'package:massage_booking_app/typedef/location_id.dart';
import 'package:massage_booking_app/typedef/service_id.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class BookingService {
  final BookingRepository _repository;
  final LocationService _locationService;
  final ServiceService _serviceService;
  final ServiceProviderService _providerService;

  BookingService({
    required BookingRepository repository,
    required LocationService locationService,
    required ServiceService serviceService,
    required ServiceProviderService providerService,
  })  : _repository = repository,
        _locationService = locationService,
        _serviceService = serviceService,
        _providerService = providerService;

  Future<String> createBooking({
    required Service service,
    required ServiceProvider provider,
    required Location location,
    required UserId userId,
    required DateTime startTime,
  }) async {
    final now = DateTime.now();
    final endTime = startTime.add(Duration(minutes: service.duration));

    final booking = Booking(
      id: '',
      eventId: '',
      serviceId: service.id,
      serviceProviderId: provider.id,
      locationId: location.id,
      userId: userId,
      price: service.price,
      duration: service.duration.toDouble(),
      serviceName: service.name,
      serviceDescription: service.description,
      serviceThumbnail: service.thumbnail,
      providerFullName: provider.fullName,
      providerTitle: provider.title,
      locationName: location.name,
      locationPhone: location.phoneNumber,
      address: location.address,
      status: 'confirmed',
      startTime: startTime,
      endTime: endTime,
      createdAt: now,
      updatedAt: now,
    );

    return _repository.createBooking(booking.toFirestore());
  }

  Future<Booking?> getBooking(BookingId id) => _repository.getBookingById(id);

  Future<List<Booking>> getUserBookings(UserId userId) => _repository.getUserBookings(userId);

  Future<void> cancelBooking(BookingId id) => _repository.cancelBooking(id);

  Future<void> deleteUserBookings(UserId id) => _repository.deleteUserBookings(id);

  Future<bool> hasConflict({
    required UserId userId,
    required ServiceProviderId providerId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final results = await Future.wait([
      _repository.providerHasConflict(
          providerId: providerId, startTime: startTime, endTime: endTime),
      _repository.userHasConflict(
          userId: userId, startTime: startTime, endTime: endTime),
    ]);

    return results.any((r) => r);
  }

  Future<BookingCreationData?> fetchBookingData({
    required LocationId locationId,
    required ServiceId serviceId,
    required ServiceProviderId providerId,
  }) async {
    final location = await _locationService.getLocationById(locationId);
    final service = await _serviceService.getServiceById(serviceId);
    final provider = await _providerService.getServiceProviderById(providerId);

    if (location == null || service == null || provider == null) return null;

    return BookingCreationData(
      location: location,
      service: service,
      provider: provider,
    );
  }

  String? findClosestBookingId(List<Booking> bookings) {
    final now = DateTime.now();
    final futureBookings = bookings
        .where((b) => b.startTime.isAfter(now))
        .toList();
    if (futureBookings.isEmpty)
          return null;

    futureBookings.sort( (a, b) => a.startTime.compareTo(b.startTime), );
    return futureBookings.first.id;
  }
}