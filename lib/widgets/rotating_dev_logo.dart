import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class RotatingDevLogo extends StatefulWidget {
  const RotatingDevLogo({super.key});

  @override
  State<RotatingDevLogo> createState() => _RotatingDevLogoState();
}

class _RotatingDevLogoState extends State<RotatingDevLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  ui.Image? logoImage;
  String? currentMessage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _loadImage();
  }

  Future<void> _loadImage() async {
    final data = await rootBundle.load('assets/snake_head_helmet.png');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      logoImage = frame.image;
    });
  }

  void _showDevMessage() {
    final messages = [
      "Secret unlocked! 🚀 Keep reaching for the stars.",
      "Hey! I’m Athif, your student dev. Enjoy Space Snake!",
      "Did you know? The snake’s helmet is inspired by space suits!",
      "Tip: Longer snake = higher score! 🐍",
      "Built with 💙, Flutter & late-night snacks.",
    ];
    final random = (messages..shuffle()).first;

    setState(() {
      currentMessage = random;
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          currentMessage = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (logoImage == null) return const SizedBox.shrink();

    return Stack(
      children: [
        Positioned(
          top: 30,
          left: 30,
          child: GestureDetector(
            onTap: _showDevMessage,
            child: SizedBox(
              width: 50,
              height: 50,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: CustomPaint(painter: _ImagePainter(logoImage!)),
                  );
                },
              ),
            ),
          ),
        ),
        if (currentMessage != null)
          Positioned(
            top: 90,
            left: 30,
            child: Container(
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                currentMessage!,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}

class _ImagePainter extends CustomPainter {
  final ui.Image image;

  _ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _ImagePainter oldDelegate) =>
      oldDelegate.image != image;
}
