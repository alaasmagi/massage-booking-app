import 'dart:convert';

class Settings {
  final bool notificationsEnabled;
  final bool biometricAuthEnabled;

  Settings({
    required this.notificationsEnabled,
    required this.biometricAuthEnabled,
  });

  Map<String, dynamic> toJson() {
    return {
      'notificationsEnabled': notificationsEnabled,
      'biometricAuthEnabled': biometricAuthEnabled,
    };
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? false,
      biometricAuthEnabled: json['biometricAuthEnabled'] as bool? ?? false,
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory Settings.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return Settings.fromJson(json);
  }

  Settings copyWith({
    bool? notificationsEnabled,
    bool? biometricAuthEnabled,
  }) {
    return Settings(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      biometricAuthEnabled: biometricAuthEnabled ?? this.biometricAuthEnabled,
    );
  }

  factory Settings.defaults() {
    return Settings(
      notificationsEnabled: false,
      biometricAuthEnabled: false,
    );
  }
}