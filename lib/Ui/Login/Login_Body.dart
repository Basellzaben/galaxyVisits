// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, avoid_print, unnecessary_new, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:galaxyvisits/ViewModel/LoginViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Login_Body extends StatefulWidget {
  const Login_Body({Key? key}) : super(key: key);

  @override
  _Login_Body createState() => _Login_Body();
}

class _Login_Body extends State<Login_Body> {
  @override
  void initState() {
    super.initState();
    var loginview = Provider.of<LoginViewModel>(context, listen: false);
    loginview.Getrememper();
    var ViewModel = Provider.of<CustomerViewModel>(context, listen: false);
    ViewModel.setCustomerName("حدد العمــيل");
    loginview.getSharedPreferences();
    var HomeModel = Provider.of<HomeViewModel>(context, listen: false);
    getlocation().then((position) {
      HomeModel.setData(
          position.latitude.toString(), position.longitude.toString());
      ViewModel.setdata(
          position.latitude.toString(), position.longitude.toString());
    });
  }

  Future<Position> getlocation() async {
    var ViewModel = Provider.of<CustomerViewModel>(context, listen: false);

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {}
    } else {
      Position _position = await Geolocator.getCurrentPosition();
      ViewModel.setMyLocation(
          _position.latitude.toString(), _position.longitude.toString());
      log("getlocation");
      log(_position.latitude.toString());
      log(ViewModel.myLocX, name: "myLocX");
      return _position;
    }
    Position _position = await Geolocator.getCurrentPosition();
    ViewModel.setMyLocation(
        _position.latitude.toString(), _position.longitude.toString());
    return _position;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(children: <Widget>[
        Image.asset(
          "assets/shape1.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
          body: Consumer<LoginViewModel>(
            builder: (context, loginview, child) => LoadingWidget(
              isLoading: loginview.isloading,
              text: "جار تسجيل الدخول",
              child: SingleChildScrollView(
                child: Column(children: [
                  Image.asset(
                    'assets/logo2.png',
                    height: 250,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  Center(
                      child: SizedBox(
                    //   margin: EdgeInsets.only(top: 100),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),

                      // margin: EdgeInsets.only(top: 5),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 40, bottom: 18, left: 20, right: 20),
                              child: TextField(
                                controller: loginview.namecontroler,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.supervised_user_circle),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(
                                              Globalvireables.basecolor),
                                          width: 0.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  contentPadding: const EdgeInsets.only(
                                      top: 18, bottom: 18, right: 20, left: 20),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'اسم المستخدم',
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.all(20),
                              child: TextField(
                                controller: loginview.passwordcontroler,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.password_sharp),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor(
                                              Globalvireables.basecolor),
                                          width: 0.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.0),
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  contentPadding: const EdgeInsets.only(
                                      top: 18, bottom: 18, right: 20, left: 20),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'كلمة المرور',
                                ),
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 25, right: 25, top: 0),
                              child: Row(
                                children: [
                                  Checkbox(
                                      value: loginview.check,
                                      //set variable for value
                                      onChanged: (bool? value) async {
                                        loginview.setcheck(value!);

                                        if (!loginview.check) {
                                          loginview.prefs
                                              .setString('username', '');
                                          loginview.prefs
                                              .setString('password', '');
                                        }
                                      }),
                                  const Text('تذكرني',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.3,
                            margin: const EdgeInsets.only(top: 44),
                            color: HexColor(Globalvireables.white),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    HexColor(Globalvireables.basecolor),
                              ),
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: HexColor(Globalvireables.white)),
                              ),
                              onPressed: () async {
                                var ViewModel = Provider.of<CustomerViewModel>(
                                    context,
                                    listen: false);
                                loginview.setisloading(true);
                                Position _position = await getlocation();
                                ViewModel.setMyLocation(
                                    _position.latitude.toString(),
                                    _position.longitude.toString());
                                await ViewModel.setSetting(
                                    await SQLHelper.getSettings());
                                await ViewModel.getCustomers();
                                await loginview.Login(context);

                                loginview.setisloading(false);

                                // });
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
