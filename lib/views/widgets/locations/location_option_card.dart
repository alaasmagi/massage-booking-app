import 'package:flutter/material.dart';
import 'package:massage_booking_app/views/widgets/other/selection_indicator.dart';

class LocationOptionCard extends StatelessWidget {
  final String title;
  final String address;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationOptionCard({
    super.key,
    required this.title,
    required this.address,
    required this.description,
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectionIndicator(isSelected: isSelected),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      address,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
