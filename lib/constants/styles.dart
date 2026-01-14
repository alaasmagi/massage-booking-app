import 'package:flutter/material.dart';

@immutable
class AppColors {
  static var primaryControlColor = const Color(0xFF334139);
  static var textOnLight = const Color(0xFF19201C);
  static var textOnDark = const Color(0xFFE8EDEA);
  static var secondaryControlColor = const Color(0xFFADB3AF);
  static var widgetBackgroundColor = const Color(0xFFD6D9D7);
  static var backgroundColor = const Color(0xFFEAECEB);

  const AppColors._();
}

@immutable
class AppSizeParameters {

  static const double defaultButtonHeight = 50;
  static double primaryButtonWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static const double floatingButtonWidth = 150;

  static const double cardButtonHeight = 40;
  static const double cardButtonWidth = 120;

  const AppSizeParameters._();
}
