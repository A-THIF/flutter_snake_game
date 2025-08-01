import 'dart:math';
import 'package:flutter/material.dart';

class SpaceBubblesBackground extends StatefulWidget {
  const SpaceBubblesBackground({super.key});

  @override
  State<SpaceBubblesBackground> createState() => _SpaceBubblesBackgroundState();
}

class _SpaceBubblesBackgroundState extends State<SpaceBubblesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<_Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    for (int i = 0; i < 50; i++) {
      _bubbles.add(
        _Bubble(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 4 + 1,
          speed: _random.nextDouble() * 0.002 + 0.0005,
          brightness: _random.nextDouble(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateBubbles();
        return CustomPaint(
          painter: _BubblesPainter(_bubbles),
          size: Size.infinite,
        );
      },
    );
  }

  void _updateBubbles() {
    for (final bubble in _bubbles) {
      bubble.y -= bubble.speed;
      if (bubble.y < 0) {
        bubble.y = 1.0;
        bubble.x = _random.nextDouble();
        bubble.radius = _random.nextDouble() * 4 + 1;
        bubble.speed = _random.nextDouble() * 0.002 + 0.0005;
        bubble.brightness = _random.nextDouble();
      }
    }
  }
}

class _Bubble {
  double x;
  double y;
  double radius;
  double speed;
  double brightness;

  _Bubble({
    required this.x,
    required this.y,
    required this.radius,
    required this.speed,
    required this.brightness,
  });
}

class _BubblesPainter extends CustomPainter {
  final List<_Bubble> bubbles;

  _BubblesPainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    for (final bubble in bubbles) {
      paint.color = Colors.white.withAlpha((bubble.brightness * 255).toInt());
      canvas.drawCircle(
        Offset(bubble.x * size.width, bubble.y * size.height),
        bubble.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
