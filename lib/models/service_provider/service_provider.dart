import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/typedef/service_provider_id.dart';

class ServiceProvider {
  final ServiceProviderId id;
  final String calendarId;
  final String fullName;
  final String title;
  final int popularity;
  final List<String> services;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceProvider({
    required this.id,
    required this.calendarId,
    required this.fullName,
    required this.title,
    required this.popularity,
    required this.services,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceProvider.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return ServiceProvider(
      id: doc.id,
      calendarId: data['calendar_id'] as String,
      fullName: data['full_name'] as String,
      title: data['title'] as String,
      popularity: data['popularity'] as int,
      services: List<String>.from(data['services'] ?? []),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'calendar_id': calendarId,
      'full_name': fullName,
      'title': title,
      'popularity': popularity,
      'services': services,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}
