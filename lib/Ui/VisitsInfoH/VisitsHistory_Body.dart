import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:barcode_scan/model/scan_result.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/Ui/VisitDetails/VisitDetails_Body.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../ImageDialog.dart';

class VisitsInfoH_Body extends StatefulWidget {
  @override
  _VisitsInfoH_Body createState() => _VisitsInfoH_Body();
}

class _VisitsInfoH_Body extends State<VisitsInfoH_Body>   {
  Future <List<itemsinfo>> fetchData() async {
    Uri ItemsAPI = Uri.parse(Globalvireables.ItemsAPI+Globalvireables.username);
    final response = await http.get(ItemsAPI);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new itemsinfo.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  late Future <List<itemsinfo>>? futureData;
  var data;
  List<TextEditingController> _controllers = [];
  List<Map<String, dynamic>> ss = [];
  List<dynamic> images = [];

  List<dynamic> itemselected = [];

  List<dynamic> _journals = [];
  @override
  void initState() {
    _refreshItems();
    _refreshCustomers();
  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController searchcontroler = TextEditingController();

  var cR=HexColor(Globalvireables.white3);

  var count =0;
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: HexColor(Globalvireables.white3),
            drawerEnableOpenDragGesture: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80), // Set this height
              child: Container(
                  height: 80,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 0.0)),
                      color: HexColor(Globalvireables.bluedark)),
                  child:
                  Center(child: Container(

                      margin: EdgeInsets.only(top: 18),

                      child: Text("بيانات الزيارة",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700),)))

                /*Row(
              children: [



              ],
            ),*/
              ),
            ),
            body:Container(

                margin: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,

                color: HexColor(Globalvireables.white3),
                child: SingleChildScrollView(
                    child: Column(
                        children: [



                          Container(
                              margin: EdgeInsets.only(bottom: 5,top: 10),
                              child: Icon(
                                Icons.supervised_user_circle_sharp,
                                size: 70.0,
                                color:HexColor(Globalvireables.black),

                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(bottom: 5,top: 5),
                              child: Text(
                               Globalvireables.custselected,textAlign: TextAlign.center
,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),
                              )
                          ),

                          Container(
                              margin: EdgeInsets.only(bottom: 5,top: 1),
                              child: Text(
                                Globalvireables.vtimeselected
                                ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17),
                              )
                          ),









                          if(images.length>0)
                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                            alignment: Alignment.bottomRight,
                            child: Container(
                                child: Text(":صـور الزيارة",style: TextStyle(fontSize: 20),)
                            ),
                          ),


if(images.length>0)
              Container(
                  padding: EdgeInsets.all(12.0),
                  child: Container(
                    height: 250,
                    child: GridView.builder(
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return
                        new GestureDetector(
                        onTap: (){

                          Globalvireables.imageselected=images[index]['ImgBase64'];

                          showDialog(
                            context: context,
                            builder: (_) => ImageDialog(),
                          );

                        },
                          child: Container(
                            width: 100,
                            height: 100,
                            child: Image.network("http://"+Globalvireables.connectIP+""+images[index]['ImgBase64'])
                        ));
                      },
                    ),
                  ))
    else
  Container(
      padding: EdgeInsets.all(12.0),
      child: Container(
        child: new Image.asset('assets/not.png'
          ,height:100 ,width:100 , ),

      ))     ,
                          if(images.length<1)

                          Center(

                              child: Text("لم يتم ارفاق صور مع الزيارة",style: TextStyle(fontSize: 20),)
                          ),



                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                            alignment: Alignment.bottomRight,
                            child: Container(
                                child: Text(":جرد المواد",style: TextStyle(fontSize: 20),)
                            ),
                          ),

                    /*      Container(
                            height: 400,
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemselected.length,
                              itemBuilder: (context, index)
                              =>Container(
                                height: 50,
                                margin: EdgeInsets.only(top: 0,left: 10,right: 10),
                                child: Card(
                                  child: Row(children: [
                                      Spacer(),
                                    Container(
                                        child: Center(child: Container(
                                            margin: EdgeInsets.only(top: 5,bottom: 5),
                                            child: Text(itemselected[index]['Qty'].toString(), textDirection:TextDirection.rtl,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),)))
                                    ),
                                    Spacer(),

                                    Container(
                                        width: 200,
                                        child: Center(child: Container(
                                            margin: EdgeInsets.only(top: 5,bottom: 5),
                                            child: Text(itemselected[index]['Ename'], textDirection:TextDirection.rtl,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)))
                                    ),

                                  ],),

                                ),
                              ),
                            ),



                          )
*/

                          Container(
                            margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                            child: Row(
                              children: [
                                Spacer(),
                                Spacer(),

                                Container(
                                    width: 90,
                                    child: Center(child: Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                                        child: Text("الطلبية المقترحة",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)))
                                ),
                                Spacer(),
                                Container(
                                    child: Center(child: Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                                        child: Text("الكمية           ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)))
                                ),
                                Spacer(),
                                Spacer(),

                                Container(
                                    child: Center(child: Container(
                                        margin: EdgeInsets.only(top: 5,bottom: 5,left: 30,right: 30),
                                        child: Text("اسم المنتج",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)))
                                ),




                              ],
                            ),
                          ),



                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10),
                            child: ListView.builder(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: itemselected.length,
                              itemBuilder: (context, index)
                              =>Container(
                                margin: EdgeInsets.only(top: 0,left: 10,right: 10),
                                child: Card(
                                  child: Row(children: [
                                    Spacer(),

                                    Container(
                                        child: Center(child: Container(
                                            margin: EdgeInsets.only(top: 5,bottom: 5),
                                            child: Text(itemselected[index]['OrderQty'].toString(), textDirection:TextDirection.rtl,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)))
                                    ),
                                    Spacer(),
                                    Container(
                                        child: Center(child: Container(
                                            width: 50,
                                            margin: EdgeInsets.only(top: 5,bottom: 5),
                                            child: Text(itemselected[index]['Qty'].toString(), textDirection:TextDirection.rtl,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)))
                                    ),
                                    Spacer(),
                                    Spacer(),

                                    Container(
                                        width: 150,
                                        child: Center(child: Container(
                                            margin: EdgeInsets.only(top: 5,bottom: 5),
                                            child: Text(itemselected[index]['Ename'],textAlign: TextAlign.center, textDirection:TextDirection.rtl,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)))
                                    ),

                                  ],),

                                ),
                              ),
                            ),



                          )



            ])))));

  }

  void _refreshCustomers() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);

    print(Globalvireables.VisitsImageAPI+Globalvireables.visitno + "  images");

print(Globalvireables.VisitsImageAPI+"/"+Globalvireables.username+"/"+Globalvireables.visitno);
    Uri apiUrl = Uri.parse(Globalvireables.VisitsImageAPI+"/"+Globalvireables.username+"/"+Globalvireables.visitno);
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
  print(data.toString()+"  dddatta ");

      setState(() {
        images = data;
      });

    }



  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);

    print(Globalvireables.VisitsImageAPI+Globalvireables.visitno.toString() + " items");

    Uri apiUrl = Uri.parse("http://"+Globalvireables.connectIP+"/api/Visits/GetCustomerStockList/"+Globalvireables.username+"/"+Globalvireables.visitno.toString());
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
    print(data.toString()+"  dddatta ");

    setState(() {
      itemselected = data;
    });

  }

}