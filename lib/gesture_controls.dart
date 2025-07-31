import 'package:flutter/material.dart';

class GestureControls extends StatefulWidget {
  final Widget child;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;
  final VoidCallback onUpTap;
  final VoidCallback onDownTap;

  const GestureControls({
    super.key,
    required this.child,
    required this.onLeftTap,
    required this.onRightTap,
    required this.onUpTap,
    required this.onDownTap,
  });

  @override
  State<GestureControls> createState() => _GestureControlsState();
}

class _GestureControlsState extends State<GestureControls> {
  double leftOpacity = 0.3;
  double rightOpacity = 0.3;
  double upOpacity = 0.3;
  double downOpacity = 0.3;

  void handleTap(String direction, VoidCallback callback) {
    callback();
    setState(() {
      switch (direction) {
        case 'left':
          leftOpacity = 1.0;
          break;
        case 'right':
          rightOpacity = 1.0;
          break;
        case 'up':
          upOpacity = 1.0;
          break;
        case 'down':
          downOpacity = 1.0;
          break;
      }
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          switch (direction) {
            case 'left':
              leftOpacity = 0.3;
              break;
            case 'right':
              rightOpacity = 0.3;
              break;
            case 'up':
              upOpacity = 0.3;
              break;
            case 'down':
              downOpacity = 0.3;
              break;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final stripWidth = screenSize.width * 0.2;

    return Stack(
      children: [
        widget.child,

        // ✅ LEFT STRIP: Up + Down (closer)
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: stripWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => handleTap('up', widget.onUpTap),
                child: Opacity(
                  opacity: upOpacity,
                  child: const Icon(
                    Icons.arrow_drop_up,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20), // smaller spacing than before
              GestureDetector(
                onTap: () => handleTap('down', widget.onDownTap),
                child: Opacity(
                  opacity: downOpacity,
                  child: const Icon(
                    Icons.arrow_drop_down,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ✅ RIGHT STRIP: Left + Right side by side
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: stripWidth,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => handleTap('left', widget.onLeftTap),
                  child: Opacity(
                    opacity: leftOpacity,
                    child: const Icon(
                      Icons.arrow_left,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // space between left & right
                GestureDetector(
                  onTap: () => handleTap('right', widget.onRightTap),
                  child: Opacity(
                    opacity: rightOpacity,
                    child: const Icon(
                      Icons.arrow_right,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
