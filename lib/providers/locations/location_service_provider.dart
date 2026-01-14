import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/repositories/locations/location_repository.dart';
import 'package:massage_booking_app/services/location/location_service.dart';


final locationServiceProvider = Provider<LocationService>((ref) {
  final repository = LocationRepository();
  return LocationService(repository);
});