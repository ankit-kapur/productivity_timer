import 'package:flutter/material.dart';
import 'package:productivity_timer/config/config.dart';
import 'package:productivity_timer/dao/timer_state.dart';

class BottomButtons1 extends StatefulWidget {
  double horizontalPadding;
  TimerState timer;

  BottomButtons1(double horizontalPadding, TimerState stopwatchState) {
    this.horizontalPadding = horizontalPadding;
    this.timer = stopwatchState;
  }

  @override
  _BottomButtons1State createState() =>
      new _BottomButtons1State(horizontalPadding, timer);
}

class _BottomButtons1State extends State<BottomButtons1> {
  double horizontalPadding;
  TimerState timerState;

  _BottomButtons1State(double horizontalPadding, TimerState timer) {
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
            width: 100,
            height: 100,
            padding: EdgeInsets.all(horizontalPadding),
            child: RawMaterialButton(
                 onPressed: () => resetButtonPressed(),
                 elevation: 5.0,
                 fillColor: Colors.deepPurple,
                 textStyle: TextStyle(
                      color: Colors.white,
                 ),
                 child: Icon(Icons.refresh),
                 /// Border on the button
                 shape: CircleBorder(
                      side: BorderSide(
                           color: Colors.white,
                           width: 3),),
            ),
       );

       /// Pause/play
       Widget pausePlayButton = new Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(horizontalPadding),
            child: FloatingActionButton(
                 highlightElevation: 10,
                 isExtended: true,
                 onPressed: () => playPauseButtonPressed(),
                 child: timerState.controller.isAnimating
                           ? Icon(Icons.pause)
                           : Icon(Icons.play_arrow),

                      /// Border on the button
                      shape: CircleBorder(
                           side: BorderSide(
                                color: Colors.white,
                                width: 3),),
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


class BottomButtons2 extends StatefulWidget {
     double horizontalPadding;
     TimerState timer;

     BottomButtons2(double horizontalPadding, TimerState stopwatchState) {
          this.horizontalPadding = horizontalPadding;
          this.timer = stopwatchState;
     }

     @override
     _BottomButtons2State createState() =>
          new _BottomButtons2State(horizontalPadding, timer);
}

class _BottomButtons2State extends State<BottomButtons2> {
     double horizontalPadding;
     TimerState timerState;

     _BottomButtons2State(double horizontalPadding, TimerState timer) {
          this.horizontalPadding = horizontalPadding;
          this.timerState = timer;
     }

     @override
     Widget build(BuildContext context) {
          return Container(
               child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                         /// Type of timer
                         new Container(
                              width: 100,
                              height: 100,
                              padding: EdgeInsets.all(horizontalPadding),

                              child: RawMaterialButton(
                                   onPressed: () => changeTimerType(),
                                   elevation: 5.0,
                                   fillColor: null, // Colors.white,
                                   textStyle: TextStyle(
                                        color: Colors.white,
                                   ),
                                   child: Text(
                                        Configuration.TIMER_EMOJI[this.timerState.timerType],
                                        style: TextStyle(
                                             fontSize: 30,
                                        ),
                                   ),
                                   /// Border on the button
                                   shape: CircleBorder(
                                        side: BorderSide(
                                             color: Colors.white,
                                             width: 3),
                                   ),
                              ),

//                              child: FloatingActionButton(
//                                   onPressed: () => changeTimerType(),
//                                   tooltip: 'Timer type',
//                                   child: new ConstrainedBox(
//                                        constraints: new BoxConstraints.expand(),
//                                        child: new Image.asset(
//                                             getImagePathForTimerType(),
//                                             height: 10,
//                                             width: 10,
//                                        ),
//                                   ),
//                                   /// Border on the button
//                                   shape: CircleBorder(
//                                        side: BorderSide(
//                                             color: Colors.white,
//                                             width: 2),),
//                              ),

                         ),

                    ],
               ),
          );
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

     String getEnumValue(TimerType type) {
          return type.toString().substring(type.toString().indexOf(".") + 1);
     }

}