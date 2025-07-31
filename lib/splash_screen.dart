import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;
import 'controls.dart'; // ✅ your game screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _creditController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _creditController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    Timer(const Duration(seconds: 2), () {
      _creditController.forward();
    });

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const GameController()),
      );
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _creditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ Solid background
          Container(color: Colors.black),

          // ✅ Centered logo + overlapping text
          Center(
            child: FadeTransition(
              opacity: _logoController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/snake_head_helmet.png',
                    width: 300,
                    height: 300,
                  ),

                  // Overlap by using negative margin
                  Transform.translate(
                    offset: const Offset(0, -30), // adjust overlap
                    child: Transform.rotate(
                      angle: -5 * math.pi / 180,
                      child: Stack(
                        children: [
                          Text(
                            'Space Snake',
                            style: TextStyle(
                              fontFamily: 'Audiowide',
                              fontSize: 36,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.white,
                            ),
                          ),
                          const Text(
                            'Space Snake',
                            style: TextStyle(
                              fontFamily: 'Audiowide',
                              fontSize: 36,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Bottom right credit
          Positioned(
            bottom: 20,
            right: 20,
            child: FadeTransition(
              opacity: _creditController,
              child: const Text(
                'A game by A-THIF',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
