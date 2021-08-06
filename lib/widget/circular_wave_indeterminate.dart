import 'dart:math';
import 'package:flutter/material.dart';
import '../painter/ring_painter.dart';
import 'circle_wave_animation.dart';

class CircleWaveProgress extends StatefulWidget {
  final double size;
  final Color backgroundColor;
  final Color foregroundWaveColor;
  final Color backgroundWaveColor;
  final Color borderColor;
  final double progress;

  CircleWaveProgress({
    this.size = 200.0,
    this.backgroundColor = Colors.blue,
    this.foregroundWaveColor = Colors.white,
    this.backgroundWaveColor = Colors.white,
    this.borderColor = Colors.white,
    double progress = 50.0
  }): progress = progress.clamp(0, 100).toDouble();

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<CircleWaveProgress> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));

    /// Only run the animation if the progress > 0. Since we don't need to draw the wave when progress = 0
    if (widget.progress > 0) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(color: widget.backgroundColor, shape: BoxShape.circle),
      child: Stack(
        alignment: Alignment.center,
        children: [
          FractionallySizedBox(
              widthFactor: 0.8,
              heightFactor: 0.8,
              child: CircleWaveAnimation(animationController: _animationController, foregroundWaveColor: widget.foregroundWaveColor, backgroundWaveColor: widget.backgroundWaveColor, progress: widget.progress)
            //CircleWaveAnimation(animationController: _animationController, foregroundWaveColor: widget.foregroundWaveColor, backgroundWaveColor: widget.backgroundWaveColor, progress: widget.progress),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              heightFactor: 0.9,
              child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, snapshot) {
                    return Transform(
                      transform: Matrix4.identity()..rotateZ((_animationController.value) * pi * 2),
                      alignment: FractionalOffset.center,
                      child: CustomPaint(
                        child: SizedBox.fromSize(size: Size.square(widget.size)),
                        painter: RingPainter(paintWidth: widget.size / 30, color: Colors.white, backgroundColor: widget.borderColor),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}