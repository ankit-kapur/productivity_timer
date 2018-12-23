import 'package:flutter/material.dart';
import 'dart:async';

import 'package:productivity_timer/bottom_panel.dart';
import 'package:productivity_timer/config/config.dart';
import 'package:productivity_timer/dao/timer_state.dart';
import 'package:productivity_timer/side_drawer.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

          /// Not being used. BG is an image now.
          canvasColor: Colors.white,

          /// Top panel
          primarySwatch: Colors.green,

          // Buttons
          accentColor: Colors.green,
          backgroundColor: Colors.green,
          textTheme: TextTheme(

              /// Timer color
              display1: TextStyle(
            fontFamily: 'Impact',
            fontSize: Configuration.TIMER_FONT_SIZE,
            color: Configuration.TIMER_COLOR,
            fontWeight: FontWeight.w400,

            /// Outline
//            shadows: [
//              Shadow(
//                  // bottomLeft
//                  offset: Offset(-1 * Configuration.BORDER_WIDTH_TIMER, -1 * Configuration.BORDER_WIDTH_TIMER),
//                  color: Configuration.BORDER_COLOR_TIMER),
//              Shadow(
//                  // bottomRight
//                  offset: Offset(Configuration.BORDER_WIDTH_TIMER, -1 * Configuration.BORDER_WIDTH_TIMER),
//                  color: Configuration.BORDER_COLOR_TIMER),
//              Shadow(
//                  // topRight
//                  offset: Offset(Configuration.BORDER_WIDTH_TIMER, Configuration.BORDER_WIDTH_TIMER),
//                  color: Configuration.BORDER_COLOR_TIMER),
//              Shadow(
//                  // topLeft
//                  offset: Offset(-1 * Configuration.BORDER_WIDTH_TIMER, Configuration.BORDER_WIDTH_TIMER),
//                  color: Configuration.BORDER_COLOR_TIMER),
//            ],

          ))),
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
  TimerState timerState = new TimerState();
  Timer timer;
  int elapsedMilliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(
        new Duration(milliseconds: Configuration.TIMER_REFRESH_RATE_MSEC), callback);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(
               "images/bg3.jpg"),
          fit: BoxFit.cover,
        ),
      ),

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
            child: new BottomPanel(Configuration.BUTTON_HORIZ_PADDING, timerState),
          )
        ],
      ),
    );
  }
}
