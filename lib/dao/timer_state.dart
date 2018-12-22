import 'package:intl/intl.dart';

class TimerState {
  Stopwatch stopwatch;
  int timerDurationMsec;
  int timeRemainingMsec;

  TimerState(int initialTimeMsec) {
    this.timerDurationMsec = initialTimeMsec;
    this.timeRemainingMsec = initialTimeMsec;
    this.stopwatch = new Stopwatch();
  }

  String getMinutes() {
    return new NumberFormat("00").format(
         getTimeRemainingInSeconds() ~/ 60);
  }

  String getSeconds() {
    return new NumberFormat("00").format(
         getTimeRemainingInSeconds() % 60);
  }

  int getTimeRemainingInSeconds() {
    return (timerDurationMsec - stopwatch.elapsedMilliseconds) ~/ 1000;
  }
}
