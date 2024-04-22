// ignore_for_file: curly_braces_in_flow_control_structures, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/VisitViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/Ui/VisitDetails/VisitDetails_Body.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class inventory_Body extends StatefulWidget {
  const inventory_Body({Key? key}) : super(key: key);

  @override
  _inventory_Body createState() => _inventory_Body();
}

class _inventory_Body extends State<inventory_Body> {
  Future<List<itemsinfo>> fetchData() async {
    Uri ItemsAPI =
        Uri.parse(Globalvireables.ItemsAPI + Globalvireables.username);

    /* http.Response response = await http.get(apiUrl);
    var jsonResponse = jsonDecode(response.body);

    // var parsedJson = json.decode(jsonResponse);
    data = itemsinfo.fromJson(jsonResponse);
    print(jsonResponse.toString()+"resssssspnse");
    return data;
*/

    //Uri ItemsAPI = Uri.parse(Globalvireables.ItemsAPI);
    final response = await http.get(ItemsAPI);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => itemsinfo.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  late Future<List<itemsinfo>>? futureData;
  var data;
  final List<TextEditingController> _controllers = [];
  final List<TextEditingController> _controllers1 = [];
  final List<TextEditingController> _controllers2 = [];
  final List<TextEditingController> _controllers3 = [];
  List<Map<String, dynamic>> ss = [];

  List<Map<String, dynamic>> _journals = [];
  List<int> intArr = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  @override
  void initState() {
    super.initState();
    var customerViewModel = Provider.of<CustomerViewModel>(context, listen: false);
    log(customerViewModel.cusNo.toString() ,name: "cusno");
    //   futureData=fetchData();
    //  data=fetchData();
    _refreshItems();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController searchcontroler = TextEditingController();

  var cR = HexColor(Globalvireables.white3);

  var count = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
                resizeToAvoidBottomInset: true,

            backgroundColor: HexColor(Globalvireables.white3),
            drawerEnableOpenDragGesture: false,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(200), // Set this height
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 0.0)),
                    color: HexColor(Globalvireables.bluedark)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //  barcodeScanning();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 40, left: 10),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 30.0,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                    Container(
                      height: 65,
                      margin:
                          const EdgeInsets.only(top: 40, left: 10, right: 10),
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextField(
                        controller: searchcontroler,
                        onChanged: refrech(),
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: HexColor(Globalvireables.white),
                          suffixIcon: Icon(
                            Icons.search,
                            color: HexColor(Globalvireables.basecolor),
                          ),
                          hintText: "البحث",
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: HexColor(Globalvireables.basecolor)),
                          ),
                        ),
                      ),
                    ),
                    /* new GestureDetector(
                  onTap: (){
                    barcodeScanning();
                  },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40,left: 10),

                    child: Icon(
                      Icons.camera_alt,
                      size: 30.0,
                      color: Colors.white,
                    )),)*/
                  ],
                ),
              ),
            ),
            body: Consumer<VisitViewModel>(
                builder: (context, model, child) => Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: HexColor(Globalvireables.white3),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 50,
                        width: 150,
                        // margin: EdgeInsets.only(top: 100),
                        color: HexColor(Globalvireables.basecolor),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor(Globalvireables.basecolor),
                          ),
                          child: Text(
                            "تفاصيل الزيارة",
                            style:
                                TextStyle(color: HexColor(Globalvireables.white)),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const VisitDetails_Body()));
                            });
                          },
                        ),
                      ),
                    ),
              
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        ":جرد المــواد",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
              
                    /*   FutureBuilder <List<itemsinfo>>(
                  future: futureData,
                  builder: (context, snapshot) {*/
                    if (_journals.isNotEmpty)
                      Container(
                        color: cR,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _journals.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: GestureDetector(
                              
                                      onTap: () async {
                                        model.refreshselectedItems().then((value) {
                                             if(model.itemselected.map((e) => e['name']).contains(_journals[index]['name'])){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("المادة مضافة مسبقا"),
                                              ));
                                        }else
                                          
                                           {
                                              showModalBottomSheet(
                                                
                                        isScrollControlled: true,
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                              child: Card(
                                                color: HexColor(Globalvireables.white)
                                                    .withOpacity(0.9),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(20.0),
                                                  ),
                                                  shadowColor: Colors.blueAccent,
                                                  child: SizedBox(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .65,
                                                    child: SingleChildScrollView(
                                                      child: SizedBox(
                                                        height: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .6,
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                              child: Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top: 5,
                                                                          bottom: 20,
                                                                          left: 10,
                                                                          right: 10),
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                            child: Center(
                                                                                child: TextField(
                                                                          controller:
                                                                              _controllers[
                                                                                  index],
                                                                          onChanged:
                                                                              refrechtext(
                                                                                  index),
                                                                          textAlign:
                                                                              TextAlign
                                                                                  .center,
                                                                          keyboardType:
                                                                              TextInputType
                                                                                  .number,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                HexColor(
                                                                                    Globalvireables.white),
                                                                            //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                                            // hintText: "البحث",
                                                                            enabledBorder:
                                                                                const OutlineInputBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.all(Radius.circular(10.0)),
                                                                              borderSide:
                                                                                  BorderSide(
                                                                                color:
                                                                                    Colors.grey,
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: const BorderRadius
                                                                                  .all(
                                                                                  Radius.circular(10.0)),
                                                                              borderSide:
                                                                                  BorderSide(color: HexColor(Globalvireables.basecolor)),
                                                                            ),
                                                                          ),
                                                                        ))),
                                                                        const Expanded(
                                                                            child: Center(
                                                                                child: Text(
                                                                          ": كمية الجرد",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w500),
                                                                        ))),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                            Center(
                                                              child: Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top: 0,
                                                                          bottom: 20,
                                                                          left: 10,
                                                                          right: 10),
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                            child: Center(
                                                                                child: GestureDetector(
                                                                                    child: TextField(
                                                                                      enabled: false,
                                                                                      controller: _controllers2[index],
                                                                                      onChanged: refrechtext(index),
                                                                                      textAlign: TextAlign.center,
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: InputDecoration(
                                                                                        filled: true,
                                                                                        fillColor: HexColor(Globalvireables.white),
                                                                                        //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                                                        // hintText: "البحث",
                                                                                        enabledBorder: const OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                                                          borderSide: BorderSide(
                                                                                            color: Colors.grey,
                                                                                          ),
                                                                                        ),
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                                                          borderSide: BorderSide(color: HexColor(Globalvireables.basecolor)),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      await showDatePicker(
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(2021),
                                                                                        lastDate: DateTime(2040),
                                                                                      ).then((selectedDate) {
                                                                                        if (selectedDate != null) {
                                                                                          /* datecontroler.text =
                                              
                                                  DateFormat('yyyy-MM-dd').format(selectedDate);*/
                                                                                          //   Globalvireables.date=DateFormat('yyyy-MM-dd').format(selectedDate);
                                                            
                                                                                          setState(() {
                                                                                            _controllers2[index].text = DateFormat('yyyy-MM-dd').format(selectedDate);
                                                                                            //    _refreshItems();
                                                                                          });
                                                                                        }
                                                                                      });
                                                                                    }))),
                                                                        const Expanded(
                                                                          child:
                                                                              Center(
                                                                            child: Text(
                                                                                ": تاريخ الصلاحية",
                                                                                style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.w500)),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                            Center(
                                                              child: Container(
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top: 5,
                                                                          bottom: 20,
                                                                          left: 10,
                                                                          right: 10),
                                                                  child: Center(
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                            child: Center(
                                                                                child: TextField(
                                                                          controller:
                                                                              _controllers1[
                                                                                  index],
                                                                          onChanged:
                                                                              refrechtext(
                                                                                  index),
                                                                          textAlign:
                                                                              TextAlign
                                                                                  .center,
                                                                          keyboardType:
                                                                              TextInputType
                                                                                  .number,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                HexColor(
                                                                                    Globalvireables.white),
                                                                            //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                                            // hintText: "البحث",
                                                                            enabledBorder:
                                                                                const OutlineInputBorder(
                                                                              borderRadius:
                                                                                  BorderRadius.all(Radius.circular(10.0)),
                                                                              borderSide:
                                                                                  BorderSide(
                                                                                color:
                                                                                    Colors.grey,
                                                                              ),
                                                                            ),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: const BorderRadius
                                                                                  .all(
                                                                                  Radius.circular(10.0)),
                                                                              borderSide:
                                                                                  BorderSide(color: HexColor(Globalvireables.basecolor)),
                                                                            ),
                                                                          ),
                                                                        ))),
                                                                        const Expanded(
                                                                            child: Center(
                                                                                child: Text(
                                                                          " : الطلبية المقترحة",
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                                  18,
                                                                              fontWeight:
                                                                                  FontWeight.w500),
                                                                        ))),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                            const Center(
                                                                child: Text(
                                                              " : الملاحظات",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            )),
                                                            Container(
                                                              margin: const EdgeInsets
                                                                  .only(
                                                                  top: 0,
                                                                  bottom: 0,
                                                                  left: 10,
                                                                  right: 10),
                                                              child: SizedBox(
                                                                  height: 100,
                                                                  child: TextField(
                                                                    controller:
                                                                        _controllers3[
                                                                            index],
                                                                    onChanged:
                                                                        refrechtext(
                                                                            index),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    // keyboardType: TextInputType.number,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled: true,
                                                                      fillColor: HexColor(
                                                                          Globalvireables
                                                                              .white),
                                                                      //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                                      // hintText: "البحث",
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(
                                                                                    10.0)),
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color: Colors
                                                                              .grey,
                                                                        ),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .all(
                                                                                Radius.circular(
                                                                                    10.0)),
                                                                        borderSide: BorderSide(
                                                                            color: HexColor(
                                                                                Globalvireables
                                                                                    .basecolor)),
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 0.0,
                                                                      bottom: 8),
                                                              alignment:
                                                                  Alignment.center,
                                                              child: ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  // shape: CircleBorder(),
                                                                  backgroundColor: HexColor(
                                                                      Globalvireables
                                                                          .basecolor),
                                                                ),
                                                                child: Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      2.5,
                                                                  height: 50,
                                                                  alignment: Alignment
                                                                      .center,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle),
                                                                  child: const Text(
                                                                    "أضـافة",
                                                                    style: TextStyle(
                                                                        fontSize: 18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                onPressed: () async {
                                                                  // await SQLHelper.selectItem(_journals[index]['name'],intArr[index],_journals[index]['no']);
                                                            
                                                                  if (_controllers[
                                                                              index]
                                                                          .text
                                                                          .contains(
                                                                              '-') ||
                                                                      _controllers[
                                                                              index]
                                                                          .text
                                                                          .contains(
                                                                              ',')) {
                                                                    showDialog(context: context, 
                                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('تحذير'),
                                                        content: const Text('يرجى ادخال الكمية المطلوبة'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text('موافق'),
                                                          ),
                                                        ],
                                                      );
                                                                    }
                                                                    
                                                                  
                                                                    
                                                                    
                                                                    );
                                                                  }
                                                                  if (_controllers1[
                                                                              index]
                                                                          .text
                                                                          .contains(
                                                                              '-') ||
                                                                      _controllers1[
                                                                              index]
                                                                          .text
                                                                          .contains(
                                                                              ',')) {
                                                                    ScaffoldMessenger
                                                                            .of(
                                                                                context)
                                                                        .showSnackBar(
                                                                            const SnackBar(
                                                                      content: Text(
                                                                          "قيمة الطلبية المقترحة غير صحيحة"),
                                                                    ));
                                                                  }
                                                            
                                                                  if (_controllers[
                                                                          index]
                                                                      .text
                                                                      .isEmpty) {
                                                                    intArr[index] = 0;
                                                                  }
                                                            
                                                                  if (_controllers1[
                                                                          index]
                                                                      .text
                                                                      .isNotEmpty) {
                                                                    if (double.parse(
                                                                          _controllers1[
                                                                                  index]
                                                                              .text) >
                                                                      0) {
                                                                    AddItem(
                                                                        _journals[
                                                                                index][
                                                                            'no'],
                                                                        _journals[
                                                                                index]
                                                                            ['name'],
                                                                        intArr[index],
                                                                        int.parse(
                                                                            _controllers1[
                                                                                    index]
                                                                                .text),
                                                                        _controllers2[
                                                                                index]
                                                                            .text,
                                                                        _controllers3[
                                                                                index]
                                                                            .text);
                                                                    _refreshItems();
                                                                    setState(() {
                                                                      Navigator.pop(context);
                                                                   
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              const SnackBar(
                                                                        content: Text(
                                                                            "تمت اضافة المادة"),
                                                                      ));
                                                                    });
                                                                  } else {
                                                                   
                                                                    showDialog(context: context, 
                                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('تحذير'),
                                                        content: const Text('يرجى ادخال الكمية المطلوبة'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text('موافق'),
                                                          ),
                                                        ],
                                                      );
                                                                    }
                                              
                                                                  
                                                                    
                                                                    
                                                                    );
                                                                 
                                                                  }
                                                                  }
                                                                  else{
                                                                 showDialog(context: context, 
                                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('تحذير'),
                                                        content: const Text('يرجى ادخال الكمية المطلوبة'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: const Text('موافق'),
                                                          ),
                                                        ],
                                                      );
                                                                    }
                                                                    
                                                                  
                                                                    
                                                                    
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          );
                                        });
                                  }
                                        } );
                                     
                                       
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  borderOnForeground: true,
                                  shadowColor: Colors.blueAccent,
                                  
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
              
                                  child: Container(
                                    height: 80,
                                    
                                    color: HexColor(Globalvireables.white)
                                    ,
                                
                                  child: Center(
                                    child: Container(
              
                                        alignment: Alignment.center,
                                        height: 77,
                                        child: Center(
                                            child: Container(
                                                alignment: Alignment.center,
                                                margin:
                                                    const EdgeInsets.only(top: 5),
                                                child: Text(
                                                  _journals[index]['name'],
                                                  textAlign: TextAlign.center,
                                                  style: Globalvireables.style2,
                                                )))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
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
              
                    /*;}else
                        Container(
                            margin: EdgeInsets.only(top: 400),
                            child: Center(child: CircularProgressIndicator()));*/
                    /*        ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 75,
                                color: Colors.white,
                                child: Center(child: Text(data[index].title),
                                ),);
                            }
                        );*/
                    // })
                  ]))),
            )));
  }

  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);

    int to;
    var data = await SQLHelper.GetItems();
    setState(() {
      _journals = data;
    });
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    print(data.toString() + " thiss");
    if (data.length > 50) {
      to = 49;
    } else {
      to = data.length;
    }
    for (var i = 0; i < to; i++) {
      intArr[i] = 1;
      _controllers.add(TextEditingController());
      _controllers[i].text = 1.toString();

      _controllers1.add(TextEditingController());
      _controllers1[i].text = 0.toString();

      _controllers2.add(TextEditingController());
      String formattedDate = formatter.format(now);
      _controllers2[i].text = formattedDate;

      _controllers3.add(TextEditingController());
      _controllers3[i].text = "";
    }

    for (var i = 0; i < to; i++) {
      _controllers[i].text = "0";
      _controllers1[i].text = "";
    }
  }

  void creatcounters() {}

  void add(int index) {
    if ((int.parse(_controllers[index].text)) >= 1) {
      setState(() {
        //    count=count+1;
        //intArr[index]=intArr[index]+1;
        _controllers[index].text =
            (int.parse(_controllers[index].text) + 1).toString();
      });
    }
  }

  void minues(int index) {
    if (int.parse(_controllers[index].text) > 1) {
      setState(() {
        // intArr[index]=intArr[index]-1;
        _controllers[index].text =
            (int.parse(_controllers[index].text) - 1) as String;
      });
    }
  }

  void refreshSearch(String txt) async {
    var data = await SQLHelper.search(txt);
    setState(() {
      _journals = data;
    });
  }

  void refreshSearchBarcode(String txt) async {
    var data = await SQLHelper.searchbar(txt);
    setState(() {
      _journals = data;
      print(data.toString() + " barr");
    });
  }

  refrech() {
    setState(() {
      refreshSearch(searchcontroler.text);
    });
  }

  Future barcodeScanning() async {
    /* try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() {
searchcontroler.text=barcode.rawContent;
   //   refreshSearchBarcode(barcode.rawContent);
      print(barcode.rawContent+"  barcc");
      }*/ /*print(barcode.rawContent+"  bars")*/ /*);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
        //  cardnocontroler.text = 'No camera permission!';
        });
      } else {
       // setState(() => // cardnocontroler.text = 'Unknown error: $e');
      }
    } on FormatException {
    //  setState(() =>  cardnocontroler.text =
     // 'Nothing captured.');
    } catch (e) {
    //  setState(() =>  cardnocontroler.text = 'Unknown error: $e');
    }*/
  }

  AddItem(
      String no, String name, int qty, int sugg, String ex, String Note) async {
    var data = await SQLHelper.itemSelected(no);
    setState(() {
      ss = data;
    });
    if (ss.isNotEmpty) {
/*print("exx"+ss[0]['Qty']);*/
      int sumqty = ss[0]['Qty'] + qty;
      await SQLHelper.updateItem(sumqty, ss[0]['id'], sugg, ex, Note);
    } else {
      //print("noexx"+ss[0]['Qty']);
      await SQLHelper.selectItem(name, qty, no, sugg, ex, Note);
    }
  }

  refrechtext(var index) {
    try {
      intArr[index] = int.parse(_controllers[index].text);
    } catch (err) {
      intArr[index] = 1;
    }
  }
}
