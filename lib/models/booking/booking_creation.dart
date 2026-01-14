import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/models/service/service.dart';
import 'package:massage_booking_app/models/service_provider/service_provider.dart';

class BookingCreationData {
  final Location location;
  final Service service;
  final ServiceProvider provider;

  BookingCreationData({
    required this.location,
    required this.service,
    required this.provider,
  });
}