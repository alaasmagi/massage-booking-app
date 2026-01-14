import 'package:flutter/material.dart';
import 'package:massage_booking_app/views/widgets/other/selection_indicator.dart';

class ServiceProviderOptionCard extends StatelessWidget {
  final String fullName;
  final String title;
  final int popularity;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceProviderOptionCard({
    super.key,
    required this.fullName,
    required this.title,
    required this.popularity,
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectionIndicator(isSelected: isSelected),
              const SizedBox(height: 24),

              Center(
                child: Column(
                  children: [
                    Text(
                      fullName,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$popularity/10',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
