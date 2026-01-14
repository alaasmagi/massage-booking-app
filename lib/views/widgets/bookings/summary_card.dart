import 'package:flutter/material.dart';
import 'package:massage_booking_app/views/widgets/bookings/summary_row.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final List<SummaryRow> rows;

  const SummaryCard({
    super.key,
    required this.title,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Widget> children = [];

    children.add(Text(
      title,
      style: theme.textTheme.titleLarge,
    ));
    children.add(const SizedBox(height: 16));

    for (int i = 0; i < rows.length; i++) {
      children.add(SummaryRow(
        icon: rows[i].icon,
        label: rows[i].label,
        value: rows[i].value,
      ));

      if (i < rows.length - 1) {
        children.add(const SizedBox(height: 12));
      }
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}



