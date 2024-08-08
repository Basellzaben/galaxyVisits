// ignore_for_file: file_names

import 'dart:async';

import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/CustomerViewModel.dart';

class CustomersDialog extends StatefulWidget {
  const CustomersDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<CustomersDialog>
    with SingleTickerProviderStateMixin {
  late http.Response response;
  // List<Map<String, dynamic>> model.journals = [];
  final TextEditingController searchcontroler = TextEditingController();

  @override
  void initState() {
    var model = Provider.of<CustomerViewModel>(context, listen: false);
    super.initState();

    if (model.journals.isEmpty) {
      model.refreshItems();
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerViewModel>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: HexColor(Globalvireables.basecolor),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          margin: const EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                size: 25.0,
                                color: HexColor(Globalvireables.basecolor),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }, // add custom icons also
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: Container(
                            height: 65,
                            margin: const EdgeInsets.only(
                                top: 40, left: 10, right: 10),
                            width: MediaQuery.of(context).size.width / 1.3,
                            child: TextField(
                              controller: searchcontroler,
                              onChanged: model.refrech(searchcontroler.text),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color:
                                          HexColor(Globalvireables.basecolor)),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                if (model.journals.isNotEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.journals.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                print(model.journals[index]['name']);
                                model.setCustomerName(
                                    model.journals[index]['name']);
                                    print(model.journals[index]['branchid']);
                                model
                                    .setCustomerNo(model.journals[index]['branchid'].toDouble());
                                model.CustomerVisit.clear();
                                if (!model.CustomerVisit.any((marker) =>
                                    marker.name == 'Current Location')) {
                                  model.CustomerVisit.add(Customer(
                                      name: 'Current Location',
                                      locX: model.myLocX,
                                      locY: model.myLocY));
                                }
                                print(model.journals[index]['locX']);
                                model.CustomerVisit.add(Customer(
                                  name: model.journals[index]['name'],
                                  locX: model.journals[index]['locX'] == ""
                                      ? "0"
                                      : model.journals[index]['locX'],
                                  locY: model.journals[index]['locY'] == ""
                                      ? "0"
                                      : model.journals[index]['locY'],
                                  no: model.journals[index]['no'],
                                ));
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  height: 60,
                                  margin: const EdgeInsets.only(
                                      top: 5, left: 5, right: 5),
                                  child: Card(
                                    color: HexColor(Globalvireables.white),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    shadowColor: Colors.blue,
                                    elevation: 5,
                                    child: Center(
                                        child: Text(
                                            model.journals[index]['name'],
                                            textAlign: TextAlign.center)),
                                  )),
                            )),
                  )
                else
                  Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 120),
                        child: Image.asset('assets/notfound.png'),
                      ))
              ],
            ),
          ));
    });
  }
}
