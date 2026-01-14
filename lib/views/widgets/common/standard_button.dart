import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StandardButton extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool filled;

  const StandardButton({
    super.key,
    required this.height,
    required this.width,
    required this.label,
    this.icon,
    this.onPressed,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(width, height)),
    );

    final iconWidget = icon != null ? FaIcon(icon) : null;
    final labelWidget = Text(label);

    if (filled) {
      return iconWidget != null ?
        FilledButton.icon(
          onPressed: onPressed,
          icon: iconWidget,
          label: labelWidget,
          style: style,
        ) :
        FilledButton(
          onPressed: onPressed,
          style: style,
          child: labelWidget,
        );
    }

    return iconWidget != null ?
      OutlinedButton.icon(
        onPressed: onPressed,
        icon: iconWidget,
        label: labelWidget,
        style: style,
      ) :
      OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: labelWidget,
    );
  }
}
