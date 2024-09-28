import 'dart:math';

import 'package:flutter/material.dart';

class OkuurCircularProgressBar extends StatefulWidget {
  final double size;
  final double percentage;
  final Color textColor;
  final Color inSideColor;
  final Color outSideColor;

  const OkuurCircularProgressBar({
    Key? key,
    required this.size,
    required this.percentage,
    required this.textColor,
    required this.inSideColor,
    required this.outSideColor,
  }) : super(key: key);

  @override
  CircularProgressBarState createState() => CircularProgressBarState();
}

class CircularProgressBarState extends State<OkuurCircularProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: widget.percentage).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircularProgressPainter(
              percentage: _animation.value,
              inSideColor: widget.inSideColor,
              outSideColor: widget.outSideColor,
            ),
            child: Center(
              child: Text(
                '${(_animation.value * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: widget.textColor),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color inSideColor;
  final Color outSideColor;

  _CircularProgressPainter({
    required this.percentage,
    required this.inSideColor,
    required this.outSideColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 10.0;
    double radius = (size.width / 2) - strokeWidth / 2;

    Paint backgroundPaint = Paint()
      ..color = inSideColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint progressPaint = Paint()
      ..color = outSideColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      radius,
      backgroundPaint,
    );

    double sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
