import 'package:flutter/material.dart';

class Configuration {

     static const double BUTTON_HORIZ_PADDING = 20.0;
     static const TimerType INITIAL_TIMER_TYPE = TimerType.pomodoro;
     static const int TIMER_REFRESH_RATE_MSEC = 1000;

     /// Timer
     static const TIMER_COLOR = Colors.white;
     static const double TIMER_FONT_SIZE = 95;
     static const double BORDER_WIDTH_TIMER = 0.0;
     static const BORDER_COLOR_TIMER = Colors.white;


     /// Key = image suffix
     /// Value = Duration in minutes
     static const TIMER_DURATIONS_MAP = {
          TimerType.chilli : 10,
          TimerType.lime : 15,
          TimerType.pomodoro : 25,
          TimerType.watermelon : 45,
     };
}

enum TimerType {
     pomodoro, chilli, lime, watermelon, carrot
}