// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:galaxyvisits/Ui/CustomersDialog.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  _HeaderWidget createState() => _HeaderWidget();
}

class _HeaderWidget extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.228,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
              bottom:
                  Radius.elliptical(MediaQuery.of(context).size.width, 0.0)),
          color: HexColor(Globalvireables.bluedark)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(children: [
                Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 18),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.supervised_user_circle_sharp,
                      size: 35.0,
                      color: HexColor(Globalvireables.white),
                    )),
                Container(
                    margin: const EdgeInsets.only(left: 0, right: 0, top: 17),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Globalvireables.username,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    )),
                const Spacer(),
                Container(
                    margin: const EdgeInsets.only(left: 5, right: 5, top: 18),
                    alignment: Alignment.centerLeft,
                    child: Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () async {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          size: 25.0,
                          color: HexColor(Globalvireables.white),
                        ),
                      );
                    })),
              ]),
            ),
          ),
          Consumer<CustomerViewModel>(
            builder: (context, value, child) => GestureDetector(
              onTap: () {
                if (value.isopen == 1) {
                  // show message cant select customer when visit is open
                  showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                            title: Text('لا يمكن اختيار عميل'),
                            content: Text(
                                'لا يمكن اختيار عميل عندما تكون الزيارة مفتوحة'),
                          ));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomersDialog()));
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10.0),
                      top: Radius.circular(10.0)),
                ),
                height: 60,
                margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
                width: MediaQuery.of(context).size.width / 1.1,
                child: Center(
                    child: Text(
                  value.CustomerName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
