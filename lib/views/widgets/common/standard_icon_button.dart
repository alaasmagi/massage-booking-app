import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StandardIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;
  final double iconSize;

  const StandardIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.filled = false,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      iconSize: iconSize,
      style: IconButton.styleFrom(
        minimumSize: const Size(48, 48),
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPressed,
      icon: FaIcon(icon),
    );

    if (filled) {
      return IconButton.filledTonal(
        iconSize: iconSize,
        style: IconButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.all(12),
        ),
        onPressed: onPressed,
        icon: FaIcon(icon),
      );
    }

    return button;
  }
}
