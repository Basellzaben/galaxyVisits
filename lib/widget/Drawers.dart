// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:galaxyvisits/Ui/Locatethecustomer/Locatecustomer_main.dart';
import 'package:galaxyvisits/Ui/Login/Login_Body.dart';
import 'package:galaxyvisits/Ui/Permanency%20status/PermanencyStatus_body.dart';
import 'package:galaxyvisits/Ui/Permanency%20status/PermanencyStatus_main.dart';
import 'package:galaxyvisits/Ui/visitHistoryOffline/VisitHistoryOffLine.dart';
import 'package:galaxyvisits/widget/CustomWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawers extends StatefulWidget {
  const HomeDrawers({Key? key}) : super(key: key);

  @override
  _HomeDrawersState createState() => _HomeDrawersState();
}

class _HomeDrawersState extends State<HomeDrawers> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 225,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const CustomUserAccountsDrawerHeader(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text("موقع العميل"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LocateCustomer_Main(),
                ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_city),
              title: const Text("حالة الدوام"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PermanencyStatus_body()));

                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => PermanencyStatus_main(),
                // ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("زيارات لم يتم حفظها"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VisitHistoryOffLine()));

                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => PermanencyStatus_main(),
                // ));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("تسجيل الخروج"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('تسجيل الخروج',
                          style: TextStyle(fontSize: 22)),
                      content: const Text(
                        'هل أنت متأكد أنك تريد تسجيل الخروج ؟',
                        style: TextStyle(fontSize: 14),
                      ),
                      actions: [
                        TextButton(
                          //  textColor: Colors.black,
                          onPressed: () {
                            cleanRemember();

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Login_Body()));
                          },
                          child: const Text(
                            'تسجيل الخروج',
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 15),
                          ),
                        ),
                        TextButton(
                          // textColor: Colors.black,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'إلغاء',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 15),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  cleanRemember() async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString('username', '');
    prefs.setString('password', '');
  }
}
