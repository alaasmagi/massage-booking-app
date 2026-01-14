import 'package:flutter/material.dart';

class SelectionIndicator extends StatelessWidget {
  final bool isSelected;

  const SelectionIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 3,
        ),
      ),
      child: isSelected
          ? Center(
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary,
          ),
        ),
      )
          : null,
    );
  }
}
