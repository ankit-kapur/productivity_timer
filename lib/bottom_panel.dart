import 'package:flutter/material.dart';
import 'package:productivity_timer/config/config.dart';
import 'package:productivity_timer/dao/timer_state.dart';

class ControlButtons extends StatefulWidget {
  double horizontalPadding;
  TimerState timer;

  ControlButtons(double horizontalPadding, TimerState stopwatchState) {
    this.horizontalPadding = horizontalPadding;
    this.timer = stopwatchState;
  }

  @override
  _ControlButtonsState createState() =>
      new _ControlButtonsState(horizontalPadding, timer);
}

class _ControlButtonsState extends State<ControlButtons> {
  double horizontalPadding;
  TimerState timerState;

  _ControlButtonsState(double horizontalPadding, TimerState timer) {
    this.horizontalPadding = horizontalPadding;
    this.timerState = timer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: makeActionButtons(),
      ),
    );
  }

  List<Widget> makeActionButtons() {
    List<Widget> buttonList = <Widget>[];

    /// Reset
    Widget resetButton = new Container(
      width: Configuration.CONTROL_BUTTON_SIZE,
      height: Configuration.CONTROL_BUTTON_SIZE,
      padding: EdgeInsets.all(horizontalPadding),
      child: RawMaterialButton(
        onPressed: () => resetButtonPressed(),
        elevation: 5.0,
        fillColor: Colors.deepPurple,
        textStyle: TextStyle(
          color: Colors.white,
        ),
        child: Icon(
          Icons.refresh,
          size: Configuration.CONTROL_BUTTON_FONT_SIZE,
        ),

        /// Border on the button
        shape: CircleBorder(
          side: BorderSide(color: Colors.white, width: 3),
        ),
      ),
    );

    /// Pause/play
    Widget pausePlayButton = new Container(
      width: Configuration.CONTROL_BUTTON_SIZE,
      height: Configuration.CONTROL_BUTTON_SIZE,
      padding: EdgeInsets.all(horizontalPadding),
      child: FloatingActionButton(
        highlightElevation: 10,
        isExtended: true,
        onPressed: () => playPauseButtonPressed(),
        child: timerState.controller.isAnimating
            ? Icon(
                Icons.pause,
                size: Configuration.CONTROL_BUTTON_FONT_SIZE,
              )
            : Icon(
                Icons.play_arrow,
                size: Configuration.CONTROL_BUTTON_FONT_SIZE,
              ),

        /// Border on the button
        shape: CircleBorder(
          side: BorderSide(color: Colors.white, width: 3),
        ),
      ),
    );

    setState(() {
      if (timerState.statusOfTimer == StatusOfTimer.PAUSED) {
        buttonList.add(resetButton);
      }
      buttonList.add(pausePlayButton);
    });

    return buttonList;
  }

  playPauseButtonPressed() {
    if (timerState.controller.isAnimating) {
      timerState.controller.stop();
      timerState.statusOfTimer = StatusOfTimer.PAUSED;
    } else {
      timerState.statusOfTimer = StatusOfTimer.RUNNING;
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

  resetButtonPressed() {
    setState(() {
      timerState.statusOfTimer = StatusOfTimer.STOPPED;
      timerState.stopwatch.reset();
      timerState.controller.reset();
    });
  }
}
