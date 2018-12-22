import 'package:flutter/material.dart';
import 'dart:async';

import 'package:productivity_timer/bottom_panel.dart';
import 'package:productivity_timer/dao/timer_state.dart';
import 'package:productivity_timer/side_drawer.dart';

/// ---------- Configuration ----------- ///
const double BUTTON_HORIZ_PADDING = 20.0;
const double TIMER_FONT_SIZE = 85;
const int INITIAL_TIME_MSEC = 65000;
const int TIMER_REFRESH_RATE_MSEC = 1000;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
          backgroundColor: Colors.amber,
          textTheme: TextTheme(display1: TextStyle(fontSize: TIMER_FONT_SIZE))),
      home: MyHomePage(title: 'Jarvis timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new MainDisplay(),
      ),
      drawer: new SideDrawer(),
    );
  }
}

class MainDisplay extends StatefulWidget {
  MainDisplay({Key key}) : super(key: key);

  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay> {
  TimerState timerState = new TimerState(INITIAL_TIME_MSEC);
  Timer timer;
  int elapsedMilliseconds;

  @override
  void initState() {
       timer = new Timer.periodic(
            new Duration(milliseconds: TIMER_REFRESH_RATE_MSEC), callback);
       super.initState();
  }

  @override
  void dispose() {
       timer?.cancel();
       timer = null;
       super.dispose();
  }

  void callback(Timer timer) {

       setState(() {
         elapsedMilliseconds = timerState.stopwatch.elapsedMilliseconds;
       });

//       if (elapsedMilliseconds != timerState.stopwatch.elapsedMilliseconds) {
//            elapsedMilliseconds = timerState.stopwatch.elapsedMilliseconds;
//            final int hundreds = (elapsedMilliseconds / 10).truncate();
//            final int seconds = (hundreds / 100).truncate();
//            final int minutes = (seconds / 60).truncate();
//            final ElapsedTime elapsedTime = new ElapsedTime(
//                 hundreds: hundreds,
//                 seconds: seconds,
//                 minutes: minutes,
//            );
//            for (final listener in dependencies.timerListeners) {
//                 listener(elapsedTime);
//            }
//       }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        timerState.getMinutes(),
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        ':',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        timerState.getSeconds(),
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: new BottomPanel(BUTTON_HORIZ_PADDING, timerState),
          )
        ],
      ),
    );
  }
}
