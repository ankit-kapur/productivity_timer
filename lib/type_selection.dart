import 'package:flutter/material.dart';
import 'package:productivity_timer/config/config.dart';
import 'package:productivity_timer/dao/timer_state.dart';

import 'package:productivity_timer/radial/flutter_radial_menu.dart';

class TypeSelection extends StatefulWidget {
  double horizontalPadding;
  TimerState timerState;

  TypeSelection(double horizontalPadding, TimerState stopwatchState) {
    this.horizontalPadding = horizontalPadding;
    this.timerState = stopwatchState;
  }

  @override
  _TypeSelectionState createState() =>
      new _TypeSelectionState(horizontalPadding, timerState);
}

class _TypeSelectionState extends State<TypeSelection> {
  double horizontalPadding;
  TimerState timerState;

  _TypeSelectionState(double horizontalPadding, TimerState timer) {
    this.horizontalPadding = horizontalPadding;
    this.timerState = timer;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          currentTypeButton(),
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

  currentTypeButton() {
    /// Current type
    return Stack(
      children: <Widget>[

//        /// TYPE button
//        Container(
//          width: 100,
//          height: 100,
//          padding: EdgeInsets.all(horizontalPadding),
//          child: RawMaterialButton(
//            onPressed: () => _timerTypeGlobalKey.currentState.reset(),
//
//            /// TODO remove: changeTimerType(),
//            elevation: 7.0,
//            fillColor: null,
//            // Colors.white,
//            textStyle: TextStyle(
//              color: Colors.white,
//            ),
//            child: Text(
//              Configuration.TIMER_EMOJI[this.timerState.timerType],
//              style: TextStyle(
//                fontSize: Configuration.TIMER_TYPE_EMOJI_SIZE,
//              ),
//            ),
//
//            /// Border on the button
//            shape: CircleBorder(
//              side: BorderSide(color: Colors.white, width: 3),
//            ),
//          ),
//        ),

        /// RADIAL MENU
        Container(
          height: Configuration.TIMER_TYPE_BUTTON_SIZE,
          width: Configuration.TIMER_TYPE_BUTTON_SIZE,
          child: new RadialMenu(
            key: _timerTypeGlobalKey,
            items: items,
            timerState: timerState,
            radius: 70.0,
            onSelected: _onItemSelected,
          ),
        ),

      ],
    );
  }

////////////

  GlobalKey<RadialMenuState> _timerTypeGlobalKey =
      new GlobalKey<RadialMenuState>();

  final List<RadialMenuItem<TimerType>> items = <RadialMenuItem<TimerType>>[
    new RadialMenuItem<TimerType>(
      value: TimerType.pomodoro,
      child: Text(
        Configuration.TIMER_EMOJI[TimerType.pomodoro],
        style: TextStyle(
          fontSize: Configuration.TIMER_TYPE_EMOJI_SIZE,
        ),
      ),
      iconColor: Colors.white,
      tooltip: TimerType.pomodoro.toString(),
    ),

    new RadialMenuItem<TimerType>(
      value: TimerType.lime,
      child: Text(
        Configuration.TIMER_EMOJI[TimerType.lime],
        style: TextStyle(
          fontSize: Configuration.TIMER_TYPE_EMOJI_SIZE,
        ),
      ),
      iconColor: Colors.white,
      backgroundColor: null,
      tooltip: TimerType.lime.toString(),
    ),

    new RadialMenuItem<TimerType>(
      value: TimerType.chilli,
      child: Text(
        Configuration.TIMER_EMOJI[TimerType.chilli],
        style: TextStyle(
          fontSize: Configuration.TIMER_TYPE_EMOJI_SIZE,
        ),
      ),
      iconColor: Colors.white,
      backgroundColor: null,
      tooltip: TimerType.chilli.toString(),
    ),

    new RadialMenuItem<TimerType>(
      value: TimerType.avocado,
      child: Text(
        Configuration.TIMER_EMOJI[TimerType.avocado],
        style: TextStyle(
          fontSize: Configuration.TIMER_TYPE_EMOJI_SIZE,
        ),
      ),
      iconColor: Colors.white,
      tooltip: TimerType.avocado.toString(),
    ),

    new RadialMenuItem<TimerType>(
      value: TimerType.carrot,
      child: Text(
        Configuration.TIMER_EMOJI[TimerType.carrot],
        style: TextStyle(
          fontSize: Configuration.TIMER_TYPE_EMOJI_SIZE,
        ),
      ),
      iconColor: Colors.white,
      tooltip: TimerType.carrot.toString(),
    ),

  ];

  void _onItemSelected(TimerType value) {
    this.timerState.changeTimerType(value);
  }
}
