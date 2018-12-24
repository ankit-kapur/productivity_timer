import 'package:flutter/material.dart';
import 'package:productivity_timer/config/config.dart';
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
            onPressed: () => resetButtonPressed(),
            elevation: 5.0,
            tooltip: 'Restart timer',
            child: Icon(Icons.refresh),
               /// Border on the button
               shape: CircleBorder(
                    side: BorderSide(
                         color: Colors.white,
                         width: 2),),
          ),
        ),

        new Container(
          padding: EdgeInsets.all(horizontalPadding),
          child: FloatingActionButton(
            onPressed: () => changeTimerType(),
            tooltip: 'Timer type',
            child: new ConstrainedBox(
                constraints: new BoxConstraints.expand(),
                child: new Image.asset(
                     getImagePathForTimerType(),
                     height: 10,
                     width: 10,
                ),
            ),
               /// Border on the button
               shape: CircleBorder(
                    side: BorderSide(
                         color: Colors.white,
                         width: 2),),
          ),
        ),

        new Container(
          padding: EdgeInsets.all(horizontalPadding),
          child: FloatingActionButton(
            onPressed: () => startStopButtonPressed(),
            tooltip: 'Start/Stop timer',
            child: timerState.controller.isAnimating
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),

               /// Border on the button
               shape: CircleBorder(
                    side: BorderSide(
                         color: Colors.white,
                    width: 2),),
          ),
        ),
      ],
    );
  }

  startStopButtonPressed() {
       if (timerState.controller.isAnimating)
            timerState.controller.stop();
       else {
            timerState.controller.reverse(
                 from: timerState.controller.value == 0.0
                      ? 1.0
                      : timerState.controller.value);
       }

    setState(() {
      if (timerState.stopwatch.isRunning) {
        timerState.stopwatch.stop();
      } else {
        timerState.stopwatch.start();
      }
    });

  }

  /// When the timer-type button is clicked
  // TODO: A panel should open up and allow the user to pick a type.
  changeTimerType() {
       setState(() {
            if (this.timerState.timerType == TimerType.pomodoro)
                 this.timerState.changeTimerType(TimerType.lime);
            else
                 this.timerState.changeTimerType(TimerType.pomodoro);
       });
  }

  String getImagePathForTimerType() {
       return "images/timer_" + getEnumValue(this.timerState.timerType) + ".png";
  }

  String getEnumValue(TimerType type) {
       return type.toString().substring(type.toString().indexOf(".") + 1);
  }

  resetButtonPressed() {
       timerState.stopwatch.reset();
       timerState.controller.reset();
  }
}
