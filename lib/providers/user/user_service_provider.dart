import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massage_booking_app/providers/booking/booking_service_provider.dart';
import 'package:massage_booking_app/providers/settings/settings_provider.dart';
import 'package:massage_booking_app/repositories/users/user_repository.dart';
import 'package:massage_booking_app/services/user/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = UserRepository();
  final bookingService = ref.read(bookingServiceProvider);
  final settingsNotifier = ref.read(settingsProvider.notifier);
  final settingsService = settingsNotifier.settingsService;

  return UserService(
    userRepository: userRepository,
    bookingService: bookingService,
    settingsService: settingsService,
    ref: ref
  );
});
