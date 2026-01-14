import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/firebase_options.dart';
import 'package:massage_booking_app/providers/notifications/notification_service_provider.dart';
import 'package:massage_booking_app/providers/theme/theme_provider.dart';
import 'package:massage_booking_app/router/router.dart';
import 'package:massage_booking_app/services/notification/notification_service.dart';
import 'package:massage_booking_app/views/widgets/loading_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child:MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(notificationServiceProvider).initializeNotificationListeners();


    final theme = ref.watch(currentThemeProvider);
    return MaterialApp.router(
      title: 'Halóre',
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      builder: (context, child) {
        return LoadingOverlay(
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
