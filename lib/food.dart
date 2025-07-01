import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Food {
  Offset position;
  final double radius;
  ui.Image? image;

  Food({required this.position, this.radius = 16});

  void relocate(Size screenSize) {
    final rand = Random();
    final double x = rand.nextInt(screenSize.width.toInt() - 20).toDouble();
    final double y = rand.nextInt(screenSize.height.toInt() - 20).toDouble();
    position = Offset(x, y);
  }

  Future<void> loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    image = frame.image;
  }

  bool isEaten(Offset snakeHead) {
    return (snakeHead - position).distance < radius;
  }
}
