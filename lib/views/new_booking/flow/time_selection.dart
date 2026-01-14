import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:massage_booking_app/controllers/date_time_step_controller.dart';

class DateTimeStep extends StatefulWidget {
  final String providerId;
  final DateTime? selectedDateTime;
  final void Function(DateTime) onSelect;

  const DateTimeStep({
    super.key,
    required this.providerId,
    required this.onSelect,
    this.selectedDateTime,
  });

  @override
  State<DateTimeStep> createState() => _DateTimeStepState();
}

class _DateTimeStepState extends State<DateTimeStep> {
  late final DateTimeStepController _controller;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _controller = DateTimeStepController(context: context);
    _selectedDateTime = widget.selectedDateTime;
  }

  Future<void> _handleDateTimePick() async {
    final selected = await _controller.pickDateTime(
      initialDateTime: _selectedDateTime,
    );

    if (selected == null) return;

    setState(() {
      _selectedDateTime = selected;
    });

    widget.onSelect(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPickerButton(),
          const SizedBox(height: 16),
          if (_selectedDateTime != null) _buildSelectedDateTime(),
        ],
      ),
    );
  }

  Widget _buildPickerButton() {
    return FilledButton(
      onPressed: _handleDateTimePick,
      child: const Text('Vali aeg'),
    );
  }

  Widget _buildSelectedDateTime() {
    return Text(
      DateFormat('dd.MM.yyyy HH:mm').format(_selectedDateTime!),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}