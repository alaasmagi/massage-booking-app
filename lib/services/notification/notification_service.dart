import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/providers/user/user_service_provider.dart';
import 'package:massage_booking_app/services/user/user_service.dart';
import 'package:permission_handler/permission_handler.dart';



class NotificationService {
  final Ref _ref;
  final UserService _userService;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  NotificationService(this._ref, this._userService);

  String? get _userId => _userService.userId;

  Future<String?> requestPermissionAndGetToken() async {
    final userId = _userId;
    if (userId == null) return null;

    try {
      final permission = await Permission.notification.request();

      if (!permission.isGranted) {
        print('Notification permission denied');
        await _userService.updateFcmToken(null);
        return null;
      }

      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        final token = await _messaging.getToken();
        if (token != null) {
          await _userService.updateFcmToken(token);
          return token;
        }
      } else {
        await _userService.updateFcmToken(null);
      }
    } catch (e) {
      print('Error requesting notification permission: $e');
    }
    return null;
  }

  Future<void> removeToken() async {
    final userId = _userId;
    if (userId == null) return;

    await _messaging.deleteToken();
    await _userService.updateFcmToken(null);
  }

  Future<bool> areNotificationsEnabled() async {
    final permission = await Permission.notification.status;
    return permission.isGranted;
  }

  void initializeNotificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received foreground message: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from notification');
    });

    _messaging.onTokenRefresh.listen((newToken) async {
      final userId = _userId;
      if (userId != null && newToken != null) {
        await _userService.updateFcmToken(newToken);
        print('FCM token refreshed: $newToken');
      }
    });
  }

  Future<String?> getCurrentToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      return null;
    }
  }

  Future<void> updateFcmToken() async {
    final userId = _userId;
    if (userId == null) return;

    final token = await getCurrentToken();
    if (token != null) {
      await _userService.updateFcmToken(token);
      print('FCM token updated for user $userId');
    }
  }
}


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling background message: ${message.messageId}');
}
