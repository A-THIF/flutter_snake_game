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
        Positioned.fill(
          child: Row(
            children: [
              // LEFT TAP
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onLeftTap,
                  child: Container(),
                ),
              ),
              // RIGHT TAP
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onRightTap,
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
