import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/space_background.dart';
import '../widgets/rotating_dev_logo.dart';
import '../widgets/hexagon_button.dart';
import '../controls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text(
            'Menu',
            style: GoogleFonts.orbitron(color: Colors.white, fontSize: 24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Open Settings
                },
                child: Text(
                  'Settings',
                  style: GoogleFonts.orbitron(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Open Scores
                },
                child: Text(
                  'Scores',
                  style: GoogleFonts.orbitron(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // TODO: Open About
                },
                child: Text(
                  'About',
                  style: GoogleFonts.orbitron(color: Colors.white),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
                style: GoogleFonts.orbitron(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SpaceBubblesBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              const RotatingDevLogo(),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Space Snake',
                        style: GoogleFonts.audiowide(
                          fontSize: 48,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 0,
                              color: Colors.black,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: 200,
                        child: NeonGlassHexButton(
                          text: 'START',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GameController(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black87,
            onPressed: () => _showMenu(context),
            child: const Icon(Icons.menu, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
