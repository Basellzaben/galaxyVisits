// ignore_for_file: non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, file_names, prefer_final_fields
import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:http/http.dart' as http;
import 'package:galaxyvisits/Respository/Repositry.dart';
import 'package:galaxyvisits/Ui/inventory/inventory_Body.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomerViewModel with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  late String myLocX;
  late String myLocY;
  var _distanceInMeters;
  String _startTime = "";
  String get startTime => _startTime;
  final _myRepo = HomeRepository();
  static List<Customer> _customers = [];
  List<Customer> get customers => _customers;
  late String X_Lat;
  late String Y_Long;
  late String Cutomer_Lat;
  late String Cutomer_Long;
  late String _CustomerName;
  String get CustomerName => _CustomerName;
  double _cusNo = 0.0;
  double get cusNo => _cusNo;
  int _isopen = 0;
  int get isopen => _isopen;
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> get journals => _journals;
  Timer? _timer;
  static List<Customer> _CustomerVisit = [];
  List<Customer> get CustomerVisit => _CustomerVisit;
  late Map<String, dynamic> settings;
  setSetting(Map<String, dynamic> setting) {
    settings = setting;
    notifyListeners();
  }

  setdata(String lat, String long) {
    X_Lat = lat;
    Y_Long = long;
    notifyListeners();
  }

  void setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  setMyLocation(String lat, String long) {
    myLocX = lat;
    myLocY = long;
    notifyListeners();
  }

  void setStartTime(String value) {
    _startTime = value;
    notifyListeners();
  }

  void setisopen(int value) {
    _isopen = value;
    notifyListeners();
  }

  void setCustomerNo(double value) {
    _cusNo = value;
    notifyListeners();
  }

  setCustomerLocation(String lat, String long) {
    Cutomer_Lat = lat;
    Cutomer_Long = long;
    notifyListeners();
  }

  Future<void> setJournals(List<Map<String, dynamic>> value) async {
    _journals = value;

    notifyListeners();
  }

  void setCustomerName(String value) {
    _CustomerName = value;
    notifyListeners();
  }

  void updateCustomer(BuildContext context) async {
    setisloading(true);
    if (_cusNo == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('الرجاء تحديد العميل'),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
      setisloading(false);
      return;
    } else {
      var index = _customers.indexWhere((element) => element.no == _cusNo);
      _customers[index].locX = X_Lat.toString();
      _customers[index].locY = Y_Long.toString();
      try {
        int cust = int.parse(_cusNo.toString().split(".")[0]);
        Uri apiUrl = Uri.parse(
            Globalvireables.UpdateLoc + "?no=$cust&locX=$X_Lat&locY=$Y_Long");
        var response = await http.post(apiUrl);
        if (response.body == "true") {
          final db = await SQLHelper.db();

          await db.execute(
            'UPDATE Customers SET locX = ?, locY = ? WHERE no = ?',
            [X_Lat, Y_Long, _cusNo],
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('تم حفظ الموقع بنجاح'),
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));
          setisloading(false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('حدث خطأ اثناء تحديث الموقع'),
            duration: const Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ));
          setisloading(false);
        }
        _CustomerVisit[1].locX = X_Lat.toString();
        _CustomerVisit[1].locY = Y_Long.toString();
        await getCustomers();
      } catch (e) {
        setisloading(false);
      }
      notifyListeners();
    }
  }

  void refreshItems() async {
    await setJournals(await SQLHelper.GetCustomers());
    notifyListeners();
  }

  void refreshSearch(String txt) async {
    var data = await SQLHelper.searchCustomers(txt);
    setJournals(data);
  }

  refrech(var txt) {
    refreshSearch(txt);
  }

  void onMapCreated(GoogleMapController _cntlr) async {
    Future.delayed(const Duration(seconds: 1), () async {
      _cntlr.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(double.parse(X_Lat), double.parse(Y_Long)),
              zoom: 17),
        ),
      );
    });
  }

  Future<void> getCustomers() async {
    if (_cusNo == 0.0) {
      _customers.clear();
      final db = await SQLHelper.db();
      final List<Map<String, dynamic>> maps = await db.query("Customers");
      List.generate(maps.length, (i) {
        _customers.add(Customer.fromMap(maps[i]));
        notifyListeners();
      });
      if (!_customers.any((marker) => marker.name == 'Current Location')) {
        _customers.add(
            Customer(name: 'Current Location', locX: myLocX, locY: myLocY));
        notifyListeners();
      }
    } else {
      if (!_CustomerVisit.any((marker) => marker.name == 'Current Location')) {
        _CustomerVisit.add(
            Customer(name: 'Current Location', locX: myLocX, locY: myLocY));
      }
      // get customer detaile where no = _cusNo
      final db = await SQLHelper.db();
      final List<Map<String, dynamic>> maps =
          await db.query("Customers", where: "no = ?", whereArgs: [_cusNo]);
      List.generate(maps.length, (i) {
        _CustomerVisit.add(Customer(
            name: maps[i]['name'],
            locX: maps[i]['locX'],
            locY: maps[i]['locY'],
            no: maps[i]['no']));
      });
    }
  }

  Future<void> calculateDistance(context) async {
    log(Globalvireables.nocustomer.toString(), name: "cusNo");
    if (Globalvireables.index == -1) {
      return;
    }
    log(myLocX);
    log(myLocY);
    _distanceInMeters = Geolocator.distanceBetween(
        double.parse(myLocX),
        double.parse(myLocY),
        double.parse(_customers[Globalvireables.index].locX!),
        double.parse(_customers[Globalvireables.index].locY!));
    log(_distanceInMeters.toString(), name: "distance");
    if (_distanceInMeters > 100) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content:
            const Text('تحذير انت خارج نطاق العميل الرجاء التأكد من الموقع'),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
    }
  }

  // make method to update function
  Future<void> updatelocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {}
    } else {
      Position _position = await Geolocator.getCurrentPosition();
      setMyLocation(
          _position.latitude.toString(), _position.longitude.toString());
    }
    Position _position = await Geolocator.getCurrentPosition();
    setMyLocation(
        _position.latitude.toString(), _position.longitude.toString());
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await updatelocation();
      await calculateDistance(BuildContext);
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<bool> Startvisit(
    BuildContext context,
  ) async {
    setisloading(true);
    try {
      Globalvireables.index =
          _customers.indexWhere((element) => element.no == _cusNo);
      Globalvireables.nocustomer = _cusNo;
      await calculateDistance(context);
    } catch (e) {
      setisloading(false);
      return false;
    }
    print(_distanceInMeters.toString());
    if (_distanceInMeters > 100) {
      Globalvireables.nocustomer = 0.0;
      Globalvireables.index = -1;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: const Text(
              'تحذير',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'لا يمكنك بدء الزيارة تبعد عن العميل مسافة اكثر من 100 متر',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('موافق'),
              ),
            ],
          );
        },
      );
      setisloading(false);
      return false;
    } else {
      _myRepo.StartsVisit().then((value) async {
        log(cusNo.toString());
        setStartTime(value.toString());
        setisopen(1);
        await SQLHelper.updateCusNo(_cusNo);
        await SQLHelper.updateIsOpen(1);
        await SQLHelper.updateCusName(_CustomerName);
        Globalvireables.nocustomer = _cusNo;
        Globalvireables.index =
            _customers.indexWhere((element) => element.no == _cusNo);
        setisloading(false);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => inventory_Body()));
        return true;
      }).onError((error, stackTrace) {
        setisloading(false);
        return false;
      });
    }
    return false;
  }
}
