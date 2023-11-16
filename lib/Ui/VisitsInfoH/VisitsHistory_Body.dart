import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
import '../../Models/CustomerStockListModel.dart';
import '../../Models/ImageListModel.dart';

class VisitsInfoH_Body extends StatefulWidget {
  @override
  _VisitsInfoH_Body createState() => _VisitsInfoH_Body();
}

class _VisitsInfoH_Body extends State<VisitsInfoH_Body> {
  Future<List<itemsinfo>> fetchData() async {
    Uri ItemsAPI =
        Uri.parse(Globalvireables.ItemsAPI + Globalvireables.username);
    final response = await http.get(ItemsAPI);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new itemsinfo.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<itemsinfo>>? futureData;
  var data;
  List<TextEditingController> _controllers = [];
  List<Map<String, dynamic>> ss = [];
  List<dynamic> images = [];

  List<dynamic> itemselected = [];

  List<dynamic> _journals = [];

  @override
  void initState() {
    // _refreshItems();
    // _refreshCustomers();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController searchcontroler = TextEditingController();

  var cR = HexColor(Globalvireables.white3);

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: HexColor(Globalvireables.white3),
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: HexColor(Globalvireables.basecolor),
              title: Row(children: <Widget>[
                Spacer(),
                Text(
                  "بيانات الزيارة",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.white),
                ),
              ]),
              leading: GestureDetector(
                onTap: () {},
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25.0,
                    color: HexColor(Globalvireables.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, // add custom icons also
                ),
              ),
            ),
            body: Container(
                margin: EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                color: HexColor(Globalvireables.white3),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 5, top: 10),
                      child: Icon(
                        Icons.supervised_user_circle_sharp,
                        size: 70.0,
                        color: HexColor(Globalvireables.black),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 5, top: 5),
                      child: Text(
                        Globalvireables.custselected,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 5, top: 1),
                      child: Text(
                        Globalvireables.vtimeselected,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      )),

                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        alignment: Alignment.bottomRight,
                        child: Container(
                            child: Text(
                              ": صور الزياره",
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      height: MediaQuery.of(context).size.width / 3.5,
                      child: FutureBuilder(
                        future: geimgstock(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ImageListModel>> snapshot) {
                          if (snapshot.hasData) {
                            List<ImageListModel>? Appoiments = snapshot.data;

                            return Appoiments!.isNotEmpty
                                ? GridView(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0),
                                    children: Appoiments.map(
                                            (ImageListModel inv) => Container(
                                                width: 50,
                                                height: 50,
                                                child: Image.network("http://" +
                                                    Globalvireables.connectIP +
                                                    "" +
                                                    inv.ImgBase64.toString())))
                                        .toList(),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.error,
                                          size: 30.0,
                                          color: Colors.red,
                                        ),
                                        Container(
                                            child: Center(
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    child: Text(
                                                      'لم يتم ارفاق صور',
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              Colors.redAccent),
                                                    )))),
                                      ],
                                    ),
                                  );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                    alignment: Alignment.bottomRight,
                    child: Container(
                        child: Text(
                      ": جرد المواد",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
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

                  /*    Container(
                            margin: EdgeInsets.only(top: 10,left: 0,right: 0),
                            child: Row(
                              children: [

                                Spacer(),
                                Container(
                                    child: Text("الطلبية المقترحة",
                                      textDirection:TextDirection.rtl,
                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),) ),

                                Spacer(),
                                Spacer(),

                                Container(
                                    child: Text("الكمية",
                                      textDirection:TextDirection.rtl,
                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),) ),

                                Spacer(),
                                Spacer(),


                                Container(
                                    child: Text("اسم المنتج",
                                      textDirection:TextDirection.rtl,
                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),) ),

                                Spacer(),







                              ],
                            ),
                          ),
*/

                  /*  Container(
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



                          )*/
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    height: MediaQuery.of(context).size.width / 1,
                    child: FutureBuilder(
                      future: getitemstock(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CustomerStockListModel>>
                              snapshot) {
                        if (snapshot.hasData) {
                          List<CustomerStockListModel>? Appoiments =
                              snapshot.data;

                          return Appoiments!.isNotEmpty
                              ? ListView(
                                  children:
                                      Appoiments
                                          .map(
                                              (CustomerStockListModel inv) =>
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0,
                                                          left: 0,
                                                          right: 0),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 8.0,
                                                                    bottom: 8),
                                                            child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 0,
                                                                        bottom:
                                                                            0),
                                                                color: Colors
                                                                    .black12,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          0.0),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            // This makes the container circular
                                                                            color:
                                                                                HexColor(Globalvireables.basecolor), // Container background color
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(7.0),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                inv.OrderQty.toString(),
                                                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'الطلبية المقترحة',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                HexColor(Globalvireables.basecolor),
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      Spacer(),
                                                                      Expanded(
                                                                        child:
                                                                            Text(
                                                                          inv.Ename
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.right,
                                                                          maxLines:
                                                                              2,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              color: HexColor(Globalvireables.basecolor),
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Spacer(),

                                                              Text(
                                                                inv.Qty.toString(),
                                                                style: TextStyle(
                                                                    fontSize: 16 ,
                                                                    color: HexColor(Globalvireables.basecolor),
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                              ),
                                                              Text(
                                                                ' : الكمية',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: HexColor(
                                                                        Globalvireables
                                                                            .basecolor),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      /* Card(
                                              child: Row(children: [






                                                                      */ /*                  Spacer(),

                                                Container(
                                                    width: MediaQuery.of(context).size.width/3.4,
                                                    child: Text(inv.OrderQty.toString(),
                                                      textDirection:TextDirection.rtl,
                                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),) ),
                                                Spacer(),
                                                Spacer(),


                                                Container(
                                                    child: Text(inv.Qty.toString(),
                                                      textDirection:TextDirection.rtl,
                                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),) ),

                                                Spacer(),
                                                Spacer(),


                                                Container(
                                                    child: Text(inv.Ename.toString(),
                                                      textDirection:TextDirection.rtl,
                                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),) ),

                                                Spacer(),
                                          */ /*


                                              ],),

                                            ),*/
                                                    ),
                                                  )).toList(),
                                )
                              : Image.asset(
                                  "assets/notfound.png",
                                  height: 100,
                                  width: 100,
                                );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ])))));
  }

  void _refreshCustomers() async {
    print(Globalvireables.VisitsImageAPI +
        "/" +
        Globalvireables.username +
        "/" +
        double.parse(Globalvireables.visitno).toInt().toString() +
        "  images");

    print(Globalvireables.VisitsImageAPI +
        "/" +
        Globalvireables.username +
        "/" +
        double.parse(Globalvireables.visitno).toInt().toString());
    Uri apiUrl = Uri.parse(Globalvireables.VisitsImageAPI +
        "/" +
        Globalvireables.username +
        "/" +
        double.parse(Globalvireables.visitno).toInt().toString());
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
    print(data.toString() + "  dddatta ");

    setState(() {
      images = data;
    });
    if (images.isEmpty) {
      setState(() {
        _refreshCustomers();
      });
    }
  }

  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);
    print("OORDERNO : " + Globalvireables.visitno.toString());
    // print(Globalvireables.VisitsImageAPI+Globalvireables.visitno.toString() + " items");
    print("http://" +
        Globalvireables.connectIP +
        "/api/Visits/GetCustomerStockList/" +
        Globalvireables.username +
        "/" +
        '18' +
        "item2");
    Uri apiUrl = Uri.parse(
        "http://10.0.1.120:9998/api/Visits/GetCustomerStockList/" +
            Globalvireables.username +
            "/" +
            '18');
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
    print(data.toString() + "  dddatta ");

    setState(() {
      itemselected = data;
    });
    if (itemselected.isEmpty) {
      setState(() {
        _refreshItems();
      });
    }
  }

  Future<List<CustomerStockListModel>> getitemstock() async {

    print(double.parse(Globalvireables.visitno).toInt().toString() +" gtgtgt");


    Uri postsURL = Uri.parse(
        "http://10.0.1.120:9998/api/Visits/GetCustomerStockList/" +
            Globalvireables.username +
            "/" +
            double.parse(Globalvireables.visitno).toInt().toString());

    try {
      http.Response res = await http.get(postsURL);

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        print(res.body.toString() + "resresresres");

        List<CustomerStockListModel> HINFO = body
            .map(
              (dynamic item) => CustomerStockListModel.fromJson(item),
            )
            .toList();

        return HINFO;
      } else {
        throw "Unable to retrieve Doctors. orrr";
      }
    } catch (e) {
      print("errrror : " + e.toString());
    }

    throw "Unable to retrieve Doctors.";
  }

  Future<List<ImageListModel>> geimgstock() async {


    print("imggg : "+double.parse(Globalvireables.visitno).toInt().toString());

    Uri postsURL = Uri.parse(Globalvireables.VisitsImageAPI +
        "/" +
        Globalvireables.username +
        "/" +
        double.parse(Globalvireables.visitno).toInt().toString());

    try {
      http.Response res = await http.get(postsURL);

      if (res.statusCode == 200) {
        print("Doctors" + res.body.toString());

        List<dynamic> body = jsonDecode(res.body);

        print(res.body.toString() + "resresresresimg");

        List<ImageListModel> HINFO = body
            .map(
              (dynamic item) => ImageListModel.fromJson(item),
            )
            .toList();

        return HINFO;
      } else {
        throw "Unable to retrieve Doctors. orrr";
      }
    } catch (e) {
      print("errrror : " + e.toString());
    }

    throw "Unable to retrieve Doctors.";
  }
}
