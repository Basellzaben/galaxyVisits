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
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: false,
        backgroundColor: HexColor(Globalvireables.white3),
        endDrawer: NavDrawer(),
    /*    appBar: PreferredSize(
          preferredSize: Size.fromHeight(200), // Set this height
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width/1.3,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 0.0)),
                color: HexColor(Globalvireables.bluedark)),
            child: Row(
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 20.0)),
                  ),
                  height: 65,
                  margin: EdgeInsets.only(top: 40,left: 10,right: 10),
                  width: MediaQuery.of(context).size.width/1.1,
                  child: DropdownButton(

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
                  ),
                ),



              ],
            ),
          ),
        ),*/
        body:Container(
          margin: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor(Globalvireables.white3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: new Image.asset('assets/update.png'
                    ,height:250 ,width:250 , ),
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
    Uri apiUrl = Uri.parse(Globalvireables.CustomersAPI+"/"+Globalvireables.username);

    showLoaderDialog(context, text);
    http.Response response=await http.get(apiUrl);

    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));

    var list =json.decode(response.body) as List;
    await SQLHelper.deleteCustomers();
    if(list.length==0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("لا يوجد عملاء")));
      Navigator.pop(context);
    }else{
      for(var i=0;i<list.length;i++){
        await SQLHelper.createCustomers(list[i]["Name"], list[i]["Name"], list[i]["No"]);
        Navigator.pop(context);
      }
    }

    getcountcust();


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
    Uri apiUrl = Uri.parse(Globalvireables.ItemsAPI+Globalvireables.username);

    showLoaderDialog(context,text);
    http.Response response = await http.get(apiUrl);
print("ggggg"+response.body.toString());
    //List<String, dynamic> list = json.decode(response.body);
    var list = await json.decode(response.body) as List;
    SQLHelper.deleteitems();
 //   await SQLHelper.createCustomers(list[i]["Name"],list[i]["Person"],list[i]["No"]);


   if(list.length==0){


     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text("لا يوجد مواد")));


     Navigator.pop(context);

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
      await SQLHelper.createitems(Item_Name,
     Unit,price,Item_No,list[i]["barcode"]);
      print("count :"+i.toString());
      if(i==list.length-1){
        Navigator.pop(context);
      }
    }}

    getcountcust();

  }

}