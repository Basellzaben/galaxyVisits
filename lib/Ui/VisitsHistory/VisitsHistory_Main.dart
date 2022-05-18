import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'VisitsHistory_Body.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(VisitsHistory_Main());
}
class VisitsHistory_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<VisitsHistory_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VisitsHistory_Body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
