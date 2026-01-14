import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showSuccess(BuildContext context, String message) {
    _show(context, message, backgroundColor: Colors.green);
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, backgroundColor: Colors.red);
  }

  static void showWarning(BuildContext context, String message) {
    _show(context, message, backgroundColor: Colors.orange);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message);
  }

  static void _show(
    BuildContext context,
    String message, {
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
  }
}
