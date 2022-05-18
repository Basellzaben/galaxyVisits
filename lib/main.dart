import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';

import 'Ui/Home/Home_Body.dart';
import 'Ui/Login/Login_Body.dart';

Future<void> main() async {
  GestureBinding.instance?.resamplingEnabled = true;

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
              child: Text("Powered By Galaxy International Group",style: TextStyle(
                  color: HexColor(Globalvireables.basecolor),fontSize: 12
              ),),
            )

          ]

          ),
        ));

  }}
/*
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Barcode Scanner - googleflutter.com'),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    onPressed: barcodeScanning,
                    child: Text("Capture Image",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                Text("Scanned Barcode Number",
                  style: TextStyle(fontSize: 20),
                ),
                Text(barcode,
                  style: TextStyle(fontSize: 25, color:Colors.green),
                ),
              ],
            ),
          )),
    );
  }

  //scan barcode asynchronously
  Future barcodeScanning() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() => print(barcode.rawContent+"  bars"));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}*/
