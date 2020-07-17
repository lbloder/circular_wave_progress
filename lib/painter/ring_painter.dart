import 'dart:math';
import 'package:flutter/widgets.dart';

class RingPainter extends CustomPainter {
  RingPainter({this.angle = 45.0, double paintWidth, Color color, Color backgroundColor})
      : ringPaint = Paint()
    ..color = color
    ..strokeWidth = paintWidth
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round,
        backgroundPaint = Paint()
          ..color = backgroundColor
          ..strokeWidth = paintWidth
          ..style = PaintingStyle.stroke;

  final Paint ringPaint;
  final Paint backgroundPaint;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, backgroundPaint);
    canvas.drawArc(rect, 0.0, getRadian(angle), false, ringPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  double getRadian(double angle) => pi / 180 * angle;
}