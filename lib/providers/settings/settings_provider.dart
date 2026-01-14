import 'package:massage_booking_app/models/settings/settings.dart';
import 'package:massage_booking_app/providers/notifications/notification_service_provider.dart';
import 'package:massage_booking_app/repositories/settings/settings_repository.dart';
import 'package:massage_booking_app/services/auth/biometric_auth_service.dart';
import 'package:massage_booking_app/services/notification/notification_service.dart';
import 'package:massage_booking_app/services/settings/settings_service.dart';
import 'package:massage_booking_app/typedef/user_id.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  late final SettingsService _settingsService;
  NotificationService get _notificationService => ref.read(notificationServiceProvider);
  final BiometricAuthService _biometricService = BiometricAuthService();

  @override
  Future<Settings> build() {
    final repository = SettingsRepository();
    _settingsService = SettingsService(repository);
    return _settingsService.loadSettings();
  }

  Future<void> _update(Settings Function(Settings) update) async {
    final current = await future;
    final newSettings = update(current);
    state = AsyncValue.data(newSettings);

    try {
      await _settingsService.saveSettings(newSettings);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      await reload();
    }
  }

  Future<void> setNotificationsEnabled(bool enabled) =>
      _update((s) => s.copyWith(notificationsEnabled: enabled));

  Future<void> setBiometricAuthEnabled(bool enabled) =>
      _update((s) => s.copyWith(biometricAuthEnabled: enabled));

  SettingsService get settingsService => _settingsService;

  Future<bool> toggleNotifications({
    required UserId userId,
    required bool enabled,
  }) async {
    if (enabled) {
      final token = await _notificationService.requestPermissionAndGetToken();
      await setNotificationsEnabled(token != null);
      return token != null;
    } else {
      await _notificationService.removeToken();
      await setNotificationsEnabled(false);
      return true;
    }
  }

  Future<bool> toggleBiometricAuth(bool enabled) async {
    if (!enabled) return setBiometricAuthEnabled(false).then((_) => true);

    final available = await _biometricService.isBiometricsAvailable();
    if (!available) return setBiometricAuthEnabled(false).then((_) => false);

    final authenticated = await _biometricService.authenticateWithBiometrics();
    await setBiometricAuthEnabled(authenticated);
    return authenticated;
  }

  Future<void> saveSettings(Settings settings) async => _update((_) => settings);

  Future<void> resetToDefaults() async => _update((_) => Settings.defaults());

  Future<void> reload() async {
    state = const AsyncValue.loading();
    try {
      state = AsyncValue.data(await _settingsService.loadSettings());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
