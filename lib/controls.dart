import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'snake_game.dart';
import 'food.dart';
import 'gesture_controls.dart';

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

        if (next.dx < 0) {
          next = Offset(size.width, next.dy);
        }
        if (next.dx > size.width) {
          next = Offset(0, next.dy);
        }
        if (next.dy < 0) {
          next = Offset(next.dx, size.height);
        }
        if (next.dy > size.height) {
          next = Offset(next.dx, 0);
        }

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
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    ).then((_) {
      _resetGame();
    });
  }

  void _resetGame() {
    setState(() {
      snake = [const Offset(200, 200)];
      direction = const Offset(1, 0);
      maxLength = 2;
    });
    if (lastSize != null) {
      _startGameLoop(lastSize!);
    }
  }

  void rotate(String input) {
    Offset newDirection = direction;

    switch (input) {
      case 'up':
        newDirection = const Offset(0, -1);
        break;
      case 'down':
        newDirection = const Offset(0, 1);
        break;
      case 'left':
        newDirection = const Offset(-1, 0);
        break;
      case 'right':
        newDirection = const Offset(1, 0);
        break;
    }

    // Reject if input is same direction
    if (direction == newDirection) return;

    // Reject if input is direct opposite
    if ((direction.dx + newDirection.dx == 0 &&
        direction.dy + newDirection.dy == 0)) {
      return;
    }

    setState(() {
      direction = newDirection;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (!imagesLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (lastSize == null) {
      lastSize = screenSize;
      _startGameLoop(screenSize);
    }

    return GestureControls(
      child: Stack(
        children: [
          SnakeGame(
            snake: snake,
            apple: apple,
            headImage: headImage!,
            bodyImage: bodyImage!,
            direction: direction,
          ),
          Positioned(
            top: 20,
            left: screenSize.width / 2 - 50,
            child: Stack(
              children: [
                // Outline stroke
                // Outline stroke
                Text(
                  'Score: ${snake.length - 1}',
                  style: TextStyle(
                    // ⬅️ REMOVE const here!
                    fontFamily: 'Audiowide',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.black,
                  ),
                ),
                // Fill stays const:
                Text(
                  'Score: ${snake.length - 1}',
                  style: const TextStyle(
                    fontFamily: 'Audiowide',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onLeftTap: () => rotate('left'),
      onRightTap: () => rotate('right'),
      onUpTap: () => rotate('up'),
      onDownTap: () => rotate('down'),
    );
  }
}
