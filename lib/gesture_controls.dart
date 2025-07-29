import 'package:flutter/material.dart';

class GestureControls extends StatelessWidget {
  final Widget child;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const GestureControls({
    super.key,
    required this.child,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Left vertical strip
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: 80, // Adjust as needed
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onLeftTap,
            child: Container(color: Colors.transparent),
          ),
        ),
        // Right vertical strip
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          width: 80, // Adjust as needed
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onRightTap,
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}
