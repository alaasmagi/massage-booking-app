import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/models/service_provider/service_provider.dart';
import 'package:massage_booking_app/typedef/service_id.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';

class ServiceProviderRepository {
  final CollectionReference<Map<String, dynamic>> _serviceProviders;

  ServiceProviderRepository({CollectionReference<Map<String, dynamic>>? locations})
      : _serviceProviders = locations ?? FirebaseFirestore.instance.collection('service_providers');

  Future<ServiceProvider?> getServiceById(ServiceProviderId id) async {
    final doc = await _serviceProviders.doc(id).get();
    if (!doc.exists) return null;
    return ServiceProvider.fromFirestore(doc);
  }

  Future<List<ServiceProvider>> getServiceProvidersByServiceId(ServiceId id) async {

    final snapshot = await _serviceProviders
        .where('services', arrayContains: id)
        .get();
    return snapshot.docs
        .map((doc) => ServiceProvider.fromFirestore(doc))
        .toList();
  }
}