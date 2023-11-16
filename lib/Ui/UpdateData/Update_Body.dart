import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/inventory/inventory_Body.dart';
import 'package:galaxyvisits/Ui/sideMenue/NavDrawer.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../../widget/Widgets.dart';
import '../Home/Home_Body.dart';
import '../VisitsHistory/VisitsHistory_Body.dart';
class Update_Body extends StatefulWidget {
  @override
  _Update_Body createState() => _Update_Body();
}

class _Update_Body extends State<Update_Body>   {

  getcountcust() async {
    var data = await SQLHelper.GetCustomers();
    var data2 = await SQLHelper.GetItems();
     setState(() {
       Globalvireables.sizeItems=data2.length;
       Globalvireables.sizeCustomers=data.length;


     });
  }

  @override
  void initState() {
    getcountcust();

  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchcontroler = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
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

        appBar: AppBar(
          backgroundColor: HexColor(Globalvireables.basecolor),
          bottomOpacity: 800.0,
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 4.0,
          title: Widgets.Appbar(
            context,
            'تحديث البيانات',
            'AR',
          ),
        ),
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: HexColor(Globalvireables.white),
      //  endDrawer: NavDrawer(),

        body:Container(
          margin: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor(Globalvireables.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: new Image.asset('assets/update2.png'
                    ,height:200 ,width:300 , ),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Card(
            child: Column(
            children: [

          Container(
            margin: EdgeInsets.only(top: 15),
            child: Center(
                child:Text("العملاء",style: TextStyle(color: Colors.black54,fontSize: 18),)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:10),
            child: Center(
                  child:Text(Globalvireables.sizeCustomers.toString(),style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 40),)
            ),
          ),

              Container(
                margin: EdgeInsets.all(10),
                height: 40,
                width: MediaQuery.of(context).size.width/1.2,
                color:HexColor(Globalvireables.white),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:HexColor(Globalvireables.basecolor),
                  ),
                  child: Text(
                    "تحديث العملاء"
                    ,style: TextStyle(color: HexColor(Globalvireables.white)),
                  ),
                  onPressed:
                      () async {

                    setState((){
                      fillCustomers(context,"جار تحديث العملاء");

                      /*  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
*/
                    });
                  },
                ),
              ),


            ])
                  ),



                ),


                Container(
                  margin: EdgeInsets.all(15),
                  child: Card(
                      child: Column(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Center(
                                  child:Text("المواد",style: TextStyle(color: Colors.black54,fontSize: 18),)
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top:10),
                              child: Center(
                                  child:Text(Globalvireables.sizeItems.toString(),style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 40),)
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.all(10),
                              height: 40,
                              width: MediaQuery.of(context).size.width/1.2,
                              color:HexColor(Globalvireables.white),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:HexColor(Globalvireables.basecolor),
                                ),
                                child: Text(
                                  "تحديث المواد"
                                  ,style: TextStyle(color: HexColor(Globalvireables.white)),
                                ),
                                onPressed:
                                    () async {

                                  setState((){
                                    fillItems(context,"جار تحديث المواد");
                                    /*   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
*/
                                  });
                                },
                              ),
                            ),


                          ])
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
    try {
      Uri apiUrl = Uri.parse(
          Globalvireables.CustomersAPI + "/" + Globalvireables.username);

      showLoaderDialog(context, text);
      http.Response response = await http.get(apiUrl);
      if (response.statusCode == 200) {

      /*Map<String, dynamic> data = new Map<String, dynamic>.from(
          json.decode(response.body));*/

      var list = json.decode(response.body) as List;
      await SQLHelper.deleteCustomers();
      if (list.length == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("لا يوجد عملاء")));
        Navigator.pop(context);
      } else {
        for (var i = 0; i < list.length; i++) {
          await SQLHelper.createCustomers(
              list[i]["Name"], list[i]["Name"], list[i]["No"]);

        }
        Navigator.pop(context);
      }

      getcountcust();
      }else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("يوجد مشكلة , يرجى المحاولة لاحقا")));

      }
    }catch(_){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("يوجد مشكلة , يرجى المحاولة لاحقا")));
    }

  }
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






  fillItems(BuildContext context, String text) async{
    try {
    Uri apiUrl = Uri.parse(Globalvireables.ItemsAPI+Globalvireables.username);

    showLoaderDialog(context,text);
    http.Response response = await http.get(apiUrl);
    if (response.statusCode == 200) {

      print("ggggg"+response.body.toString());
    //List<String, dynamic> list = json.decode(response.body);
    var list = await json.decode(response.body) as List;
    SQLHelper.deleteitems();
 //   await SQLHelper.createCustomers(list[i]["Name"],list[i]["Person"],list[i]["No"]);


   if(list.length==0){

     Navigator.pop(context);

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text("لا يوجد مواد")));



   }else{
    for(var i=0;i<list.length;i++){
      print(list[i]["barcode"]);
      double price=0.00;
      String Item_Name="";
      String Unit="0.00";
      String Item_No="-1";
      String barcode="";
      if(list[i]["Price"]!=null){
        price=list[i]["Price"];
      }
      if(list[i]["Item_Name"]!=null){
        Item_Name=list[i]["Item_Name"];
      }
      if(list[i]["Item_No"]!=null){
        Item_No=list[i]["Item_No"];
      }
      if(list[i]["Unit"]!=null){
        Unit=list[i]["Unit"];
      }
      if(list[i]["barcode"]!=null){
        barcode=list[i]["barcode"];
      }
      await SQLHelper.createitems(Item_Name,
     Unit,price,Item_No,barcode);
      print("count :"+i.toString()+"  Item_No="+Item_No.toString());

    }
    Navigator.pop(context);}

    getcountcust();

 }else{
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("يوجد مشكلة , يرجى المحاولة لاحقا")));
    }}catch(err){
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(err.toString() +"يوجد مشكلة , يرجى المحاولة لاحقا...")));
  Navigator.pop(context);
     }
  }
  int selectedIndex = 0;
  final List<Widget> nav = [
    Update_Body(),
    Home_Body(),
    VisitsHistory_Body(),
  ];
  _onItemTapped(int index) {


    if(index != 0){
      setState(() {
        selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });}
  }
}