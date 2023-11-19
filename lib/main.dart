import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';

import 'Ui/Home/Home_Body.dart';
import 'Ui/Login/Login_Body.dart';

Future<void> main() async {
  //GestureBinding.instance?.resamplingEnabled = true;

  runApp(

    DevicePreview(enabled: true,builder:(context)=>  MyApp(),));



}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy Visits',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
   super.initState();
     Timer(Duration(seconds: 5),
           ()=>
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_Body())),

     );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor:HexColor(Globalvireables.basecolor),
//backgroundColor: HexColor(Globalvireables.basecolor),
        body: Container(
          color: HexColor(Globalvireables.basecolor),
          margin: EdgeInsets.only(top: 200),

          child: Column(children: [
            Center(
              child: new Image.asset('assets/logo2.png'
                ,height:250 ,width:250 , ),
            ),
Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 16),
              child: Text("Powered By galaxy International Group",style: TextStyle(
                  color: HexColor(Globalvireables.white),fontSize: 13
              ),),
            )

          ]

          ),
        ));

  }}
