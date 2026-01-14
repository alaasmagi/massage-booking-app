import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/typedef/booking_id.dart';
import 'package:massage_booking_app/typedef/location_id.dart';
import 'package:massage_booking_app/typedef/service_id.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class Booking {
  final BookingId id;
  final String eventId;
  final ServiceId serviceId;
  final ServiceProviderId serviceProviderId;
  final LocationId locationId;
  final UserId userId;
  final double price;
  final double duration;
  final String status;
  final String serviceName;
  final String serviceDescription;
  final String serviceThumbnail;
  final String providerFullName;
  final String providerTitle;
  final String locationName;
  final String locationPhone;
  final String address;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Booking({
    required this.id,
    required this.eventId,
    required this.serviceId,
    required this.serviceProviderId,
    required this.locationId,
    required this.userId,
    required this.price,
    required this.duration,
    required this.serviceName,
    required this.serviceDescription,
    required this.serviceThumbnail,
    required this.providerFullName,
    required this.providerTitle,
    required this.locationName,
    required this.locationPhone,
    required this.address,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return Booking(
      id: doc.id,
      eventId: data['event_id'] as String,
      serviceId: data['service_id'] as String,
      serviceProviderId: data['service_provider_id'] as String,
      locationId: data['location_id'] as String,
      userId: data['user_id'] as String,
      serviceName: data['service_name'] as String,
      serviceDescription: data['service_description'] as String,
      serviceThumbnail: data['service_thumbnail'] as String,
      duration: (data['duration'] as num).toDouble(),
      price: (data['price'] as num).toDouble(),
      providerFullName: data['provider_full_name'] as String,
      providerTitle: data['provider_title'] as String,
      locationName: data['location_name'] as String,
      locationPhone: data['location_phone'] as String,
      address: data['address'] as String,
      status: data['status'] as String,
      startTime: (data['start_time'] as Timestamp).toDate(),
      endTime: (data['end_time'] as Timestamp).toDate(),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'event_id': eventId,
      'service_id': serviceId,
      'service_provider_id': serviceProviderId,
      'location_id': locationId,
      'user_id': userId,
      'service_name': serviceName,
      'service_description': serviceDescription,
      'service_thumbnail': serviceThumbnail,
      'duration': duration,
      'price': price,
      'provider_full_name': providerFullName,
      'provider_title': providerTitle,
      'location_name': locationName,
      'location_phone': locationPhone,
      'address': address,
      'status': status,
      'start_time': Timestamp.fromDate(startTime),
      'end_time': Timestamp.fromDate(endTime),
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}
