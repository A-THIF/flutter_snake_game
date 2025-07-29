import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'food.dart';
import 'dart:math'; // Needed for pi

class SnakePainter extends CustomPainter {
  final List<Offset> snake;
  final ui.Image headImage;
  final ui.Image bodyImage;
  final Food apple;
  final Offset direction; // NEW!

  SnakePainter({
    required this.snake,
    required this.headImage,
    required this.bodyImage,
    required this.apple,
    required this.direction, // NEW!
  });

  final double segmentSize = 50.0; // bigger

  @override
  void paint(Canvas canvas, Size size) {
    // Draw body segments (skip head)
    for (int i = 1; i < snake.length; i++) {
      final segment = snake[i];
      final rect = Rect.fromCenter(
        center: segment,
        width: segmentSize,
        height: segmentSize,
      );
      paintImage(
        canvas: canvas,
        rect: rect,
        image: bodyImage,
        fit: BoxFit.contain,
      );
    }

    // Draw rotated head on top
    final head = snake.first;

    // Determine angle in radians
    double angle = 0.0;
    if (direction == const Offset(0, -1)) {
      angle = 0; // Up
    } else if (direction == const Offset(1, 0)) {
      angle = pi / 2; // Right
    } else if (direction == const Offset(0, 1)) {
      angle = pi; // Down
    } else if (direction == const Offset(-1, 0)) {
      angle = -pi / 2; // Left
    }

    // Save, translate, rotate, draw, restore
    canvas.save();
    canvas.translate(head.dx, head.dy);
    canvas.rotate(angle);

    final headRect = Rect.fromCenter(
      center: Offset.zero, // IMPORTANT when rotated
      width: segmentSize,
      height: segmentSize,
    );
    paintImage(
      canvas: canvas,
      rect: headRect,
      image: headImage,
      fit: BoxFit.contain,
    );

    canvas.restore();

    // Draw glowing apple
    if (apple.image != null) {
      final imageSize = apple.radius * 2;
      final rect = Rect.fromCenter(
        center: apple.position,
        width: imageSize,
        height: imageSize,
      );

      final glowPaint = Paint()
        ..color = Colors.white.withAlpha((0.7 * 255).toInt())
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(apple.position, apple.radius * 1.6, glowPaint);

      paintImage(
        canvas: canvas,
        rect: rect,
        image: apple.image!,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
