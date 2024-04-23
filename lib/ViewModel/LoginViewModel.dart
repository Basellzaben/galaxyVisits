// ignore_for_file: non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, file_names
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/Models/UserDefinitionModel.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../GlobalVaribales.dart';
import '../Ui/Home/Home_Body.dart';

class LoginViewModel with ChangeNotifier {
  late SharedPreferences prefs;
  bool _check = false;
  bool get check => _check;
  String IpDevice = "";
  final TextEditingController namecontroler = TextEditingController();
  final TextEditingController passwordcontroler = TextEditingController();
  bool _isloading = false;
  bool get isloading => _isloading;

  void setIpDevice(String value) {
    IpDevice = value;
    notifyListeners();
  }

  void setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  void setcheck(bool value) {
    _check = value;
    notifyListeners();
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String?> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setIpDevice(androidInfo.id);
      return androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setIpDevice(iosInfo.identifierForVendor!);
      return iosInfo.identifierForVendor;
    }
    return null;
  }

  saveStringValue(String username) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
  }

  Future<List<UserDefinition>> fetchUserDefinitions(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      try {
        await SQLHelper.clearUserDefinition();
        for (var item in jsonList) {
          try {
            final db = await SQLHelper.db();
            await db.insert('UserDefinition', item);
          } catch (e) {
            print(e);
          }
        }
      } catch (e) {
        print(e);
      }

      return jsonList.map((json) => UserDefinition.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user definitions');
    }
  }

  Login(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString("username");
    if (namecontroler.text != value) {
      // await SQLHelper.deleteitems();
      //await SQLHelper.deleteCustomers();
    }
    saveStringValue(namecontroler.text);

    try {
      String? Ip = await _getId();
      UserDefinition? User = await SQLHelper.checkLoginAndGetUserData(
          namecontroler.text, passwordcontroler.text);
      try {
        try {
          await fetchUserDefinitions(Globalvireables.GetUser);
        } catch (e) {
          Uri apiUrl = Uri.parse(Globalvireables.loginAPI);
          final json = {
            "UserName": namecontroler.text,
            "Password": passwordcontroler.text,
            "IP_Device": IpDevice
          };

          http.Response response = await http.post(apiUrl, body: json);

          var jsonResponse = jsonDecode(response.body);
          Globalvireables.username = namecontroler.text;
          Globalvireables.email = jsonResponse["Email"];
          Globalvireables.manNo = jsonResponse["Id"];
          prefs.setString('username', namecontroler.text);
          prefs.setString('password', passwordcontroler.text);

          if (jsonResponse["Id"] != 0 && jsonResponse["IP"] != -2) {
            Position _position = await Geolocator.getCurrentPosition();
            var viewModel =
                Provider.of<CustomerViewModel>(context, listen: false);
            var HomeModel = Provider.of<HomeViewModel>(context, listen: false);
            await HomeModel.setData(
                _position.latitude.toString(), _position.longitude.toString());
            await viewModel.setdata(
                _position.latitude.toString(), _position.longitude.toString());
            setisloading(false);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home_Body()));
          } else if (jsonResponse["IP"] == -2) {
            setisloading(false);

            showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                      title: Text('تسجيل الدخول'),
                      content: Text('لا يمكنك تسجيل الدخول في عدة اجهزة'),
                    ));
          } else {
            setisloading(false);

            showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                      title: Text('تسجيل الدخول'),
                      content: Text('كلمة المرور او اسم المستخدم غير صحيح'),
                    ));
          }
        }
      } catch (e) {
        if (User != null) {
          if (Ip != User.ipDevice) {
            showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                      title: Text('تسجيل الدخول'),
                      content: Text('لا يمكنك تسجيل الدخول في عدة اجهزة'),
                    ));
          } else {
            Globalvireables.username = namecontroler.text;
            Globalvireables.email = User.email;
            Globalvireables.manNo = User.id;

            prefs.setString('username', namecontroler.text);
            prefs.setString('password', passwordcontroler.text);
            Position _position = await Geolocator.getCurrentPosition();
            var viewModel =
                Provider.of<CustomerViewModel>(context, listen: false);
            var HomeModel = Provider.of<HomeViewModel>(context, listen: false);
            await HomeModel.setData(
                _position.latitude.toString(), _position.longitude.toString());
            await viewModel.setdata(
                _position.latitude.toString(), _position.longitude.toString());
            setisloading(false);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home_Body()));
          }
        }
      }
    } catch (_) {
      setisloading(false);

      await showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('تسجيل الدخول'),
          content: Text('كلمة المرور او اسم المستخدم غير صحيح'),
          actions: <Widget>[],
        ),
      );
    }
  }

  Getrememper() async {
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString('password').toString().length > 1 &&
        prefs.getString('password').toString() != 'null') {
      setcheck(true);

      passwordcontroler.text = prefs.getString('password').toString();
      namecontroler.text = prefs.getString('username').toString();
    } else {
      passwordcontroler.text = '';
      namecontroler.text = '';
    }
  }
}
