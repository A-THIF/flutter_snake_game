import 'dart:ui';
import 'package:flutter/material.dart';
import 'food.dart';

class SnakePainter extends CustomPainter {
  final List<Offset> body;
  final Food apple;

  SnakePainter(this.body, this.apple);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.greenAccent;

    for (int i = 0; i < body.length; i++) {
      final progress = i / body.length;
      final radius = lerpDouble(16.0, 8.0, progress)!;
      final opacity = lerpDouble(1.0, 0.3, progress)!;
      paint.color = Colors.greenAccent.withAlpha((opacity * 255).toInt());
      canvas.drawCircle(body[i], radius, paint);
    }

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
