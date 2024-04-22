// ignore_for_file: file_names, camel_case_types

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/Ui/Permanency%20status/PermanencyStatus_body.dart';


void main() {
  GestureBinding.instance.resamplingEnabled = true;
  runApp(const PermanencyStatus_main());
}
class PermanencyStatus_main extends StatefulWidget {
  const PermanencyStatus_main({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<PermanencyStatus_main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const PermanencyStatus_body(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
