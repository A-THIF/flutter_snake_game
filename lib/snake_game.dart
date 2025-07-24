import 'package:flutter/material.dart';
import 'snake_painter.dart'; // For drawing logic
import 'food.dart';
import 'dart:ui' as ui;

class SnakeGame extends StatelessWidget {
  final List<Offset> snake;
  final Food apple;
  final ui.Image headImage;
  final ui.Image bodyImage;

  const SnakeGame({
    super.key,
    required this.snake,
    required this.apple,
    required this.bodyImage,
    required this.headImage,
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
          ),
        ),
      ),
    );
  }
}
