import 'package:flutter/material.dart';
import 'snake_painter.dart';
import 'food.dart';
import 'dart:ui' as ui;

class SnakeGame extends StatelessWidget {
  final List<Offset> snake;
  final Food apple;
  final ui.Image headImage;
  final ui.Image bodyImage;
  final Offset direction; // ✅ ADD THIS

  const SnakeGame({
    super.key,
    required this.snake,
    required this.apple,
    required this.bodyImage,
    required this.headImage,
    required this.direction, // ✅ ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: CustomPaint(
          painter: SnakePainter(
            snake: snake,
            apple: apple,
            headImage: headImage,
            bodyImage: bodyImage,
            direction: direction, // ✅ FIXED!
          ),
        ),
      ),
    );
  }
}
