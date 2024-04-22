
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:galaxyvisits/Ui/VisitDetails/VisitDetails_Body.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:provider/provider.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ButtonWidget createState() => _ButtonWidget();
}

class _ButtonWidget extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewModel, CustomerViewModel>(
        builder: (context, model, value, child) => value.cusNo == 0
            ? const SizedBox()
            : (value.isopen == 0
                ? Positioned(
                    bottom: 10,
                    left: 5,
                    right: 5,
                    child: Row(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(right: 5, left: 5, top: 5),
                          child: ElevatedButton(
                            onPressed: () {
                              value.setCustomerName("حدد العمــيل");
                              value.setCustomerNo(0.0);
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(right: 5, left: 5, top: 20),
                          height: 50,
                          width: MediaQuery.of(context).size.width / 1.5,
                          color: HexColor(Globalvireables.white),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  HexColor(Globalvireables.basecolor),
                            ),
                            child: Text(
                              "بدء الزيارة",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: HexColor(Globalvireables.white)),
                            ),
                            onPressed: () {
                              if (value.cusNo > 0) {
                                value.Startvisit(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                          title: Text('بدء الزيارة'),
                                          content: Text(
                                              'لا يمكن بدء الزيارة قبل اختيار عميل'),
                                        ));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Container(
                      margin: const EdgeInsets.only(right: 5, left: 5, top: 20),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.5,
                      color: HexColor(Globalvireables.white),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(Globalvireables.basecolor),
                        ),
                        child: Text(
                          "اغلاق الزيارة",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: HexColor(Globalvireables.white)),
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
                  )));
  }
}
