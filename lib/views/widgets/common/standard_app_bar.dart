import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:massage_booking_app/views/widgets/common/standard_icon_button.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const StandardAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      titleSpacing: 20,
      leadingWidth: onBackPressed != null ? 72 : null,
      leading: onBackPressed != null
          ? StandardIconButton(
              iconSize: 25,
              onPressed: onBackPressed,
              icon: FontAwesomeIcons.arrowLeft,
            )
          : null,
      title: Text(title),
      actionsPadding: const EdgeInsets.only(right: 16),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
