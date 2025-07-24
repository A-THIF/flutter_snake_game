import 'dart:async';
import 'dart:ui' as ui; // ✅ for ui.Image
import 'package:flutter/services.dart'; // ✅ for rootBundle
import 'package:flutter/material.dart';
import 'snake_game.dart';
import 'gesture_controls.dart';
import 'food.dart';

class GameController extends StatefulWidget {
  const GameController({super.key});

  @override
  State<GameController> createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> {
  List<Offset> snake = [];
  Offset direction = const Offset(1, 0);
  int maxLength = 2;
  Timer? timer;
  late Food apple;
  Size? lastSize;
  DateTime lastTurnTime = DateTime.now();
  final Duration turnCooldown = Duration.zero;
  ui.Image? headImage;
  ui.Image? bodyImage;
  bool imagesLoaded = false;

  @override
  void initState() {
    super.initState();
    snake.add(const Offset(200, 200));
    apple = Food(position: const Offset(300, 300));
    apple.loadImage('assets/icons8-apple-fruit-64.png');
    _loadImages();
  }

  Future<void> _loadImages() async {
    final headData = await rootBundle.load('assets/snake_head_helmet.png');
    final bodyData = await rootBundle.load('assets/snake_body.png');

    final headCodec = await ui.instantiateImageCodec(
      headData.buffer.asUint8List(),
    );
    final bodyCodec = await ui.instantiateImageCodec(
      bodyData.buffer.asUint8List(),
    );

    final headFrame = await headCodec.getNextFrame();
    final bodyFrame = await bodyCodec.getNextFrame();

    setState(() {
      headImage = headFrame.image;
      bodyImage = bodyFrame.image;
      imagesLoaded = true;
    });
  }

  void _startGameLoop(Size size) {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      setState(() {
        final head = snake.first;
        Offset next = head + direction * 15;

        if (next.dx < 0) next = Offset(size.width, next.dy);
        if (next.dx > size.width) next = Offset(0, next.dy);
        if (next.dy < 0) next = Offset(next.dx, size.height);
        if (next.dy > size.height) next = Offset(next.dx, 0);

        // Self-collision check
        if (snake.contains(next)) {
          timer?.cancel();
          _showGameOverDialog();
          return;
        }

        if (apple.isEaten(next)) {
          maxLength += 1;
          apple.relocate(size);
        }

        snake.insert(0, next);
        if (snake.length > maxLength) {
          snake.removeLast();
        }
      });
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Your score: ${snake.length - 1}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // _resetGame(); // Remove from here
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    ).then((_) {
      _resetGame(); // This runs regardless of how the dialog was closed
    });
  }

  void _resetGame() {
    setState(() {
      snake = [const Offset(200, 200)];
      direction = const Offset(1, 0);
      maxLength = 2;
      // apple will be relocated on next layout tick
    });
    if (lastSize != null) {
      _startGameLoop(lastSize!);
    }
  }

  void rotate(String side) {
    final now = DateTime.now();
    if (now.difference(lastTurnTime) < turnCooldown) return;
    lastTurnTime = now;

    final isLeft = side == 'left';
    Offset newDirection;

    if (direction == const Offset(1, 0)) {
      newDirection = isLeft ? const Offset(0, -1) : const Offset(0, 1);
    } else if (direction == const Offset(-1, 0)) {
      newDirection = isLeft ? const Offset(0, 1) : const Offset(0, -1);
    } else if (direction == const Offset(0, 1)) {
      newDirection = isLeft ? const Offset(1, 0) : const Offset(-1, 0);
    } else {
      newDirection = isLeft ? const Offset(-1, 0) : const Offset(1, 0);
    }

    if ((direction.dx + newDirection.dx != 0) ||
        (direction.dy + newDirection.dy != 0)) {
      direction = newDirection;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = Size(constraints.maxWidth, constraints.maxHeight);

        // Only start/reset loop if size changes
        if (lastSize == null || lastSize != size) {
          lastSize = size;
          apple.relocate(size);
          _startGameLoop(size);
        }

        if (!imagesLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return GestureControls(
          onLeftTap: () => setState(() => rotate('left')),
          onRightTap: () => setState(() => rotate('right')),
          child: Stack(
            children: [
              SnakeGame(
                snake: snake,
                apple: apple,
                headImage: headImage!,
                bodyImage: bodyImage!,
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  'Score: ${snake.length - 1}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }, // ✅ closes the builder
    ); // ✅ closes LayoutBuilder
  } // ✅ closes build
}
