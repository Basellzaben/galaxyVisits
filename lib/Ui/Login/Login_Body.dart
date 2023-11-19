import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/Home/Home_Body.dart';
import 'dart:typed_data';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Body extends StatefulWidget {
  @override
  _Login_Body createState() => _Login_Body();
}

class _Login_Body extends State<Login_Body> {
  late SharedPreferences prefs;
  late int cc;
  bool rem = false;

  @override
  void initState() {
    Getrememper();
    Globalvireables.CustomerName = "حدد العمــيل";
    getSharedPreferences();
    // fillCustomers();
    // x();
  }
  var check = false;

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveStringValue(String username) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
  }

  // final prefs = await SharedPreferences.getInstance();
  x() async {
    var data = await SQLHelper.GetCustomers();
    Globalvireables.sizeCustomers = data.length;
    print(data.length.toString() + " dddd");
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController namecontroler = TextEditingController();
  final TextEditingController passwordcontroler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Stack(children: <Widget>[
        Image.asset(
          "assets/shape1.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),


        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          drawerEnableOpenDragGesture: false,
          body: Container(
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  child: new Image.asset(
                    'assets/logo2.png',
                    height: 250,
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                ),
                Center(
                  child: Container(
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
                                margin: EdgeInsets.only(
                                    top: 40, bottom: 18, left: 20, right: 20),
                                child: TextField(
                                  controller: namecontroler,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.supervised_user_circle),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor(
                                                Globalvireables.basecolor),
                                            width: 0.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    contentPadding: EdgeInsets.only(
                                        top: 18, bottom: 18, right: 20, left: 20),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'اسم المستخدم',
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.all(20),
                                child: TextField(
                                  controller: passwordcontroler,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password_sharp),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: HexColor(
                                                Globalvireables.basecolor),
                                            width: 0.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    contentPadding: EdgeInsets.only(
                                        top: 18, bottom: 18, right: 20, left: 20),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: 'كلمة المرور',
                                  ),
                                )),
                          
                            /*      Row(
                                         children: [
                          , Text(
                                             "تحديث الكل",
                                             style: TextStyle(
                                                 color: Colors.black87,
                                                 fontWeight: FontWeight.w900,fontSize: 20),
                                           ),
                                           Container(
                                             width: MediaQuery.of(context).size.width/2,
                                             child: CheckboxListTile(
                                               contentPadding: EdgeInsets.all(0),
                                              activeColor: Colors.green,
                                              checkColor:Colors.white,
                          
                                              //    <-- label
                                              value: rem,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  rem = newValue!;
                                                });
                                              },
                                      ),
                                           ),
                          
                                         ],
                                       ),*/
                          
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 25, right: 25, top: 0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        value: check,
                                        //set variable for value
                                        onChanged: (bool? value) async {
                                          setState(()  {
                                            check = !check;
                          
                                            if(!check){
                                              prefs.setString('username','');
                                              prefs.setString('password','');
                                            }
                          
                                            //Provider.of<LoginProvider>(context, listen: false).setRemember(check);
                                            //   saveREstate(check.toString());
                                          });
                                        }),
                                    Text(
                                        'تذكرني',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12 )),
                                  ],
                                ),
                              ),
                            )
                          ,
                          
                          
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.3,
                              margin: EdgeInsets.only(top: 44),
                              color: HexColor(Globalvireables.white),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: HexColor(Globalvireables.basecolor),
                                ),
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: HexColor(Globalvireables.white)),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Body()));
                          
                                    showLoaderDialog(context);
                          
                                    Login(namecontroler.text,
                                        passwordcontroler.text, context);
                                  });
                                },
                              ),
                            ),
                          
                          
                          
                          
                          ]),
                        ),
                      )),
                )
              ]),
            ),
          ),


        ),


      ]),
    );

  }





  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("تسجيل الدخول ...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Login(String username, String password, BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("username");
    if (username != value) {
      await SQLHelper.deleteitems();
      await SQLHelper.deleteCustomers();
    }
    saveStringValue(username);

    try {
      Uri apiUrl = Uri.parse(Globalvireables.loginAPI);
      final json = {"UserName": username, "Password": password};

      http.Response response = await http
          .post(apiUrl, body: json)
          .whenComplete(() => Navigator.pop(context));

      var jsonResponse = jsonDecode(response.body);

      print("wheeen" + jsonResponse.toString());
      print("wheeen2" + jsonResponse["Id"].toString());

      Globalvireables.username = username;
      Globalvireables.email = jsonResponse["Email"];
      Globalvireables.manNo = jsonResponse["Id"];



      prefs.setString('username',username);
      prefs.setString('password',password);


      setState(() {
        if (jsonResponse["Id"] != 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home_Body()));
        } else {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text('تسجيل الدخول'),
                    content: Text('كلمة المرور او اسم المستخدم غير صحيح'),
                  ));
        }
      });
    } catch (_) {
      //Navigator.pop(context);

      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('تسجيل الدخول'),
          content: Text('كلمة المرور او اسم المستخدم غير صحيح'),
          actions: <Widget>[],
        ),
      );
      /*showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Align(
              alignment:Alignment.center,child: Text('تسجيل الدخول',style: TextStyle(),textDirection:ui.TextDirection.rtl)),
          content: Text('كلمة المرور او اسم المستخدم غير صحيح'),
        )
    );
*/
    }
  }
  fillCustomers() async {
    Uri apiUrl = Uri.parse(Globalvireables.CustomersAPI);

    http.Response response = await http.get(apiUrl);

    List<dynamic> list = json.decode(response.body);

    for (var i = 0; i < list.length; i++) {
      SQLHelper.createCustomers(
          list[i]["Name"], list[i]["Person"], list[i]["No"]);
    }
  }
  Getrememper() async {
    prefs = await SharedPreferences.getInstance();



      if(prefs.getString('password').toString().length>1 && prefs.getString('password').toString()!='null'
          && prefs.getString('username').toString()!=null){
        check=true;

        passwordcontroler.text= await prefs.getString('password').toString();
        namecontroler.text=await prefs.getString('username').toString();
      //  Login(namecontroler.text.toString(),passwordcontroler.text.toString(),context);
      }else{
        passwordcontroler.text='';
        namecontroler.text='';
      }

setState(() {

});

  }


}
