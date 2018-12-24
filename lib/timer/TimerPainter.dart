import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:productivity_timer/dao/timer_state.dart';

class TimerPainter extends CustomPainter {
     TimerPainter({
          this.animation,
          this.backgroundColor,
          this.doneColor,
          this.timerState,
     }) : super(repaint: animation);

     final Animation<double> animation;
     final Color backgroundColor, doneColor;
     final TimerState timerState;

     @override
     void paint(Canvas canvas, Size size) {
          Paint paint = Paint()
               ..color = backgroundColor
               ..strokeWidth = 8.0
               ..strokeCap = StrokeCap.round
               ..style = PaintingStyle.stroke;

          canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
          paint.color = doneColor;
          double progress = (1.0 - animation.value) * 2 * math.pi;
          canvas.drawArc(
               // Offset.zero & size,
               Rect.fromCircle(
                    center: size.center(Offset.zero),
                    radius: size.width / 2.0),
               math.pi * 1.5, -progress, false, paint);
     }

     @override
     bool shouldRepaint(TimerPainter old) {
          return animation.value != old.animation.value ||
               doneColor != old.doneColor ||
               backgroundColor != old.backgroundColor;
     }
}