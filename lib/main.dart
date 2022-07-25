import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';

import 'Ui/Home/Home_Body.dart';
import 'Ui/Login/Login_Body.dart';

Future<void> main() async {
  //GestureBinding.instance?.resamplingEnabled = true;

  runApp(MyApp());
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

/*  login ()  {
    Navigator.push(context,
        MaterialPageRoute(builder:
            (context) =>
            Login_Body()));


    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('activefingerprint')!=null){
      if(prefs.getBool('activefingerprint')!){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Login_Body()));

                }else{
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                    FingerPrintAuth()));
            }}else{
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>
                  FingerPrintAuth()));
            }

    print(prefs.getBool('activefingerprint').toString()+"savvvve");



  }*/

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
        backgroundColor:Colors.white,
//backgroundColor: HexColor(Globalvireables.basecolor),
        body: Container(
          margin: EdgeInsets.only(top: 200),

          child: Column(children: [
            Center(
              child: new Image.asset('assets/logo.jpg'
                ,height:250 ,width:250 , ),
            ),

            Container(
              margin: EdgeInsets.only(top: 200),
              child: Text("Powered By galaxy International Group",style: TextStyle(
                  color: HexColor(Globalvireables.basecolor),fontSize: 12
              ),),
            )

          ]

          ),
        ));

  }}
