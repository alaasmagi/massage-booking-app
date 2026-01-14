import 'package:massage_booking_app/models/service_provider/service_provider.dart';
import 'package:massage_booking_app/repositories/service_providers/service_provider_repository.dart';
import 'package:massage_booking_app/typedef/service_id.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';

class ServiceProviderService {
  final ServiceProviderRepository _repository;

  ServiceProviderService(this._repository);

  Future<List<ServiceProvider>> getServiceProvidersByServiceId(ServiceId id) =>
                                _repository.getServiceProvidersByServiceId(id);
  Future<ServiceProvider?> getServiceProviderById(ServiceProviderId id) =>
                                                _repository.getServiceById(id);
}