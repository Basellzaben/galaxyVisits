// ignore_for_file: curly_braces_in_flow_control_structures, camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print

import 'package:flutter/widgets.dart';
import 'package:galaxyvisits/ViewModel/VisitViewModel.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/VisitDetails/VisitDetails_Body.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:provider/provider.dart';

import 'widget/bottomsheet.dart';

class inventory_Body extends StatefulWidget {
  const inventory_Body({Key? key}) : super(key: key);

  @override
  _inventory_Body createState() => _inventory_Body();
}

class _inventory_Body extends State<inventory_Body> {
  var data;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<VisitViewModel>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      viewModel.journals.isEmpty ? viewModel.refreshItemsinv() : null;
    });
  }

  final TextEditingController searchcontroler = TextEditingController();

  var cR = HexColor(Globalvireables.white3);

  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<VisitViewModel>(
      builder: (context, model, child) => LoadingWidget(
          text: "جاري تحميل البيانات",
          isLoading: model.isloading1,
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
                        onChanged: (String newText) async {
                          await model.refreshSearch(newText);
                        },
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
                  ],
                ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VisitDetails_Body()));
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
                  model.checkJournals == 1
                      ? const Center(child: CircularProgressIndicator())
                      : Container(
                          color: cR,
                          child: model.journals.isEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: 100,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        "لا يوجد مواد",
                                        style: TextStyle(fontSize: 20),
                                      )),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.all(5),
                                  child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: model.journals.length,
                                    itemBuilder: (context, index) => Container(
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          // model.refreshselectedItems().then((value) {
                                          model.setdefault();
                                          if (model.itemselected
                                              .map((e) => e['name'])
                                              .contains(
                                                  model.journals[index].name)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content:
                                                  Text("المادة مضافة مسبقا"),
                                            ));
                                          } else {
                                            showModalBottomSheet(
                                                isScrollControlled: true,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                builder: (context) {
                                                  return CustomModalContent(
                                                    index: index,
                                                  );
                                                });
                                          }
                                        },
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          borderOnForeground: true,
                                          shadowColor: Colors.blueAccent,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          child: Container(
                                            height: 80,
                                            color:
                                                HexColor(Globalvireables.white),
                                            child: Center(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  height: 77,
                                                  child: Center(
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 5),
                                                          child: Text(
                                                            model
                                                                .journals[index]
                                                                .name!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                Globalvireables
                                                                    .style2,
                                                          )))),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                ]))),
          )),
    );
  }
}
