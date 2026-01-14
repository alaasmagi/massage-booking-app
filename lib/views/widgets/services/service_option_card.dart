import 'package:flutter/material.dart';
import 'package:massage_booking_app/constants/l10n/localized_strings.dart';
import 'package:massage_booking_app/utils/text_formatters.dart';
import 'package:massage_booking_app/views/widgets/other/selection_indicator.dart';

class ServiceOptionCard extends StatelessWidget {
  final String name;
  final String description;
  final int duration;
  final double price;
  final String thumbnail;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceOptionCard({
    super.key,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.thumbnail,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(24);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side:  BorderSide(
          color: theme.colorScheme.primary,
          width: isSelected ? 3 : 1,
        )
      ),
      color: theme.colorScheme.surfaceContainerHighest,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Row(
                children: [
                  SelectionIndicator(isSelected: isSelected),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.zero,
                bottom: Radius.zero,
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.asset(
                  'assets/services/$thumbnail',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${LocalizedStrings.durationLabel}: ${duration}min',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        TextFormatters.formatCurrency(price),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
