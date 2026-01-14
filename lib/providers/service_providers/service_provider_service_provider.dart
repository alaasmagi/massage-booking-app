import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/repositories/service_providers/service_provider_repository.dart';
import 'package:massage_booking_app/services/service_provider/service_provider_service.dart';

final serviceProviderServiceProvider = Provider<ServiceProviderService>((ref) {
  final repository = ServiceProviderRepository();
  return ServiceProviderService(repository);
});