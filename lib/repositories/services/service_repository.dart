import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/models/service/service.dart';
import 'package:massage_booking_app/typedef/service_id.dart';

class ServiceRepository {
  final CollectionReference<Map<String, dynamic>> _services;

  ServiceRepository({CollectionReference<Map<String, dynamic>>? locations})
      : _services = locations ?? FirebaseFirestore.instance.collection('services');

  Future<Service?> getServiceById(ServiceId id) async {
    final doc = await _services.doc(id).get();
    if (!doc.exists) return null;
    return Service.fromFirestore(doc);
  }

  Future<List<Service>> getAllServices() async {
    final snapshot = await _services.where('status', isEqualTo: 'available').get();
    return snapshot.docs
        .map((doc) => Service.fromFirestore(doc))
        .toList();
  }
}