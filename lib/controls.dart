import 'dart:async';
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
  double speed = 0.1;
  int maxLength = 2;
  Timer? timer;
  late Food apple;
  Size? screenSize;
  bool _initialized = false;
  DateTime lastTurnTime = DateTime.now();
  final Duration turnCooldown = Duration.zero;

  @override
  void initState() {
    super.initState();
    snake.add(const Offset(200, 200));
    apple = Food(position: const Offset(300, 300));
    apple.loadImage('assets/icons8-apple-fruit-64.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;

    Size actualSize = MediaQuery.of(context).size;
    if (screenSize != actualSize) {
      screenSize = actualSize;
    }

    apple.relocate(screenSize!);
    _startGameLoop();
    _initialized = true;
  }

  void _startGameLoop() {
    timer = Timer.periodic(const Duration(milliseconds: 80), (_) {
      setState(() {
        final head = snake.first;
        Offset next = head + direction * 10;

        if (next.dx < 0) next = Offset(screenSize!.width, next.dy);
        if (next.dx > screenSize!.width) next = Offset(0, next.dy);
        if (next.dy < 0) next = Offset(next.dx, screenSize!.height);
        if (next.dy > screenSize!.height) next = Offset(next.dx, 0);

        // 💥 SELF COLLISION CHECK
        if (snake.contains(next)) {
          timer?.cancel();
          _showGameOverDialog();
          return;
        }

        if (apple.isEaten(next)) {
          maxLength += 1;
          apple.relocate(screenSize!);
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
              _resetGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      snake = [const Offset(200, 200)];
      direction = const Offset(1, 0);
      maxLength = 1;
      apple.relocate(screenSize!);
      _startGameLoop();
    });
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
    return GestureControls(
      onLeftTap: () => setState(() => rotate('left')),
      onRightTap: () => setState(() => rotate('right')),
      child: Stack(
        children: [
          // Game rendering
          SnakeGame(snake: snake, apple: apple),

          // Score Display
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
  }
}
