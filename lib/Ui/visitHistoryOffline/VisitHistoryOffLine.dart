// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:galaxyvisits/ViewModel/VisitViewModel.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:provider/provider.dart';
import '../../widget/Widgets.dart';
import '../Home/Home_Body.dart';
import '../UpdateData/Update_Body.dart';
import 'VisitHistoryDetailOffLine.dart';

// ignore: camel_case_types
class VisitHistoryOffLine extends StatefulWidget {
  const VisitHistoryOffLine({Key? key}) : super(key: key);

  @override
  _VisitHistoryOffLine createState() => _VisitHistoryOffLine();
}

// ignore: camel_case_types
class _VisitHistoryOffLine extends State<VisitHistoryOffLine> {
  late Future<List<itemsinfo>>? futureData;
  List<Map<String, dynamic>> ss = [];

  List<dynamic> _journals = [];

  @override
  void initState() {
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
        backgroundColor: HexColor(Globalvireables.white3),
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: HexColor(Globalvireables.basecolor),
          bottomOpacity: 800.0,
          elevation: 4.0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Widgets.Appbar(
            context,
            'سجل الزيارات الغير مرفوعة',
            'AR',
          ),
        ),
        body: Consumer<VisitViewModel>(
          builder: (context, model, child) =>  LoadingWidget(
            isLoading: model.isloading,
            text: "جار رفع البيانات يرجى الإنتظار",
            child: Container(
                margin: const EdgeInsets.only(top: 15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: HexColor(Globalvireables.white3),
                child: SingleChildScrollView(
                    child: Column(children: [
                  // create button to upload all data to server 
                 _journals.isNotEmpty ? Container(
                    decoration: BoxDecoration(
                      color: HexColor(Globalvireables.white3),
                      borderRadius: BorderRadius.circular(10),
                    
                    ),
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: HexColor(Globalvireables.basecolor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () async {
                      await  model.uploadData(context);
                        setState(() {
                          _refreshItems();
                        });
                      
                      },
                      child: const Text('رفع البيانات الى السيرفر'),
                    ),
                  ): Container(),
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
            
                               if (_journals[index]['Note'] != null) {
                                  Globalvireables.custselected =
                                      _journals[index]['Note'];
                                }
                                if (_journals[index]['Note'] != null) {
                               
                                }
            
                                
                                Globalvireables.startTimeselected = _journals[index]['Start_Time'].toString().substring(0, 5);
                                  
            
                                // Parse the date part directly
                                Globalvireables.dateTimeselected = _journals[index]['Tr_Data'].toString();
                                Globalvireables.endTimeselected =
                                    _journals[index]['End_Time'].toString();
                                print(_journals[index].toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             VisitInfoOff(id: _journals[index]['id'])));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.blue,
                                child: Column(
                                  children: [
                                    if (_journals[index]['Note'] != null)
                                      Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text(
                                            _journals[index]['Note'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )),
                                    if (_journals[index]['Note'] != null)
                                      Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Text(_journals[index]['Tr_Data']
                                                  .toString()
                                                   +
                                              " - " +
                                              
                                              _journals[index]['Start_Time'].toString()
                                                  .substring(0, 5)
                                            
                                          ),
                                          
                                      ),
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
                ]))),
          ),
        ));
  }

  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);
    var data;
    data = await SQLHelper.getAllPayloads();
    print(data.toString() + "jjjjj");

    if ((datecontroler.text == "") && Globalvireables.date == "") {
      data = await SQLHelper.getAllPayloads();
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

  clear() {
    datecontroler.clear();
    Globalvireables.date = "";
  }

  int selectedIndex = 2;
  final List<Widget> nav = [
    const Update_Body(),
    const Home_Body(),
    const VisitHistoryOffLine(),
  ];

}
