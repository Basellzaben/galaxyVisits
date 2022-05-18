import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login_Body.dart';

void main() {
  runApp(Login_Main());
}
class Login_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<Login_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login_Body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
