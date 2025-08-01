import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonGlassHexButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const NeonGlassHexButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<NeonGlassHexButton> createState() => _NeonGlassHexButtonState();
}

class _NeonGlassHexButtonState extends State<NeonGlassHexButton> {
  bool _isPressed = false;

  void _updatePressed(bool isDown) {
    setState(() {
      _isPressed = isDown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 80, // Smaller hex
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipPath(
              clipper: _HexagonClipper(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha((0.1 * 255).round()),
                    border: Border.all(
                      color: Colors.white.withAlpha((0.25 * 255).round()),
                      width: 2, // Slightly thicker for all edges
                    ),
                  ),
                  child: _isPressed
                      ? Container(
                          color: const Color(0xFF00FFFF).withOpacity(0.3),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTapDown: (_) => _updatePressed(true),
            onTapUp: (_) {
              _updatePressed(false);
              widget.onPressed();
            },
            onTapCancel: () => _updatePressed(false),
            child: Text(
              widget.text,
              style: GoogleFonts.orbitron(
                fontSize: 28,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;
    final Path path = Path();
    path.moveTo(w * 0.25, 0);
    path.lineTo(w * 0.75, 0);
    path.lineTo(w, h / 2);
    path.lineTo(w * 0.75, h);
    path.lineTo(w * 0.25, h);
    path.lineTo(0, h / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
