import 'package:flutter/widgets.dart';

void scrollToCenter({
  required ScrollController controller,
  required int index,
  required double itemWidth,
  required double itemSpacing,
  double listPadding = 0,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeOut,
}) {
  if (!controller.hasClients) return;

  final viewportWidth = controller.position.viewportDimension;
  final itemOffset = (index * (itemWidth + itemSpacing)) + listPadding;
  final targetOffset = itemOffset - (viewportWidth / 2) + (itemWidth / 2);

  controller.animateTo(
    targetOffset.clamp(
      controller.position.minScrollExtent,
      controller.position.maxScrollExtent,
    ),
    duration: duration,
    curve: curve,
  );
}
