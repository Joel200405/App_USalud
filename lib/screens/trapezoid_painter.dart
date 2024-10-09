import 'package:flutter/material.dart';
import 'package:usalud_app/styles/colors.dart';

class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;
    final Path path = Path();

    // Puntos del trapezoide
    path.moveTo(0, size.height); 
    path.lineTo(size.width, size.height);
    path.lineTo(
        size.width * 1, size.height * 0);
    path.lineTo(size.width * 0,
        size.height * 0.25);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
