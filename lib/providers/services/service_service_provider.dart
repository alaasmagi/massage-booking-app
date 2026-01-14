import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/repositories/services/service_repository.dart';
import 'package:massage_booking_app/services/service/service_service.dart';

final serviceServiceProvider = Provider<ServiceService>((ref) {
  final repository = ServiceRepository();
  return ServiceService(repository);
});