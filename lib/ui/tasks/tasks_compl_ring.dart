import 'dart:math';

import 'package:flutter/material.dart';

import '../theming/app_theme.dart';

class TasksCompRing extends StatelessWidget {
  final double progress;
  const TasksCompRing({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = AppTheme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: RingsPainter(
          progress: progress,
          taskNotCompColor: themeData.taskRing,
          taskCompColor: themeData.accent,
        ),
      ),
    );
  }
}

class RingsPainter extends CustomPainter{
  RingsPainter({required this.progress, required this.taskNotCompColor, required this.taskCompColor});
  final double progress;
  final Color taskNotCompColor;
  final Color taskCompColor;

  @override
  void paint(Canvas canvas, Size size) {
    final hasCompleted = progress < 1.0;
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2.0, size.height / 2.0);
    final radius = hasCompleted ? (size.width - strokeWidth) / 2.0 : size.width / 2.0;

    if(hasCompleted){
      final paint = Paint()
        ..isAntiAlias = true
        ..color = taskNotCompColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, paint);
    }



    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..color = taskCompColor
      ..strokeWidth = strokeWidth
      ..style = hasCompleted ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi/2,
      2 * pi * progress,
      false,
      foregroundPaint
    );


  }











  @override
  bool shouldRepaint(covariant RingsPainter oldDelegate) => oldDelegate.progress != progress;
  
}
