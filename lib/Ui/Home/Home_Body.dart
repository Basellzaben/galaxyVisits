import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/Ui/Login/Login_Body.dart';
import 'package:galaxyvisits/Ui/UpdateData/Update_Body.dart';
import 'package:galaxyvisits/Ui/VisitsHistory/VisitsHistory_Body.dart';
import 'package:galaxyvisits/Ui/inventory/inventory_Body.dart';
import 'package:galaxyvisits/Ui/sideMenue/NavDrawer.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../CustomersDialog.dart';
class Home_Body extends StatefulWidget {
  @override
  _Home_Body createState() => _Home_Body();
}

class _Home_Body extends State<Home_Body>   {

String currentTime="";
late int cc;
List<Map<String, dynamic>> _journals = [];

LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
late GoogleMapController _controller;
Location _location = Location();
String dropdownvalue = '';
//List<String> items ;

List<String> items = [''];





void _onMapCreated(GoogleMapController _cntlr)
{_controller = _cntlr;
  _location.onLocationChanged.listen((l) {

    Globalvireables.X_Lat=l.latitude.toString();
    Globalvireables.Y_Long=l.longitude.toString();

   _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(l.latitude!,l.longitude!),zoom: 15),
      ),
    );
  });

}

clearSelectedItem()async{
  await SQLHelper.clearItemsSelected();
  await SQLHelper.clearImagesSelected();

}

  @override
  void initState() {

    fillvisited();

   // Globalvireables.CustomerName="اسم العميل";
    clearSelectedItem();
    DateTime now = DateTime.now();
    String minute="";
    if(now.minute.toString().length==1)
      minute="0"+now.minute.toString();
    else
      minute=now.minute.toString();
currentTime=now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString()+" - "+now.hour.toString()+":"+minute;

/*

Timer(Duration(seconds: 5),
        ()=>
        _refreshCustomers()

);*/
   }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchcontroler = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: HexColor(Globalvireables.white3),
       // endDrawer: NavDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180), // Set this height
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width/1.3,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 0.0)),
                color: HexColor(Globalvireables.bluedark)),
            child: Column(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(children: [

                    Container(
                        margin: EdgeInsets.only(left: 5,right: 5,top: 18),
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.supervised_user_circle_sharp,
                          size: 35.0,
                          color:HexColor(Globalvireables.white),

                        )
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 0,right: 0,top: 17),
                        alignment: Alignment.centerLeft,
                        child: Text(Globalvireables.username,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w700),)
                    ),


                    Spacer(),
           GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Body()));

                });

              },
                    child: Container(
                        margin: EdgeInsets.only(left: 5,right: 5,top: 18),
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.logout,
                          size: 25.0,
                          color:HexColor(Globalvireables.white),

                        )
                    )),

                  ]),
                ),


                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 20.0)),),
                  height: 60,
                  margin: EdgeInsets.only(top: 40,left: 10,right: 10),
                  width: MediaQuery.of(context).size.width/1.1,
                  child: new GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomersDialog()));
                      });

                    },
                    child: Center(child: Text(Globalvireables.CustomerName,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),)),
                  ),




                  /*DropdownButton(
                    isExpanded: true,
                    value: dropdownvalue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items:items.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                      );
                      }
                      ).toList(),
                    onChanged: (String ?newValue){
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),*/
                ),



              ],
            ),
          ),
        ),
        body:Container(
          margin: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor(Globalvireables.white3),
          child: SingleChildScrollView(
            child: Column(
              children: [



                Container(
                  margin: EdgeInsets.only(bottom: 5,top: 10),
                  /*  child: Icon(
                      Icons.timer,
                      size: 50.0,
                      color:HexColor(Globalvireables.black),

                    )*/

                    child: Container(
                        child: Container(
                          child: new Image.asset('assets/clock.png'
                            ,height:50 ,width:80 , ),

                        ))

                ),


                Container(
                  margin: EdgeInsets.only(bottom: 25,top: 0),
                  child: Text(
                  currentTime,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
Card(
                color: HexColor(Globalvireables.basecolor),
                child: Container(
                  margin: EdgeInsets.all(2),
                  height: 250,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: _initialcameraposition),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                   myLocationEnabled: true,
                  ),
                ),)
                ,


                Container(
                  margin: EdgeInsets.only(right: 5,left: 5,top: 15),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color:HexColor(Globalvireables.white),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:HexColor(Globalvireables.basecolor),),
                    child: Text(
                      "بدء الزيارة"
                      ,style: TextStyle(color: HexColor(Globalvireables.white)),
                    ),
                    onPressed:
                        () {
                      if(Globalvireables.cusNo>0)
                        Startvisit();
                      else {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('بدء الزيارة'),
                              content: Text('لا يمكن بدء الزيارة قبل اختيار عميل'),
                            )); }},
                  ),
                ),

                Container(

                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.only(top: 15,left: 5,right: 5),

                  child: Row(
               children: [
                   Container(
                     margin: EdgeInsets.all(1),
                     height: 50,
                     width: MediaQuery.of(context).size.width/2.1,
                     color:HexColor(Globalvireables.white),
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         primary:HexColor(Globalvireables.basecolor),),
                       child: Text(
                         "سجل الزيارات",
                         style: TextStyle(color: HexColor(Globalvireables.white)),),
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
                     width: MediaQuery.of(context).size.width/2.1,

                     color:HexColor(Globalvireables.white),
                     child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         primary:HexColor(Globalvireables.basecolor),
                       ),
                       child: Text(
                         "تحديث البيانات"
                         ,style: TextStyle(color: HexColor(Globalvireables.white)),
                       ),
                       onPressed:
                           () async {

                         setState((){
                           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Update_Body()));

                         });
                       },
                     ),
                   )
               ],
                  ),
                )




              ],
            ),
          ),
        ),
      ),
    );
  }
fillCustomers(BuildContext context, String text) async{
  Uri apiUrl = Uri.parse(Globalvireables.CustomersAPI);

 // showLoaderDialog(context,text);
  http.Response response = await http.get(apiUrl);

  List<dynamic> list = json.decode(response.body);
  SQLHelper.deleteCustomers();
  for(var i=0;i<list.length;i++){
    SQLHelper.createCustomers(list[i]["Name"],list[i]["Person"],list[i]["No"]);
    if(i==list.length-1){
   //   Navigator.pop(context);
    }
  }

  //_journals[index]['id'].toString();
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
  showLoaderDialog(BuildContext context, String text){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text(text)),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
void _refreshCustomers() async {

  var data = await SQLHelper.GetCustomers();
    for(var i=0;i<data.length;i++){
        items.add(data[i]["name"]);
        print(" hhhhhh"+data[i]["name"] + i.toString());
}}

   Startvisit() async {
     try {
       Uri apiUrl = Uri.parse(Globalvireables.timeAPI);

       http.Response response = await http.get(apiUrl);
       var jsonResponse = jsonDecode(response.body);

       setState(() {
         Globalvireables.startTime=jsonResponse.toString();
         print(jsonResponse.toString()+"  timee");
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));}


           );
     } catch(_) {

   }}

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

}