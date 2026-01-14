import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:massage_booking_app/models/settings/settings.dart';

class SettingsRepository {
  final FlutterSecureStorage _storage;
  final String _settingsKey;

  SettingsRepository({
    FlutterSecureStorage? storage,
    String settingsKey = 'user_settings',
  })  : _storage = storage ?? const FlutterSecureStorage(),
        _settingsKey = settingsKey;

  Future<void> saveSettings(Settings settings) async {
    final jsonString = settings.toJsonString();
    await _storage.write(key: _settingsKey, value: jsonString);
  }

  Future<Settings?> loadSettings() async {
    final jsonString = await _storage.read(key: _settingsKey);
    if (jsonString == null) return null;
    return Settings.fromJsonString(jsonString);
  }

  Future<void> deleteSettings() async => _storage.delete(key: _settingsKey);

  Future<void> clearAll() async => _storage.deleteAll();
}
