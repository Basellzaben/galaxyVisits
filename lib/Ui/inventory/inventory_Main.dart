import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'inventory_Body.dart';

void main() {
  GestureBinding.instance?.resamplingEnabled = true;
  runApp(inventory_Main());
}
class inventory_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<inventory_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: inventory_Body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
