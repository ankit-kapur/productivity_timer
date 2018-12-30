import 'package:flutter/material.dart';
import 'dart:async';

import 'package:productivity_timer/bottom_panel.dart';
import 'package:productivity_timer/config/config.dart';
import 'package:productivity_timer/dao/timer_state.dart';
import 'package:productivity_timer/type_selection.dart';
import 'package:productivity_timer/timer/TimerPainter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: Configuration.timerThemeData(),
      home: MyHomePage(title: 'Jarvis Timekeeper'),
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
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 24, fontFamily: 'FjallaOne'),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new MainDisplay(),
      ),

      /// BUTTON IN THE CENTER
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6.0,
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          side: BorderSide(color: Colors.white, width: 2),
        ),
        icon: const Icon(Icons.golf_course),
        label: const Text(
          'Progress',
          style: TextStyle(fontSize: 20, fontFamily: 'FjallaOne'),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /// BOTTOM NAV BAR
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {},
            )
          ],
        ),
      ),
      // drawer: new SideDrawer(),  /// Side drawer menu
    );
  }
}

class MainDisplay extends StatefulWidget {
  MainDisplay({Key key}) : super(key: key);

  @override
  _MainDisplayState createState() => _MainDisplayState();
}

class _MainDisplayState extends State<MainDisplay>
    with TickerProviderStateMixin {
  TimerState timerState = new TimerState();
  Timer timer;
  int elapsedMilliseconds;

  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(
        new Duration(milliseconds: Configuration.TIMER_REFRESH_RATE_MSEC),
        callback);

    timerState.controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timerState.getDurationInSeconds()),
    );
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
          image: new AssetImage("images/bg3.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        overflow: Overflow.clip,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          /// Ring
          Positioned(
              top: 125 + Configuration.RING_RADIUS / 2, child: timerRing()),

          /// Timer-text
          Positioned(top: 125, child: timerDisplayWidget()),

          /// Types button
          Positioned(
              top: 303,
              child: new TypeSelection(
                  Configuration.BUTTON_HORIZ_PADDING, timerState)),

          /// Play/pause button
          Positioned(
              bottom: 60,
              child: new ControlButtons(
                  Configuration.BUTTON_HORIZ_PADDING, timerState)),
        ],
      ),
    );
  }

  String getTimerString() {
    Duration duration = timerState.controller.duration;
    if (timerState.statusOfTimer != StatusOfTimer.STOPPED)
      duration *= timerState.controller.value;
    String mins = '${(duration.inMinutes).toString().padLeft(2, '0')}';
    String seconds = '${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    return mins + ':' + seconds;
  }

  timerDisplayWidget() {
    return Align(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            getStatusText(),
            style: Theme.of(context).textTheme.subhead,
          ),
          AnimatedBuilder(
              animation: timerState.controller,
              builder: (BuildContext context, Widget child) {
                return new Text(
                  getTimerString(),
                  style: Theme.of(context).textTheme.display1,
                );
              }),
        ],
      ),
    );
  }

  timerRing() {
    return Align(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: timerState.controller,
        builder: (BuildContext context, Widget child) {
          return new CustomPaint(
              painter: TimerPainter(
            animation: timerState.controller,
            backgroundColor: Colors.white,
            doneColor: Theme.of(context).indicatorColor,
          ));
        },
      ),
    );
  }

  String getStatusText() {
    String statusText;
    setState(() {
      switch (timerState.statusOfTimer) {
        case StatusOfTimer.PAUSED:
          {
            statusText = "Paused";
          }
          break;

        case StatusOfTimer.RUNNING:
          {
            statusText = "Time remaining";
          }
          break;

        case StatusOfTimer.STOPPED:
          {
            statusText = "Ready";
          }
          break;
      }
    });
    return statusText;
  }
}
