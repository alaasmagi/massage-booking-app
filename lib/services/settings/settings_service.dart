import 'package:massage_booking_app/models/settings/settings.dart';
import 'package:massage_booking_app/repositories/settings/settings_repository.dart';

class SettingsService {
  final SettingsRepository _repository;

  SettingsService(this._repository);

  Future<Settings> loadSettings() async {
    try {
      final settings = await _repository.loadSettings();
      return settings ?? Settings.defaults();
    } catch (_) {
      return Settings.defaults();
    }
  }

  Future<void> saveSettings(Settings settings) async =>
      _repository.saveSettings(settings);

  Future<void> updateNotifications(bool enabled) async {
    final settings = await loadSettings();
    await saveSettings(settings.copyWith(notificationsEnabled: enabled));
  }

  Future<void> updateBiometricAuth(bool enabled) async {
    final settings = await loadSettings();
    await saveSettings(settings.copyWith(biometricAuthEnabled: enabled));
  }

  Future<void> resetToDefaults() async => saveSettings(Settings.defaults());

  Future<void> deleteSettings() async => _repository.deleteSettings();
}