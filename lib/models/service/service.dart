import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/typedef/service_id.dart';

class Service {
  final ServiceId id;
  final String name;
  final String description;
  final int duration;
  final double price;
  final String status;
  final String thumbnail;
  final DateTime createdAt;
  final DateTime updatedAt;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.status,
    required this.thumbnail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return Service(
      id: doc.id,
      name: data['name'] as String,
      description: data['description'] as String,
      duration: data['duration'] as int,
      price: (data['price'] as num).toDouble(),
      status: data['status'] as String,
      thumbnail: data['thumbnail'] as String,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'price': price,
      'status': status,
      'thumbnail': thumbnail,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}