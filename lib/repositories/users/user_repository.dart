import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:massage_booking_app/typedef/user_id.dart';

class UserRepository {
  static final _users =
  FirebaseFirestore.instance.collection('users');

  Future<void> createUserIfNeeded(User user) async {
    final doc = _users.doc(user.uid);

    if (!(await doc.get()).exists) {
      await doc.set({
        'uid': user.uid,
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'provider': user.providerData.first.providerId,
        'fcm_token': null,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> updateFcmToken(UserId userId, String? fcmToken) async {
    final doc = _users.doc(userId);
    await doc.update({
      'fcm_token': fcmToken,
      'updated_at': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getFcmToken(UserId userId) async {
    final doc = await _users.doc(userId).get();
    if (doc.exists) {
      final data = doc.data();
      return data?['fcm_token'] as String?;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUser(UserId userId) async {
    final doc = await _users.doc(userId).get();
    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  Future<void> deleteUser(UserId userId) async {
    final doc = _users.doc(userId);
    await doc.delete();
  }
}
