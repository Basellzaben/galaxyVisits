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

class _Login_Body extends State<Login_Body>   {

late int cc;

  @override
  void initState() {
    Globalvireables.CustomerName="حدد العمــيل";


    // fillCustomers();
   // x();

  }
 // final prefs = await SharedPreferences.getInstance();
  x() async {
    var data = await SQLHelper.GetCustomers();
    Globalvireables.sizeCustomers=data.length;
print(data.length.toString()+" dddd");
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

final TextEditingController namecontroler = TextEditingController();
final TextEditingController passwordcontroler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor(Globalvireables.white3),
        drawerEnableOpenDragGesture: false,
        body:Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
            Container(
              child: new Image.asset('assets/logo.png'
                ,height:180 ,width:180 , ),
            ),
                Center(
                  child: Container(
               //   margin: EdgeInsets.only(top: 100),
                    width: MediaQuery.of(context).size.width/1.1,
                    height: MediaQuery.of(context).size.height/1.6,
                    child: Card(

                      color: HexColor(Globalvireables.white),
                     // margin: EdgeInsets.only(top: 5),
                            child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 40,bottom: 25,left: 25,right: 25),
                                      child: TextField(
                              controller: namecontroler,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.drive_file_rename_outline),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:HexColor(Globalvireables.basecolor), width: 0.0),
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 0.0),
                                    borderRadius: BorderRadius.circular(10.0)

                                ),


                                contentPadding: EdgeInsets.only(
                                    top: 18, bottom: 18, right: 20, left: 20),
                                fillColor: Colors.white,
                                filled: true,
                                hintText:'اسم المستخدم',

                              ),
                            )),
                                  Container(
                                      margin: EdgeInsets.all(25),
                                      child: TextField(
                                        controller: passwordcontroler,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.drive_file_rename_outline),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:HexColor(Globalvireables.basecolor), width: 0.0),
                                              borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black, width: 0.0),
                                              borderRadius: BorderRadius.circular(10.0)

                                          ),


                                          contentPadding: EdgeInsets.only(
                                              top: 18, bottom: 18, right: 20, left: 20),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText:'كلمة المرور',

                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    width: 240,
                                    margin: EdgeInsets.only(top: 100),
                                    color:HexColor(Globalvireables.white),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary:HexColor(Globalvireables.basecolor),
                                        ),
                                      child: Text(

                                      "تسجيل الدخول"
                                          ,style: TextStyle(color: HexColor(Globalvireables.white)),
                                      ),
                                      onPressed:
                                          () async {

                                        setState((){
                                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Body()));

                                          showLoaderDialog(context);

                                          Login(namecontroler.text,passwordcontroler.text,context);

                                        });
                                      },
                                    ),
                                  ),
                        ]
                    ),
                  )

                  ),
                )]),
          ),
        ),
      ),
    );
  }

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("تسجيل الدخول ..." )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}
Login(String username,String password,BuildContext context) async{
  try {
    Uri apiUrl = Uri.parse(Globalvireables.loginAPI);
    final json = {
      "UserName": username,
      "Password": password
    };

    http.Response response = await http.post(apiUrl, body: json).whenComplete(() => Navigator.pop(context));

    var jsonResponse = jsonDecode(response.body);

    print("wheeen" + jsonResponse.toString());

    Globalvireables.username=username;
    Globalvireables.email=jsonResponse["Email"];
Globalvireables.manNo=jsonResponse["Id"];

    setState(() {
      if(jsonResponse["id"]!="0"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Body()));}
      else{
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('تسجيل الدخول'),
              content: Text('كلمة المرور او المستخدم غير صحيح'),
            )
        );
      }

    });
  } catch(_) {
    //Navigator.pop(context);


    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('تسجيل الدخول'),
          content: Text('كلمة المرور او المستخدم غير صحيح'),
        )
    );

  }



}

fillCustomers() async{
  Uri apiUrl = Uri.parse(Globalvireables.CustomersAPI);


  http.Response response = await http.get(apiUrl);

  List<dynamic> list = json.decode(response.body);

  for(var i=0;i<list.length;i++){
    SQLHelper.createCustomers(list[i]["Name"],list[i]["Person"],list[i]["No"]);
  }


}


}