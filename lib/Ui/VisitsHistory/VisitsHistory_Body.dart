// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';
import 'package:galaxyvisits/Ui/VisitsInfoH/VisitsHistory_Body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:intl/intl.dart';
import '../../widget/Widgets.dart';
import '../Home/Home_Body.dart';
import '../UpdateData/Update_Body.dart';

// ignore: camel_case_types
class VisitsHistory_Body extends StatefulWidget {
  const VisitsHistory_Body({Key? key}) : super(key: key);

  @override
  _VisitsHistory_Body createState() => _VisitsHistory_Body();
}

// ignore: camel_case_types
class _VisitsHistory_Body extends State<VisitsHistory_Body> {
  Future<List<itemsinfo>> fetchData() async {
    Uri ItemsAPI =
        Uri.parse(Globalvireables.ItemsAPI + Globalvireables.username);
    final response = await http.get(ItemsAPI);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => itemsinfo.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<itemsinfo>>? futureData;
  List<Map<String, dynamic>> ss = [];

  List<dynamic> _journals = [];

  @override
  void initState() {
    _refreshItems();

    fillvisited();

    _refreshItems();
    super.initState();
  }

  final TextEditingController searchcontroler = TextEditingController();

  final TextEditingController datecontroler = TextEditingController();

  var cR = HexColor(Globalvireables.white3);

  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedItemColor: HexColor(Globalvireables.white),
          unselectedItemColor: Colors.white,
          backgroundColor: HexColor(Globalvireables.basecolor),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.update,
              ),
              label: 'تحديث البيانات',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_history), label: 'سجل الزيارات'),
          ],
          iconSize: 30,
          unselectedFontSize: 12,
          selectedFontSize: 16,
          showUnselectedLabels: true,
          currentIndex: selectedIndex,
          selectedIconTheme:
              IconThemeData(color: HexColor(Globalvireables.white)),
          onTap: _onItemTapped,
        ),
        backgroundColor: HexColor(Globalvireables.white3),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: HexColor(Globalvireables.basecolor),
          bottomOpacity: 800.0,
          elevation: 4.0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Widgets.Appbar(
            context,
            'سجل الزيارات',
            'AR',
          ),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: HexColor(Globalvireables.white3),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                child: Row(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 6,
                    child: GestureDetector(
                        onTap: () async {
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2040),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              Globalvireables.date =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              setState(() {
                                _refreshItems();
                              });
                            }
                          });
                        },
                        child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.only(
                                left: 0, right: 0, top: 10),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.calendar_month,
                              size: 35.0,
                              color: HexColor(Globalvireables.basecolor),
                            ))),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      margin: const EdgeInsets.only(top: 10, left: 0, right: 0),

                      //  alignment: Alignment.center,

                      child: TextFormField(
                        onChanged: s(),

                        //readOnly: true,

                        controller: datecontroler,

                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),

                          //suffixIcon: Icon(Icons.close,color: Colors.red,),
                          suffixIcon: IconButton(
                            onPressed: () {
                              datecontroler.clear();
                              Globalvireables.date = "";
                            },
                            icon: const Icon(Icons.clear),
                          ),

                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor(Globalvireables.basecolor),
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(10.0)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0)),

                          contentPadding: const EdgeInsets.only(
                              top: 18, bottom: 18, right: 20, left: 20),

                          fillColor: Colors.white,

                          filled: true,

                          hintText: 'البحث',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date.';
                          }

                          return null;
                        },
                      ))
                ]),
              ),
              if (_journals.isNotEmpty)
                Container(
                  color: cR,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _journals.length,
                    itemBuilder: (context, index) => Container(
                        // height: 80,
                        margin:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (_journals[index]['name'] != null) {
                              Globalvireables.custselected =
                                  _journals[index]['name'];
                            }
                            if (_journals[index]['name'] != null) {
                              Globalvireables.vtimeselected = _journals[index]
                                          ['date']
                                      .toString()
                                      .substring(0, 10) +
                                  " - " +
                                  _journals[index]['time'].toString();
                            }

                            List<String> parts =
                                Globalvireables.vtimeselected.split(' - ');
                            String datePart = parts[0];
                            String timePart = parts[1];
                            try{
  Globalvireables.startTimeselected =
                                DateFormat('HH:mm').format(
                                    DateFormat('HH:mm:ss').parse(timePart));
                            }catch(e){
                              Globalvireables.startTimeselected =   DateFormat('HH:mm').format(
                                    DateFormat('HH:mm').parse(timePart));
                            }
                          

                            // Parse the date part directly
                            Globalvireables.dateTimeselected =
                                DateFormat('yyyy-MM-dd')
                                    .format(DateTime.parse(datePart));

                            Globalvireables.endTimeselected =
                                _journals[index]['endTime'].toString();
                            print(_journals[index].toString());

                            Globalvireables.visitno =
                                _journals[index]['orederno'].toInt().toString();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const VisitsInfoH_Body()));
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.blue,
                            child: Column(
                              children: [
                                if (_journals[index]['name'] != null)
                                  Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(
                                        _journals[index]['name'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )),
                                if (_journals[index]['name'] != null)
                                  Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Text(_journals[index]['date']
                                              .toString()
                                              .substring(0, 10) +
                                          " - " +
                                          DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(_journals[index]['time'].toString()))
                                          )),
                              ],
                            ),
                          ),
                        )),
                  ),
                )
              else
                Container(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 120),
                      child: Image.asset(
                        'assets/notfound.png',
                      ),
                    ))
            ]))));
  }

  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);
    var data;
    data = await SQLHelper.GetVisited();
    print(data.toString() + "jjjjj");

    if ((datecontroler.text == "") && Globalvireables.date == "") {
      data = await SQLHelper.GetVisited();
    } else {
      if (Globalvireables.date.contains("20") && (datecontroler.text != "")) {
        data = await SQLHelper.searchvisited(datecontroler.text);
      } else if (Globalvireables.date.contains("20") &&
          (datecontroler.text == "")) {
        data = await SQLHelper.searchvisiteddate(Globalvireables.date);
      } else {
        data = await SQLHelper.searchvisited(datecontroler.text);
      }
    }
    setState(() {
      _journals = data;
    });
    print(data.toString() + "jjjjj");

    print(data.length.toString() + " ghyt");
  }

  s() {
    _refreshItems();
  }

  fillvisited() async {
    Uri apiUrl =
        Uri.parse(Globalvireables.VisitsListAPI + Globalvireables.username);
    http.Response response = await http.get(apiUrl);
    SQLHelper.deletevisit();
    //List<String, dynamic> list = json.decode(response.body);
    var list = json.decode(response.body) as List;
    //await SQLHelper.deleteCustomers();

    for (var i = 0; i < list.length; i++) {
      try {
        print(list[i]);
        await SQLHelper.createvisit(
            list[i]["OrderNo"],
            list[i]["CustomerNameA"],
            list[i]["Tr_Data"],
            list[i]["Start_Time"],
            list[i]["End_Time"]);
        if (i == list.length - 1) {}
      } catch (e) {
        print(e.toString());
      }
    }
  }

  clear() {
    datecontroler.clear();
    Globalvireables.date = "";
  }

  int selectedIndex = 2;
  final List<Widget> nav = [
    Update_Body(),
    const Home_Body(),
    const VisitsHistory_Body(),
  ];

  _onItemTapped(int index) {
    if (index != 2) {
      setState(() {
        selectedIndex = index;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });
    }
  }
}
