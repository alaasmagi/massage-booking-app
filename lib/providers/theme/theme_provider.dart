import 'package:flutter/material.dart';
import 'package:massage_booking_app/constants/styles.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
ThemeData currentTheme(Ref ref) {
  final primary = AppColors.primaryControlColor;
  final textOnDark = AppColors.textOnDark;
  final textOnLight = AppColors.textOnLight;
  final secondary = AppColors.secondaryControlColor;
  final surface = AppColors.widgetBackgroundColor;
  final background = AppColors.backgroundColor;

  return ThemeData(
      scaffoldBackgroundColor: background,
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: primary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textOnLight,
        iconTheme: IconThemeData(color: primary),
        titleTextStyle: TextStyle(color: textOnLight, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textOnLight, fontSize: 24, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: secondary,
        foregroundColor: textOnDark,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(primary),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return surface;
          }
          return null;
        }),
        trackOutlineColor: WidgetStateProperty.all(primary),
      ),
  );
}

