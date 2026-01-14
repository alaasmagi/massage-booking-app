import 'package:firebase_auth/firebase_auth.dart';
import 'package:massage_booking_app/providers/auth/auth_provider.dart';
import 'package:massage_booking_app/providers/auth/user_id_provider.dart';
import 'package:massage_booking_app/repositories/users/user_repository.dart';
import 'package:massage_booking_app/services/booking/booking_service.dart';
import 'package:massage_booking_app/services/settings/settings_service.dart';
import 'package:riverpod/riverpod.dart';

class UserService {
  final UserRepository _userRepository;
  final BookingService _bookingService;
  final SettingsService _settingsService;
  final Ref _ref;

  UserService({
    required UserRepository userRepository,
    required BookingService bookingService,
    required SettingsService settingsService,
    required Ref ref,
  })  : _userRepository = userRepository,
        _bookingService = bookingService,
        _settingsService = settingsService,
        _ref = ref;

  String? get userId => _ref.read(userIdProvider);

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> createUserIfNeeded(User user) => _userRepository.createUserIfNeeded(user);

  bool get hasUser => userId != null;

  Future<String?> getFcmToken() async {
    final uid = userId;
    if (uid == null) return null;
    return _userRepository.getFcmToken(uid);
  }

  Future<void> updateFcmToken(String? token) async {
    final uid = userId;
    if (uid != null) {
      await _userRepository.updateFcmToken(uid, token);
    }
  }

  Future<void> deleteAccount() async {
    final uid = userId;
    if (uid == null) return;

    await _bookingService.deleteUserBookings(uid);
    await _userRepository.deleteUser(uid);
    await _settingsService.deleteSettings();

    _ref.invalidate(userIdProvider);
    _ref.invalidate(authenticationProvider);
  }
}
