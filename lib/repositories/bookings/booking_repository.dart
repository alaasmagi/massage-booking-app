import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/models/booking/booking.dart';
import 'package:massage_booking_app/typedef/booking_id.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class BookingRepository {
  final CollectionReference<Map<String, dynamic>> _bookings;

  BookingRepository({CollectionReference<Map<String, dynamic>>? bookings})
      : _bookings = bookings ?? FirebaseFirestore.instance.collection('bookings');

  Future<Booking?> getBookingById(BookingId id) async {
    final doc = await _bookings.doc(id).get();
    if (!doc.exists) return null;
    return Booking.fromFirestore(doc);
  }

  Future<List<Booking>> getUserBookings(UserId userId) async {
    final snapshot = await _bookings
        .where('user_id', isEqualTo: userId)
        .orderBy('start_time', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Booking.fromFirestore(doc))
        .where((booking) => booking.status != 'cancelled')
        .toList();
  }

  Future<void> cancelBooking(BookingId id) async {
    await _bookings.doc(id).update({
      'status': 'cancelled',
      'updated_at': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<String> createBooking(Map<String, dynamic> bookingData) async {
    final doc = await _bookings.add(bookingData);
    return doc.id;
  }

  Future<bool> providerHasConflict({
    required ServiceProviderId providerId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final snapshot = await _bookings
        .where('service_provider_id', isEqualTo: providerId)
        .where('status', isEqualTo: 'confirmed')
        .where('start_time', isLessThan: endTime)
        .where('end_time', isGreaterThan: startTime)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<bool> userHasConflict({
    required UserId userId,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final snapshot = await _bookings
        .where('user_id', isEqualTo: userId)
        .where('status', isEqualTo: 'confirmed')
        .where('start_time', isLessThan: endTime)
        .where('end_time', isGreaterThan: startTime)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> deleteUserBookings(UserId userId) async {
    final snapshot = await _bookings
        .where('user_id', isEqualTo: userId)
        .get();

    final batch = FirebaseFirestore.instance.batch();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

