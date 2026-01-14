import 'package:flutter/material.dart';

class DateTimeStepController {
  final BuildContext context;

  DateTimeStepController({required this.context});

  Future<DateTime?> pickDateTime({DateTime? initialDateTime}) async {
    final now = DateTime.now();
    final initial = initialDateTime ?? now;

    final date = await _pickDate(initial, now);
    if (date == null) return null;

    final time = await _pickTime(initial);
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<DateTime?> _pickDate(DateTime initial, DateTime now) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
  }

  Future<TimeOfDay?> _pickTime(DateTime initial) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
  }
}
