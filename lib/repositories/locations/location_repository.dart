import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/models/location/location.dart';
import 'package:massage_booking_app/typedef/location_id.dart';

class LocationRepository {
  final CollectionReference<Map<String, dynamic>> _locations;

  LocationRepository({CollectionReference<Map<String, dynamic>>? locations})
      : _locations = locations ?? FirebaseFirestore.instance.collection('locations');

  Future<Location?> getLocationById(LocationId id) async {
    final doc = await _locations.doc(id).get();
    if (!doc.exists) return null;
    return Location.fromFirestore(doc);
  }

  Future<List<Location>> getAllLocations() async {
    final snapshot = await _locations.get();
    return snapshot.docs.map((doc) => Location.fromFirestore(doc)).toList();
  }
}