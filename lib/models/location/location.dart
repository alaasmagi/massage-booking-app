import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:massage_booking_app/typedef/location_id.dart';

class Location {
  final LocationId id;
  final String name;
  final String address;
  final String description;
  final String phoneNumber;
  final Map<String, dynamic> businessHours;
  final DateTime createdAt;
  final DateTime updatedAt;

  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.phoneNumber,
    required this.businessHours,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return Location(
      id: doc.id,
      name: data['name'] as String,
      address: data['address'] as String,
      description: data['description'] as String,
      phoneNumber: data['phone'] as String,
      businessHours: Map<String, dynamic>.from(
        data['business_hours'] as Map<String, dynamic>,
      ),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'phone': phoneNumber,
      'business_hours': jsonEncode(businessHours),
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}