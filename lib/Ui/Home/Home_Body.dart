import 'dart:convert';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/Login/Login_Body.dart';
import 'package:galaxyvisits/Ui/UpdateData/Update_Body.dart';
import 'package:galaxyvisits/Ui/VisitsHistory/VisitsHistory_Body.dart';
import 'package:galaxyvisits/Ui/inventory/inventory_Body.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/Widgets.dart';
import '../CustomersDialog.dart';
class Home_Body extends StatefulWidget {
  @override
  _Home_Body createState() => _Home_Body();
}

class _Home_Body extends State<Home_Body> {

  String currentTime = "";
  late int cc;
  List<Map<String, dynamic>> _journals = [];

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();
  String dropdownvalue = '';

//List<String> items ;

  List<String> items = [''];


  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      Globalvireables.X_Lat = l.latitude.toString();
      Globalvireables.Y_Long = l.longitude.toString();

      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  clearSelectedItem() async {
    await SQLHelper.clearItemsSelected();
    await SQLHelper.clearImagesSelected();
  }

  @override
  void initState() {
    fillvisited();

    // Globalvireables.CustomerName="اسم العميل";
    clearSelectedItem();
    DateTime now = DateTime.now();
    String minute = "";
    if (now.minute
        .toString()
        .length == 1)
      minute = "0" + now.minute.toString();
    else
      minute = now.minute.toString();
    currentTime = now.day.toString() + "/" + now.month.toString() + "/" +
        now.year.toString() + " - " + now.hour.toString() + ":" + minute;
    // handler = SQLHelper();
    var data ;
    SQLHelper.GetCustomers().then((value) => {

      if(value.length<1){
        showAlertDialog(context)
      }

    });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchcontroler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedItemColor: HexColor(Globalvireables.white),
          unselectedItemColor: Colors.white,
          backgroundColor: HexColor(Globalvireables.basecolor),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.update,),
              label: 'تحديث البيانات',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_history),
                label: 'سجل الزيارات'),
          ],
          iconSize: 30 ,
          unselectedFontSize: 12 ,
          selectedFontSize: 16 ,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          selectedIconTheme:
          IconThemeData(color: HexColor(Globalvireables.white)),
          onTap: _onItemTapped,
        ),

        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: HexColor(Globalvireables.white3),
        // endDrawer: NavDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180), // Set this height
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 1.3,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery
                            .of(context)
                            .size
                            .width, 0.0)),
                color: HexColor(Globalvireables.bluedark)),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(children: [

                      Container(
                          margin: EdgeInsets.only(left: 5, right: 5, top: 18),
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.supervised_user_circle_sharp,
                            size: 35.0,
                            color: HexColor(Globalvireables.white),

                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 0, right: 0, top: 17),
                          alignment: Alignment.centerLeft,
                          child: Text(Globalvireables.username, style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),)
                      ),


                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Login_Body()));
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 5, right: 5, top: 18),
                              alignment: Alignment.centerLeft,
                              child:  GestureDetector(
                                onTap: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            'تسجيل الخروج',
                                            style: TextStyle(
                                                fontSize: 22 )),
                                        content: Text(
                                         'هل أنت متأكد أنك تريد تسجيل الخروج ؟',
                                          style: TextStyle(
                                              fontSize:
                                              14 ),
                                        ),
                                        actions: [
                                          TextButton(
                                            //  textColor: Colors.black,
                                            onPressed: () {

                                              cleanRemember();

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login_Body(),
                                                  ),
                                                      (Route<dynamic>
                                                  route) =>
                                                  false);
                                            },
                                            child: Text(
                                             'تسجيل الخروج',
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 15 ),
                                            ),
                                          ),
                                          TextButton(
                                            // textColor: Colors.black,
                                            onPressed: () {
                                              Navigator.of(context).pop();


                                            },
                                            child: Text(
                                              'إلغاء',
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 15 ),
                                            ),
                                          ),
                                        ],






                                      );

                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.logout,
                                  size: 25.0,
                                  color: HexColor(Globalvireables.white),

                                ),
                              )
                          )),

                    ]),
                  ),
                ),


                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(
                         10.0),

                        top: Radius.circular(
                            10.0)
                    ),),
                  height: 60,
                  margin: EdgeInsets.only(top: 33, left: 10, right: 10),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.1,
                  child: new GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => CustomersDialog()));
                      });
                    },
                    child: Center(child: Text(
                      Globalvireables.CustomerName, textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),)),
                  ),
                ),


              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 0),
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: HexColor(Globalvireables.white3),
          child: SingleChildScrollView(
            child: Column(
              children: [

/*
                Container(
                    margin: EdgeInsets.only(bottom: 5, top: 10),
                    /*  child: Icon(
                      Icons.timer,
                      size: 50.0,
                      color:HexColor(Globalvireables.black),

                    )*/

                    child: Container(
                        child: Container(
                          child: new Image.asset('assets/clock.png'
                            , height: 50, width: 80,),

                        ))

                ),


                Container(
                  margin: EdgeInsets.only(bottom: 25, top: 0),
                  child: Text(
                    currentTime,
                    style: TextStyle(fontSize: 25),
                  ),
                ),*/
                Card(
                  color: HexColor(Globalvireables.basecolor),
                  child: Container(
                    margin: EdgeInsets.all(0),
                    height: MediaQuery.of(context).size.height/1.8,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: _initialcameraposition),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                    ),
                  ),),

                Container(
                  margin: EdgeInsets.only(right: 5, left: 5, top: 20),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width/1.5,
                  color: HexColor(Globalvireables.white),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(Globalvireables.basecolor),),
                    child: Text(
                      "بدء الزيارة"
                      ,
                      style: TextStyle(fontWeight: FontWeight.w700,color: HexColor(Globalvireables.white)),
                    ),
                    onPressed:
                        () {
                      if (Globalvireables.cusNo > 0)
                        Startvisit();
                      else {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: Text('بدء الزيارة'),
                                  content: Text(
                                      'لا يمكن بدء الزيارة قبل اختيار عميل'),
                                ));
                      }
                    },
                  ),
                ),

              /*  Container(

                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),

                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(1),
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.1,
                        color: HexColor(Globalvireables.white),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: HexColor(Globalvireables.basecolor),),
                          child: Text(
                            "سجل الزيارات",
                            style: TextStyle(
                                color: HexColor(Globalvireables.white)),),
                          onPressed:
                              () {
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    VisitsHistory_Body()
                                )
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(1),
                        height: 50,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.1,

                        color: HexColor(Globalvireables.white),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: HexColor(Globalvireables.basecolor),
                          ),
                          child: Text(
                            "تحديث البيانات"
                            , style: TextStyle(
                              color: HexColor(Globalvireables.white)),
                          ),
                          onPressed:
                              () async {
                            setState(() {
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Update_Body()));
                            });
                          },
                        ),
                      )
                    ],
                  ),
                )
*/

              ],
            ),
          ),
        ),
      ),
    );
  }

  fillCustomers(BuildContext context, String text) async {
    Uri apiUrl = Uri.parse(Globalvireables.CustomersAPI);
    // showLoaderDialog(context,text);
    http.Response response = await http.get(apiUrl);

    List<dynamic> list = json.decode(response.body);
    SQLHelper.deleteCustomers();
    for (var i = 0; i < list.length; i++) {
      SQLHelper.createCustomers(
          list[i]["Name"], list[i]["Person"], list[i]["No"]);
      if (i == list.length - 1) {
        //   Navigator.pop(context);
      }
    }
  }


/*  showLoaderDialog(BuildContext context){
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
  }*/
  showLoaderDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7), child: Text(text)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _refreshCustomers() async {
    var data = await SQLHelper.GetCustomers();
    for (var i = 0; i < data.length; i++) {
      items.add(data[i]["name"]);
      print(" hhhhhh" + data[i]["name"] + i.toString());
    }
  }

  Startvisit() async {
    try {
      Uri apiUrl = Uri.parse(Globalvireables.timeAPI);

      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);

      setState(() {
        Globalvireables.startTime = jsonResponse.toString();
        print(jsonResponse.toString() + "  timee");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => inventory_Body()));
      }


      );
    } catch (_) {

    }
  }

/*


fillCustomers(String username,String password,BuildContext context) async{
  try {
    Uri apiUrl = Uri.parse(Globalvireables.loginAPI);

    http.Response response = await http.get(apiUrl);

    var jsonResponse = jsonDecode(response.body);

    print("wheeen" + jsonResponse.toString());

    Globalvireables.name=jsonResponse["NameA"];
    Globalvireables.email=jsonResponse["Email"];


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
---

--

*/
  fillvisited() async{
    Uri apiUrl = Uri.parse(Globalvireables.VisitsListAPI+Globalvireables.username);

    http.Response response = await http.get(apiUrl);
    SQLHelper.deletevisit();
    //List<String, dynamic> list = json.decode(response.body);
    var list = json.decode(response.body) as List;
    //await SQLHelper.deleteCustomers();

    for(var i=0;i<list.length;i++){
      await SQLHelper.createvisit(list[i]["OrderNo"],list[i]["CustomerNameA"],list[i]["Tr_Data"],list[i]["Start_Time"]);
      if(i==list.length-1){
      }
    }

  }


  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("تم"),
      onPressed:  () {


        Navigator.pop(context);

      },
    );
    Widget continueButton = TextButton(
      child: Text("تحديث البيانات"),
      onPressed:  () {
        Navigator.pop(context);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Update_Body()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("يجب تحديث البيانات"),
      content: Text("يجب تحديث البيانات للحصول على افضل تجربه"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  int selectedIndex = 1;
  final List<Widget> nav = [
    Update_Body(),
    Home_Body(),
    VisitsHistory_Body(),
  ];
  _onItemTapped(int index) {


    if(index != 1){
      setState(() {
        selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });}
  }

  cleanRemember() async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString('username','');
    prefs.setString('password','');

  }

}



