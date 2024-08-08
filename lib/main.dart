// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:galaxyvisits/ViewModel/LoginViewModel.dart';
import 'package:galaxyvisits/ViewModel/VisitDetailViewModel.dart';
import 'package:galaxyvisits/ViewModel/VisitViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'Ui/Login/Login_Body.dart';
import 'ViewModel/SalesManViewModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  var ViewModel = HomeViewModel();
  ViewModel.startTimer();
  var ViewModel2 = CustomerViewModel();
  ViewModel2.startTimer();
  //GestureBinding.instance?.resamplingEnabled = true;

  runApp(
MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => CustomerViewModel()),
      ChangeNotifierProvider(create: (_) => VisitViewModel()),
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => SalesManViewModel()),
      ChangeNotifierProvider(create: (_) => VisitDetailViewModel()),
    ], child:    const MyApp(),
  )
  );





}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', 'US'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ar', 'SA'), // Arabic
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Galaxy Visits',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
void initState() {
  super.initState();
  var viewModel = Provider.of<CustomerViewModel>(context, listen: false);
  var HomeModel = Provider.of<HomeViewModel>(context, listen: false);
  getlocation().then((position) {
    HomeModel.setData(position.latitude.toString(), position.longitude.toString());
    viewModel.setdata(position.latitude.toString(), position.longitude.toString());
  });
    Timer(const Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Body())));

}

Future<Position> getlocation() async {
  return await Geolocator.getCurrentPosition();
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor:HexColor(Globalvireables.basecolor),
//backgroundColor: HexColor(Globalvireables.basecolor),
        body: Container(
          color: HexColor(Globalvireables.basecolor),
          margin: const EdgeInsets.only(top: 200),

          child: Column(children: [
            Center(
              child: Image.asset('assets/logo2.png'
                ,height:250 ,width:250 , ),
            ),
const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 16),
              child: Text("Powered By galaxy International Group",style: TextStyle(
                  color: HexColor(Globalvireables.white),fontSize: 13
              ),),
            )

          ]

          ),
        ));

  }}
