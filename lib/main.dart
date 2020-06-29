import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ty/pages/splash_page.dart';
import 'package:ty/utils/app_context.dart';

void main() {
  runApp(MyApp());
  AutoOrientation.portraitAutoMode();
  SystemChrome.setSystemUIOverlayStyle(AppContext.getSystemUiOverlayDarkStyle());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme:AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white
        )
      ),
      home: SplashPage(),
    );
  }
}


//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:auto_orientation/auto_orientation.dart';
//
//void main() {
//  runApp(
//    AutoOrientationDemo(),
//  );
//}
//
//class AutoOrientationDemo extends StatefulWidget {
//  AutoOrientationDemo({this.title = 'Auto Orientation Demo'});
//
//  final String title;
//
//  @override
//  State<StatefulWidget> createState() {
//    return _AutoOrientationDemoState();
//  }
//}
//
//class _AutoOrientationDemoState extends State<AutoOrientationDemo> {
//  TargetPlatform _platform;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: widget.title,
//      theme: ThemeData.light().copyWith(
//        platform: _platform ?? Theme.of(context).platform,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text(widget.title),
//        ),
//        body: Column(
//          children: <Widget>[
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.portraitDownMode();
//                    },
//                    child: Padding(
//                      child: Text("Portrait UPSIDE Down"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.fullAutoMode();
//                    },
//                    child: Padding(
//                      child: Text("All modes"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.landscapeAutoMode();
//                    },
//                    child: Padding(
//                      child: Text("Landscape auto"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.portraitAutoMode();
//                    },
//                    child: Padding(
//                      child: Text("Portrait auto"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.landscapeLeftMode();
//                    },
//                    child: Padding(
//                      child: Text("Landscape left mode"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      SystemChrome.setPreferredOrientations([
//                        DeviceOrientation.portraitUp,
//                        DeviceOrientation.portraitDown,
//                        DeviceOrientation.landscapeLeft,
//                        DeviceOrientation.landscapeRight,
//                      ]);
//                      AutoOrientation.landscapeRightMode();
//                    },
//                    child: Padding(
//                      child: Text("Landscape right mode"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//            Row(
//              children: <Widget>[
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.portraitUpMode();
//                    },
//                    child: Padding(
//                      child: Text("Portrait up mode"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//                Expanded(
//                  child: FlatButton(
//                    onPressed: () {
//                      AutoOrientation.portraitDownMode();
//                    },
//                    child: Padding(
//                      child: Text("Portrait down mode"),
//                      padding: EdgeInsets.symmetric(vertical: 16.0),
//                    ),
//                  ),
//                ),
//              ],
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
