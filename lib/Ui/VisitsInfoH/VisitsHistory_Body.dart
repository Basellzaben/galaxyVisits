// ignore_for_file: unused_element, avoid_print, non_constant_identifier_names, unnecessary_new, prefer_typing_uninitialized_variables, camel_case_types, file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:intl/intl.dart';
import '../../Models/CustomerStockListModel.dart';
import '../../Models/ImageListModel.dart';

class VisitsInfoH_Body extends StatefulWidget {
  const VisitsInfoH_Body({Key? key}) : super(key: key);

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
  List<Map<String, dynamic>> ss = [];
  List<dynamic> images = [];

  List<dynamic> itemselected = [];

  @override
  void initState() {
    super.initState();

    // _refreshItems();
    // _refreshCustomers();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController searchcontroler = TextEditingController();

  var cR = HexColor(Globalvireables.white3);

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor(Globalvireables.white3),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: HexColor(Globalvireables.basecolor),
          title: const Row(children: <Widget>[
            Spacer(),
            Text(
              "بيانات الزيارة",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
            margin: const EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            color: HexColor(Globalvireables.white),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 5, top: 10),
                  child: Icon(
                    Icons.supervised_user_circle_sharp,
                    size: 70.0,
                    color: HexColor(Globalvireables.black),
                  )),
              Container(
                  decoration: BoxDecoration(
                    color: HexColor(Globalvireables.white),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: HexColor(Globalvireables.basecolor),
                      width: 2,
                    ),
                  ),
                  margin: const EdgeInsets.only(
                      bottom: 5, top: 5, right: 10, left: 10),
                  child: Text(
                    Globalvireables.custselected,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        Globalvireables.dateTimeselected,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        ": تاريخ الزياره",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.bottomRight,
                          child: Text(
                            DateFormat('h:mm').format(
                              DateFormat('HH:mm').parse(
                                Globalvireables.endTimeselected.substring(0, 5),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          alignment: Alignment.bottomRight,
                          child: const Text(
                            ": نهاية الزيارة",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          // alignment: Alignment.bottomRight,
                          child: Text(
                            DateFormat('h:mm').format(
                              DateFormat('HH:mm').parse(
                                Globalvireables.startTimeselected
                                    .substring(0, 5),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          // alignment: Alignment.bottomRight,
                          child: const Text(
                            " : بداية الزيارة",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: const Text(
                    ": صور الزياره",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 200,
                margin: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: HexColor(Globalvireables.white),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: HexColor(Globalvireables.basecolor),
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1,
                    // height: MediaQuery.of(context).size.width / 3.5,
                    child: FutureBuilder(
                      future: geimgstock(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ImageListModel>> snapshot) {
                        if (snapshot.hasData) {
                          List<ImageListModel>? Appoiments = snapshot.data;

                          return Appoiments!.isNotEmpty
                              // set the physics horizantal

                              ? GridView(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 0.0),
                                  children: Appoiments.map(
                                          (ImageListModel inv) => SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Image.network(
                                                  "http://${Globalvireables.connectIP}${inv.ImgBase64}")))
                                      .toList(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        size: 30.0,
                                        color: Colors.red,
                                      ),
                                      Center(
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              child: const Text(
                                                'لم يتم ارفاق صور',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.redAccent),
                                              ))),
                                    ],
                                  ),
                                );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
              ),
              const Divider(),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                alignment: Alignment.bottomRight,
                child: const Text(
                  ": جرد المواد",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: HexColor(Globalvireables.white),
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.width / 1,
                child: FutureBuilder(
                  future: getitemstock(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<CustomerStockListModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<CustomerStockListModel>? Appoiments = snapshot.data;
                      return Appoiments!.isNotEmpty
                          ? ListView(
                              children: Appoiments.map((CustomerStockListModel
                                      inv) =>
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Card(
                                            shadowColor: Colors.blue,
                                            elevation: 5,
                                            color:
                                                HexColor(Globalvireables.white),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'الطلبية المقترحة',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: HexColor(
                                                                      Globalvireables
                                                                          .basecolor),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  // This makes the container circular
                                                                  color: HexColor(
                                                                      Globalvireables
                                                                          .basecolor), // Container background color
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          7.0),
                                                                  child: Center(
                                                                    child: Text(
                                                                      inv.OrderQty
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "المادة ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: HexColor(
                                                                      Globalvireables
                                                                          .basecolor),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              inv.Ename
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: HexColor(
                                                                      Globalvireables
                                                                          .basecolor),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(),
                                                  Row(children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            ' : الكمية',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: HexColor(
                                                                    Globalvireables
                                                                        .basecolor),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            inv.Qty.toString(),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: HexColor(
                                                                    Globalvireables
                                                                        .basecolor),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    inv.Note != null
                                                        ? Expanded(
                                                            child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                ' : الملاحظات',
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
                                                              Text(
                                                                inv.Note
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: HexColor(
                                                                        Globalvireables
                                                                            .basecolor),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ],
                                                          ))
                                                        : const SizedBox()
                                                  ])
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  )).toList(),
                            )
                          : Image.asset(
                              "assets/notfound.png",
                              height: 100,
                              width: 100,
                            );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ]))));
  }

  void _refreshCustomers() async {
    print(
        "${Globalvireables.VisitsImageAPI}/${Globalvireables.username}/${double.parse(Globalvireables.visitno).toInt()}  images");

    print(
        "${Globalvireables.VisitsImageAPI}/${Globalvireables.username}/${double.parse(Globalvireables.visitno).toInt()}");
    Uri apiUrl = Uri.parse(
        "${Globalvireables.VisitsImageAPI}/${Globalvireables.username}/${double.parse(Globalvireables.visitno).toInt()}");
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
    print("$data  dddatta ");

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
    print("OORDERNO : ${Globalvireables.visitno}");
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
    print("$data  dddatta ");

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
    print("${double.parse(Globalvireables.visitno).toInt()} gtgtgt");

    Uri postsURL = Uri.parse(
        "http://${Globalvireables.connectIP}/api/Visits/GetCustomerStockList/${Globalvireables.username}/${double.parse(Globalvireables.visitno).toInt()}");

    try {
      http.Response res = await http.get(postsURL);

      if (res.statusCode == 200) {
        print("Doctors${res.body}");

        List<dynamic> body = jsonDecode(res.body);

        print("${res.body}resresresres");

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
      print("errrror : $e");
    }

    throw "Unable to retrieve Doctors.";
  }

  Future<List<ImageListModel>> geimgstock() async {
    Uri postsURL = Uri.parse(
        "${Globalvireables.VisitsImageAPI}/${Globalvireables.username}/${double.parse(Globalvireables.visitno).toInt()}");

    try {
      http.Response res = await http.get(postsURL);

      if (res.statusCode == 200) {
        print("Doctors${res.body}");

        List<dynamic> body = jsonDecode(res.body);

        print("${res.body}resresresresimg");

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
      print("errrror : $e");
    }

    throw "Unable to retrieve Doctors.";
  }
}
