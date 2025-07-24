import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'food.dart';

class SnakePainter extends CustomPainter {
  final List<Offset> snake;
  final ui.Image headImage;
  final ui.Image bodyImage;
  final Food apple;

  SnakePainter({
    required this.snake,
    required this.headImage,
    required this.bodyImage,
    required this.apple,
  });

  final double segmentSize = 50.0; // bigger

  @override
  void paint(Canvas canvas, Size size) {
    // Body first
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

    // Head on top
    final head = snake.first;
    final headRect = Rect.fromCenter(
      center: head,
      width: segmentSize,
      height: segmentSize,
    );
    paintImage(
      canvas: canvas,
      rect: headRect,
      image: headImage,
      fit: BoxFit.contain,
    );

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
