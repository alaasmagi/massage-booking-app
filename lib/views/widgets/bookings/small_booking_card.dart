import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/models/booking/booking.dart';
import 'package:massage_booking_app/utils/text_formatters.dart';

class SmallBookingCard extends StatelessWidget {
  const SmallBookingCard({
    super.key,
    required this.booking,
    required this.onTap,
  });

  final Booking booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
            booking.serviceName,
            style: theme.textTheme.titleMedium),
        subtitle: Text(
            TextFormatters.formatDateTime(booking.startTime),
            style: theme.textTheme.bodyMedium,
        ),
        trailing: FaIcon(
            FontAwesomeIcons.angleDown,
            color: theme.hintColor
        )),
    );
  }
}
