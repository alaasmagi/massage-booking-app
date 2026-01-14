import 'package:massage_booking_app/models/service/service.dart';
import 'package:massage_booking_app/repositories/services/service_repository.dart';
import 'package:massage_booking_app/typedef/service_id.dart';

class ServiceService {
  final ServiceRepository _repository;

  ServiceService(this._repository);

  Future<List<Service>> getAllServices() => _repository.getAllServices();
  Future<Service?> getServiceById(ServiceId id) => _repository.getServiceById(id);
}