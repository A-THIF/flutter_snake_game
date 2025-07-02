import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

final Random random = Random();

class Food {
  Offset position;
  final double radius;
  ui.Image? image;

  Food({required this.position, this.radius = 16});

  void relocate(Size screenSize) {
    const double margin =
        60.0; // avoid edges (left/right) and top/bottom controls
    final double x =
        margin + (screenSize.width - 2 * margin) * (random.nextDouble());
    final double y =
        margin + (screenSize.height - 2 * margin) * (random.nextDouble());
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
