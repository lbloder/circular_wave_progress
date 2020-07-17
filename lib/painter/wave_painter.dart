import 'dart:math';
import 'package:flutter/widgets.dart';

class WaveWidgetPainter extends CustomPainter {
  Animation<double> animation;
  Color backgroundColor, waveColor;
  double progress;
  double offset;
  bool leftToRight;

  WaveWidgetPainter({this.animation, this.backgroundColor, this.waveColor, this.progress, this.offset = 0, this.leftToRight = true});

  @override
  void paint(Canvas canvas, Size size) {
    /// Draw background
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, backgroundPaint);

    /// Draw wave
    final wavePaint = Paint()..color = waveColor;
    final amp = size.height / 17;
    final p = progress / 100.0;
    final baseHeight = (1 - p) * size.height;

    final path = Path();

    path.moveTo(0.0, baseHeight);
    for (var i = 0.0; i < size.width; i++) {
      final animValue = leftToRight ? animation.value : 1 - animation.value;
      path.lineTo(i, baseHeight + sin((i / size.width * 2 * pi) + (animValue * 2 * pi) + offset) * amp);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}