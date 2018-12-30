import 'package:flutter/animation.dart';
import 'package:productivity_timer/config/config.dart';

class TimerState {
  AnimationController controller;

  Stopwatch stopwatch;
  int timeRemainingMsec;
  TimerType timerType;
  StatusOfTimer statusOfTimer;

  TimerState() {
    this.stopwatch = new Stopwatch();
    this.statusOfTimer = StatusOfTimer.STOPPED;
    this.timerType = Configuration.INITIAL_TIMER_TYPE;
  }

  void changeTimerType(TimerType newType) {
    this.timerType = newType;
    this.controller.duration = Duration(seconds: getDurationInSeconds());
  }

  int getDurationInSeconds() {
    return Configuration.TIMER_DURATIONS_MAP[this.timerType] * 60;
  }

  void resetState() {
    this.statusOfTimer = StatusOfTimer.STOPPED;
    this.stopwatch.reset();
    this.controller.reset();
  }
}

enum StatusOfTimer { PAUSED, RUNNING, STOPPED }
