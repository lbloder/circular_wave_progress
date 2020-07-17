import 'package:flutter/material.dart';
import '../painter/wave_painter.dart';

class CircleWaveAnimation extends StatelessWidget {
  const CircleWaveAnimation({
    Key key,
    @required AnimationController animationController,
    this.foregroundWaveColor = Colors.white,
    this.backgroundWaveColor = Colors.white,
    this.progress = 50.0,
  }) : _animationController = animationController, super(key: key);

  final AnimationController _animationController;

  final Color foregroundWaveColor;
  final Color backgroundWaveColor;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CircleClipper(),
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: WaveWidgetPainter(leftToRight: false, animation: _animationController, backgroundColor: Colors.transparent, waveColor: backgroundWaveColor, progress: progress),
                ),
                CustomPaint(
                  painter: WaveWidgetPainter(leftToRight: true, offset: 3.2, animation: _animationController, backgroundColor: Colors.transparent, waveColor: foregroundWaveColor, progress: progress),
                ),
              ],
            );
          }
      ),
    );
  }
}