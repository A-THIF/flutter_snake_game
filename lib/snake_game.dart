import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'snake_painter.dart'; // For drawing logic
import 'food.dart';

class SnakeGame extends StatelessWidget {
  final List<Offset> snake;
  final Food apple;

  const SnakeGame({super.key, required this.snake, required this.apple});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: CustomPaint(painter: SnakePainter(snake, apple)),
      ),
    );
  }
}
