import 'dart:math';
import 'package:flutter/material.dart';
import '../painter/ring_painter.dart';
import 'circle_wave_animation.dart';

class CircleWaveProgressConcrete extends StatefulWidget {
  final double size;
  final Color backgroundColor;
  final Color foregroundWaveColor;
  final Color backgroundWaveColor;
  final Color borderColor;
  final double progress;

  CircleWaveProgressConcrete({
    this.size = 200.0,
    this.backgroundColor = Colors.blue,
    this.foregroundWaveColor = Colors.white,
    this.backgroundWaveColor = Colors.white,
    this.borderColor = Colors.white,
    double progress = 50.0
  }): progress = progress.clamp(0, 100).toDouble();

  @override
  _CircleWaveConcreteProgressState createState() => _CircleWaveConcreteProgressState();
}

class _CircleWaveConcreteProgressState extends State<CircleWaveProgressConcrete> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _animationController.repeat();
    /// Only run the animation if the progress > 0. Since we don't need to draw the wave when progress = 0
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
              child: TweenAnimationBuilder<double> (
                  tween: Tween(begin: 0, end: widget.progress),
                  duration: Duration(milliseconds: 500),
                  builder: (context, value, snapshot) {
                    return CircleWaveAnimation(animationController: _animationController, foregroundWaveColor: widget.foregroundWaveColor, backgroundWaveColor: widget.backgroundWaveColor, progress: value);
                  }
              )
            //CircleWaveAnimation(animationController: _animationController, foregroundWaveColor: widget.foregroundWaveColor, backgroundWaveColor: widget.backgroundWaveColor, progress: widget.progress),
          ),
          Center(
            child: FractionallySizedBox(
                widthFactor: 0.9,
                heightFactor: 0.9,
                child: Transform(
                  transform: Matrix4.identity()..rotateZ(-pi/2),
                  alignment: FractionalOffset.center,
                  child: TweenAnimationBuilder<double> (
                      tween: Tween(begin: 0, end: widget.progress),
                      duration: Duration(milliseconds: 500),
                      builder: (context, value, snapshot) {
                        return CustomPaint(
                          child: SizedBox.fromSize(size: Size.square(widget.size)),
                          painter: RingPainter(angle: 360/100*value, paintWidth: widget.size / 30, color: Colors.white, backgroundColor: widget.borderColor),
                        );
                      }
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}