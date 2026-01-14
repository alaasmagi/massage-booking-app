import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/repositories/locations/location_repository.dart';
import 'package:massage_booking_app/typedef/location_id.dart';

class LocationService {
  final LocationRepository _repository;

  LocationService(this._repository);

  Future<List<Location>> getAllLocations() => _repository.getAllLocations();
  Future<Location?> getLocationById(LocationId id) => _repository.getLocationById(id);
}