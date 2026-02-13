import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class CustomBounce extends StatelessWidget {
  final dynamic widget;
  final VoidCallback pressed;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final Function(PointerHoverEvent)? onHover;
  const CustomBounce({
    super.key,
    required this.widget,
    required this.pressed,
    this.onEnter,
    this.onExit,
    this.onHover,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      onHover: onHover,
      cursor: SystemMouseCursors.click,
      child: Bounce(
        child: widget,
        duration: const Duration(milliseconds: 50),
        onPressed: pressed,
      ),
    );
  }
}
