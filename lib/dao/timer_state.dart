import 'package:flutter/animation.dart';
import 'package:intl/intl.dart';
import 'package:productivity_timer/config/config.dart';

class TimerState {
     AnimationController controller;

     Stopwatch stopwatch;
     int timerDurationMsec;
     int timeRemainingMsec;
     TimerType timerType;

     TimerState() {
          this.stopwatch = new Stopwatch();
          this.timerType = Configuration.INITIAL_TIMER_TYPE;
          this.timerDurationMsec = getDurationByType(this.timerType);
          this.timeRemainingMsec = this.timerDurationMsec;
     }

     String getMinutes() {
          return new NumberFormat("00").format(getTimeRemainingInSeconds() ~/ 60);
     }

     String getSeconds() {
          return new NumberFormat("00").format(getTimeRemainingInSeconds() % 60);
     }

     int getTimeRemainingInSeconds() {
          return (timerDurationMsec - stopwatch.elapsedMilliseconds) ~/ 1000;
     }

     void changeTimerType(TimerType newType) {
          this.timerType = newType;
          this.timerDurationMsec = getDurationByType(this.timerType);
     }

     int getDurationByType(TimerType type) {
          return Configuration.TIMER_DURATIONS_MAP[type] * 60 * 1000;
     }
}
