import 'package:intl/intl.dart';

class TextFormatters {
  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'et_EE', symbol: '€').format(amount);
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatServiceSummary(String name, double? price) {
    if (price == null) return name;
    return '$name • ${formatCurrency(price)}';
  }
}
