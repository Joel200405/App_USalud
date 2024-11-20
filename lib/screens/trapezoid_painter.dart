import 'package:flutter/material.dart';
import 'package:usalud_app/styles/colors.dart';

class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;
    final Path path = Path();

    // Nuevo diseño para que el trapezoide comience desde la parte superior
    path.moveTo(0, 0);  // Inicia desde la esquina superior izquierda
    path.lineTo(size.width, 0);  // Lado superior derecho
    path.lineTo(size.width, size.height * 0.5); // Lado inferior derecho (25% de la altura)
    path.lineTo(0, size.height * 1); // Lado inferior izquierdo (50% de la altura)
    path.close(); // Cierra el path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
