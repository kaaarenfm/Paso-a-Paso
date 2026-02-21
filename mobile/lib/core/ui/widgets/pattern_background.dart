import 'package:flutter/material.dart';

class PatternBackground extends StatelessWidget {
  final Color color;
  final double opacity;

  const PatternBackground({
    super.key,
    this.color = Colors.white,
    this.opacity = 0.05,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PatternPainter(color: color, opacity: opacity),
    );
  }
}

class _PatternPainter extends CustomPainter {
  final Color color;
  final double opacity;

  _PatternPainter({required this.color, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..strokeWidth = 1.0;

    const double spacing = 20.0;

    // Dibujar líneas diagonales suaves
    for (double i = -size.height; i < size.width; i += spacing) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
