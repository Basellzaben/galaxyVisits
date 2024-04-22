import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/Ui/Locatethecustomer/LocateCustomer_Body.dart';


void main() {
  runApp(LocateCustomer_Main());
}
class LocateCustomer_Main extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<LocateCustomer_Main> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LocateCustomer(),
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
