import 'dart:math';
import 'package:flutter/material.dart';

class FlowingFood {
  Offset position;
  Offset velocity;
  final double radius;

  FlowingFood({required this.position, this.radius = 16})
    : velocity = Offset(
        Random().nextDouble() * 4 - 2,
        Random().nextDouble() * 4 - 2,
      );

  void updatePosition(Size screenSize) {
    position += velocity;

    if (position.dx < 0 || position.dx > screenSize.width) {
      velocity = Offset(-velocity.dx, velocity.dy);
    }
    if (position.dy < 0 || position.dy > screenSize.height) {
      velocity = Offset(velocity.dx, -velocity.dy);
    }
  }

  bool isEaten(Offset snakeHead) {
    return (snakeHead - position).distance < radius;
  }
}
