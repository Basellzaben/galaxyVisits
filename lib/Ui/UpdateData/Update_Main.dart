import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Update_Body.dart';


void main() {
  runApp(Update_Main());
}
class Update_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<Update_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Update_Body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
