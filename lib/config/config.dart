import 'package:flutter/material.dart';

class Configuration {

     static const double BUTTON_HORIZ_PADDING = 20.0;
     static const TimerType INITIAL_TIMER_TYPE = TimerType.pomodoro;
     static const int TIMER_REFRESH_RATE_MSEC = 1000;

     /// Timer text
     static const TIMER_COLOR = Colors.white;
     static const double TIMER_FONT_SIZE = 75;
     static const double BORDER_WIDTH_TIMER = 2.0;
     static const BORDER_COLOR_TIMER = Colors.black;

     /// Ring
     static const RING_WIDTH = 11.0;
     static const RING_RADIUS = 125.0;
     static const RING_BORDER_OFFSET = 3.3;
     static const RING_BORDER_WIDTH = 1.3;

     /// Buttons
     static const double CONTROL_BUTTON_SIZE = 110;
     static const double CONTROL_BUTTON_FONT_SIZE = 32;

     /// Timer TYPES
     static const double TIMER_TYPE_EMOJI_SIZE = 25;
     static const double TIMER_TYPE_BUTTON_SIZE = 160;

     /// Radial menu
     static const RADIAL_MENU_RADIUS = 100.0;
     static const int RADIAL_MENU_ANIMATION_DURATION_MSEC = 600;
     static const int RADIAL_MENU_SELECTION_RING_DURATION_MSEC = 200;

     static const TIMER_DURATIONS_MAP = {
          TimerType.chilli : 1,
          TimerType.carrot : 10,
          TimerType.lime : 15,
          TimerType.pomodoro : 25,
          TimerType.avocado : 45,
     };
     static const TIMER_EMOJI = {
          TimerType.pomodoro : '🍅',
          TimerType.lime : '🍋',
          TimerType.chilli : '🌶',
          TimerType.avocado : '🥑',
          TimerType.carrot : '🥕',
     };

     static timerThemeData() {
          return ThemeData(

               canvasColor: Colors.white,

               /// Top panel
               primarySwatch: MaterialColor(0xFF005c3f,
               <int, Color>{
                    50: Color(0xFFF1F8E9),
                    100: Color(0xFFDCEDC8),
                    200: Color(0xFFC5E1A5),
                    300: Color(0xFFAED581),
                    400: Color(0xFF9CCC65),
                    500: Color(0xFF8BC34A),
                    600: Color(0xFF7CB342),
                    700: Color(0xFF689F38),
                    800: Color(0xFF558B2F),
                    900: Color(0xFF33691E),
               }),

               /// Timer RING
               indicatorColor: Colors.green[800],

               // Buttons
               buttonTheme: ButtonThemeData(
                    textTheme: ButtonTextTheme.primary,
               ),
               buttonColor: Color(0xAF00332a),
               accentColor: Colors.green,
               backgroundColor: Colors.deepPurple,

               /// Bottom bar
               bottomAppBarColor: Color(0xBF005c3f),

               textTheme: TextTheme(

                    /// Timer text-color
                    display1: TextStyle(
                         fontFamily: 'FjallaOne',
                         fontSize: Configuration.TIMER_FONT_SIZE,
                         color: Configuration.TIMER_COLOR,
                         fontWeight: FontWeight.w400,

                         /// Outline
//                                 shadows: [
//                                       Shadow(
//                                           // bottomLeft
//                                           offset: Offset(-1 * Configuration.BORDER_WIDTH_TIMER, -1 * Configuration.BORDER_WIDTH_TIMER),
//                                           color: Configuration.BORDER_COLOR_TIMER),
//                                       Shadow(
//                                           // bottomRight
//                                           offset: Offset(Configuration.BORDER_WIDTH_TIMER, -1 * Configuration.BORDER_WIDTH_TIMER),
//                                           color: Configuration.BORDER_COLOR_TIMER),
//                                       Shadow(
//                                           // topRight
//                                           offset: Offset(Configuration.BORDER_WIDTH_TIMER, Configuration.BORDER_WIDTH_TIMER),
//                                           color: Configuration.BORDER_COLOR_TIMER),
//                                       Shadow(
//                                           // topLeft
//                                           offset: Offset(-1 * Configuration.BORDER_WIDTH_TIMER, Configuration.BORDER_WIDTH_TIMER),
//                                           color: Configuration.BORDER_COLOR_TIMER),
//                                     ]

                    ),

                    subhead: TextStyle(
                         fontSize: 20,
                         fontFamily: 'Oswald',
                         color: Colors.white,
                    )
               )
          );
     }
}

enum TimerType {
     pomodoro, chilli, lime, avocado, carrot
}

