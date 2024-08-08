// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../GlobalVaribales.dart';
import '../../../ViewModel/VisitViewModel.dart';
import '../../../color/HexColor.dart';

class CustomModalContent extends StatelessWidget {
  int index = 0;

  CustomModalContent({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<VisitViewModel>(
        builder: (context, model, child) => Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Card(
              color: HexColor(Globalvireables.white).withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: Colors.blueAccent,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .65,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .6,
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 20, left: 10, right: 10),
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: TextField(
                                      controller:
                                          model.InventoryQuantityController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            HexColor(Globalvireables.white),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  Globalvireables.basecolor)),
                                        ),
                                      ),
                                    ))),
                                    const Expanded(
                                        child: Center(
                                            child: Text(
                                      ": كمية الجرد",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ))),
                                  ],
                                ),
                              )),
                        ),
                        Center(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  top: 0, bottom: 20, left: 10, right: 10),
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: GestureDetector(
                                                child: TextField(
                                                  enabled: false,
                                                  controller: model
                                                      .ExpireDateController,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: HexColor(
                                                        Globalvireables.white),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0)),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
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
                                                ),
                                                onTap: () async {
                                                  await showDatePicker(
                                                    
                                                    locale: const Locale(
                                                        'ar', 'SA'),
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2021),
                                                    lastDate: DateTime(2040),
                                                  ).then((selectedDate) {
                                                    if (selectedDate != null) {
                                                      /* datecontroler.text =
                                                                                                
                                                    DateFormat('yyyy-MM-dd').format(selectedDate);*/
                                                      //   Globalvireables.date=DateFormat('yyyy-MM-dd').format(selectedDate);

                                                      model.ExpireDateController
                                                          .text = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(selectedDate);
                                                      //    _refreshItems();
                                                    }
                                                  });
                                                }))),
                                    const Expanded(
                                      child: Center(
                                        child: Text(": تاريخ الصلاحية",
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
                              margin: const EdgeInsets.only(
                                  top: 5, bottom: 20, left: 10, right: 10),
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: TextField(
                                      controller: model.proposedOrderController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            HexColor(Globalvireables.white),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: HexColor(
                                                  Globalvireables.basecolor)),
                                        ),
                                      ),
                                    ))),
                                    const Expanded(
                                        child: Center(
                                            child: Text(
                                      " : الطلبية المقترحة",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ))),
                                  ],
                                ),
                              )),
                        ),
                        const Center(
                            child: Text(
                          " : الملاحظات",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        )),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10, right: 10),
                          child: SizedBox(
                              height: 100,
                              child: TextField(
                                controller: model.NoteController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: HexColor(Globalvireables.white),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: HexColor(
                                            Globalvireables.basecolor)),
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 0.0, bottom: 8),
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // shape: CircleBorder(),
                              backgroundColor:
                                  HexColor(Globalvireables.basecolor),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.height / 2.5,
                              height: 50,
                              alignment: Alignment.center,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: const Text(
                                "أضـافة",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              if (model.InventoryQuantityController.text
                                      .contains('-') ||
                                  model.InventoryQuantityController.text
                                      .contains(',')) {
                                showCustomDialog(
                                  context,
                                  'تحذير',
                                  'الكمية المدخلة غير صحيحة',
                                );
                                return;
                              }
                              if (model.proposedOrderController.text
                                      .contains('-') ||
                                  model.proposedOrderController.text
                                      .contains(',')) {
                                showCustomDialog(
                                  context,
                                  'تحذير',
                                  "قيمة الطلبية المقترحة غير صحيحة",
                                );
                                return;
                              }
                              if (model
                                  .proposedOrderController.text.isNotEmpty) {
                                if (double.parse(
                                        model.proposedOrderController.text) >
                                    0) {
                                  model.AddItem(index);
                                  Navigator.pop(context);

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("تمت اضافة المادة"),
                                  ));
                                } else {
                                  showCustomDialog(
                                    context,
                                    'تحذير',
                                    'يرجى ادخال الطلبية المقترحة',
                                  );
                                  return;
                                }
                              } else {
                                showCustomDialog(
                                  context,
                                  'تحذير',
                                  'يرجى ادخال الطلبية المقترحة',
                                );
                                return;
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
      ),
    );
  }

  void showCustomDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('موافق'),
            ),
          ],
        );
      },
    );
  }
}
