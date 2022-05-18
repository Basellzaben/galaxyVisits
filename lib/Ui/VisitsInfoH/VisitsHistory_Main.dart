import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'VisitsHistory_Body.dart';


void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(VisitsInfoH_Main());
}
class VisitsInfoH_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<VisitsInfoH_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VisitsInfoH_Body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
