import 'package:flutter/material.dart';
import 'package:productivity_timer/dao/timer_state.dart';

class BottomPanel extends StatefulWidget {
  double horizontalPadding;
  TimerState timer;

  BottomPanel(double horizontalPadding, TimerState stopwatchState) {
    this.horizontalPadding = horizontalPadding;
    this.timer = stopwatchState;
  }

  @override
  _BottomPanelState createState() =>
      new _BottomPanelState(horizontalPadding, timer);
}

class _BottomPanelState extends State<BottomPanel> {
  double horizontalPadding;
  TimerState timerState;

  _BottomPanelState(double horizontalPadding, TimerState timer) {
    this.horizontalPadding = horizontalPadding;
    this.timerState = timer;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(horizontalPadding),
          child: FloatingActionButton(
            onPressed: () => startStopButtonPressed(),
            tooltip: 'Start/Stop timer',
            child: timerState.stopwatch.isRunning
                 ? Icon(Icons.pause)
                 : Icon(Icons.play_arrow),
          ),
        ),
        new Container(
          padding: EdgeInsets.all(horizontalPadding),
          child: FloatingActionButton(
            onPressed: () => timerState.stopwatch.reset(),
            tooltip: 'Restart timer',
            child: Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }

  startStopButtonPressed() {
    setState(() {
      if (timerState.stopwatch.isRunning) {
        timerState.stopwatch.stop();
      } else {
        timerState.stopwatch.start();
      }
    });
  }
}
