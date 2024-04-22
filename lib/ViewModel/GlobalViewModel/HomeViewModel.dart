// ignore_for_file: non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, avoid_print, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeViewModel with ChangeNotifier {
  String icon = "assets/images/CurrentLocation.png";
  String X_Lat = "0.0";
  String Y_Long = "0.0";
  String _startTime = "";
  Timer? _timer;
  BitmapDescriptor _customPersonIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor get customPersonIcon => _customPersonIcon;
  BitmapDescriptor _companyicon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor get customcompanyicon => _companyicon;
  bool _isloading = false;
  bool get isloading => _isloading;
  String get startTime => _startTime;


  void setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
  void setStartTime(String value) {
    _startTime = value;
    notifyListeners();
  }
  setData(
    String? lat,
    String? long,
  ) {
    X_Lat = lat!;
    Y_Long = long!;
    notifyListeners();
  }


  
  Future<void> UpdateLocation() async {
    var customerViewModel = CustomerViewModel();
    log("UpdateLocation");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {}
    } else {
      Position _position = await Geolocator.getCurrentPosition();

      setData(_position.latitude.toString(), _position.longitude.toString());
     
    }
    Position _position = await Geolocator.getCurrentPosition();

    setData(_position.latitude.toString(), _position.longitude.toString());
    if (!customerViewModel.customers
        .any((marker) => marker.name == 'Current Location')) {
      customerViewModel.customers.add(Customer(
          name: 'Current Location',
          locX: _position.latitude.toString(),
          locY: _position.longitude.toString()));
      print(customerViewModel.customers.length);
    }
    if (!customerViewModel.CustomerVisit.any(
        (marker) => marker.name == 'Current Location')) {
      customerViewModel.CustomerVisit.add(Customer(
          name: 'Current Location',
          locX: _position.latitude.toString(),
          locY: _position.longitude.toString()));
    }
  }


  void onMapCreated(GoogleMapController _cntlr) async {
    Future.delayed(const Duration(seconds: 2), () async {
      _cntlr.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(double.parse(X_Lat), double.parse(Y_Long)),
              zoom: 15),
        ),
      );
    });
  }


  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await UpdateLocation();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  fillvisited() async {
    Uri apiUrl =
        Uri.parse(Globalvireables.VisitsListAPI + Globalvireables.username);

    http.Response response = await http.get(apiUrl);
    SQLHelper.deletevisit();
    //List<String, dynamic> list = json.decode(response.body);
    var list = json.decode(response.body) as List;
    //await SQLHelper.deleteCustomers();

    for (var i = 0; i < list.length; i++) {
      await SQLHelper.createvisit(list[i]["OrderNo"], list[i]["CustomerNameA"],
          list[i]["Tr_Data"], list[i]["Start_Time"], list[i]["End_Time"]);
      if (i == list.length - 1) {}
    }
  }

  Future<Uint8List> _getBytesFromAsset(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<void> loadCustomPersonIcon() async {
    final Uint8List iconData = await _getBytesFromAsset('assets/employee.png');
    _customPersonIcon = BitmapDescriptor.fromBytes(iconData);
  }

  Future<void> loadcompanyIcon() async {
    final Uint8List iconData = await _getBytesFromAsset('assets/company.png');
    _companyicon = BitmapDescriptor.fromBytes(iconData);
  }

}


class Customer {
  int? id;
  String? name;
  String? personName;
  double? no;
  int? branchId;
  String? locX;
  String? locY;

  Customer({
    this.id,
    this.name,
    this.personName,
    this.no,
    this.branchId,
    this.locX,
    this.locY,
  });

  // Convert a Customer object into a Map object for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'person_name': personName,
      'no': no,
      'branchid': branchId,
      'locX': locX,
      'locY': locY,
    };
  }

  // Convert a Map object into a Customer object
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      personName: map['person_name'],
      no: map['no'],
      branchId: map['branchid'],
      locX: map['locX'],
      locY: map['locY'],
    );
  }
}
