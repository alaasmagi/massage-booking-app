import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String leftLabel;
  final String leftValue;
  final String? rightLabel;
  final String? rightValue;
  final String? bottomText;
  final bool showDivider;

  const InfoCard({
    super.key,
    required this.leftLabel,
    required this.leftValue,
    this.rightLabel,
    this.rightValue,
    this.bottomText,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Widget> children = [];

    children.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftLabel,
              style: theme.textTheme.titleMedium,
            ),
            Text(
              leftValue,
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              rightLabel ?? '',
              style: theme.textTheme.titleSmall,
            ),
            Text(
              rightValue ?? '',
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ],
    ));

    if (showDivider) {
      children.add(const SizedBox(height: 12));
      children.add(Container(
        height: 1,
        color: Colors.grey,
      ));
    }

    if (bottomText != null && bottomText!.isNotEmpty) {
      children.add(const SizedBox(height: 12));
      children.add(Text(
        bottomText!,
        style: theme.textTheme.bodyMedium,
      ));
    }

    return Card(
      elevation: 1,
      color: Colors.grey[50],
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
