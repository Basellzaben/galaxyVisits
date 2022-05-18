import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'VisitDetails_Body.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(VisitDetails_Main());
}
class VisitDetails_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<VisitDetails_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VisitDetails_Body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
