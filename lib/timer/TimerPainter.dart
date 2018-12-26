import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:productivity_timer/config/config.dart';
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
               ..strokeWidth = Configuration.RING_WIDTH
               ..strokeCap = StrokeCap.round
               ..style = PaintingStyle.stroke;

          /// Default ring
          canvas.drawCircle(size.center(Offset.zero), Configuration.RING_RADIUS, paint);

          /// Progress ring
          paint.color = doneColor;
          double progress = (1.0 - animation.value) * 2 * math.pi;
          canvas.drawArc(
               Rect.fromCircle(
                    center: size.center(Offset.zero),
                    radius: Configuration.RING_RADIUS),
               math.pi * 1.5, -progress, false, paint);


          /// RING BORDERS
          Paint borderPaint = Paint()
               ..color = backgroundColor
               ..strokeWidth = Configuration.RING_BORDER_WIDTH
               ..strokeCap = StrokeCap.round
               ..style = PaintingStyle.stroke;

          /// Inner-border ring
          canvas.drawCircle(size.center(Offset.zero),
               Configuration.RING_RADIUS - Configuration.RING_BORDER_OFFSET - 2, borderPaint);

          /// Outer-border ring
          canvas.drawCircle(size.center(Offset.zero),
               Configuration.RING_RADIUS + Configuration.RING_WIDTH - Configuration.RING_BORDER_OFFSET - 2,
               borderPaint);

     }

     @override
     bool shouldRepaint(TimerPainter old) {
          return animation.value != old.animation.value ||
               doneColor != old.doneColor ||
               backgroundColor != old.backgroundColor;
     }
}