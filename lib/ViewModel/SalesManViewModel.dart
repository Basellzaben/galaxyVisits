// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/SalesManModel.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/datalist.dart';
import '../Models/salesmanmodellist.dart';
import 'CustomerViewModel.dart';
import 'package:http/http.dart' as http;

class SalesManViewModel with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  TextEditingController NoteController = TextEditingController();
  TextEditingController _fromDateController = TextEditingController(text:  DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController _toDateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController get fromDateController => _fromDateController;
  TextEditingController get toDateController => _toDateController;
  

  int _type = 0;
  int get type => _type;
  late SalesManModel _salesManModel;
  SalesManModel get salesManModel => _salesManModel;
   int _employeeNo = -1;
  int get customerNo => _employeeNo;
  List<Man> _manList=[];
  List<Man> get manList => _manList;
   String _fromDate =   DateFormat('dd-MM-yyyy').format(DateTime.now());
   String _toDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String get fromDate => _fromDate;
  String get toDate => _toDate;
  late List<SalesManAttResult> _salesManAttResult;
  List<SalesManAttResult> get salesManAttResult => _salesManAttResult;
  setfromDateController(String value) {
    _fromDateController.text = value;
    notifyListeners();
  }
  settoDateController(String value) {
    _toDateController.text = value;
    notifyListeners();
  }
  setfromDate(String value) {
    _fromDate = value;
    notifyListeners();
  }
  settoDate(String value) {
    _toDate = value;
    notifyListeners();
  }
  setemployeeNo(int value) {
    _employeeNo = value;
    notifyListeners();
  }

setmanList(List<Man> value) {
    _manList = value;
    notifyListeners();
  }
  void setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
void setsalesManAttResult(List<SalesManAttResult> value) {
    _salesManAttResult = value;
    notifyListeners();
  }
  Future<void> settype(int value) async{
    _type = value;
    notifyListeners();
  }
  void setsalesManModel(SalesManModel value) {
    _salesManModel = value;
    notifyListeners();
  }
  Future<void> GetManStatus()async{
    try {
      setisloading(true);
      Uri apiUrl = Uri.parse(Globalvireables.GetManStatus+"/"+Globalvireables.manNo.toString());
      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);
        SalesManModel salesManModel = SalesManModel.fromJson(jsonResponse);
        setsalesManModel(salesManModel);
        setisloading(false);
      
    } catch (e) {
      print(e);
      setisloading(false);
    }
    
  }

  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address =
            '${placemark.street}، ${placemark.locality}، ${placemark.country}';
        return address;
      } else {
        return 'Address not found';
      }
    } catch (e) {
      return 'Error getting address: $e';
    }
  }

  Future<String> getDeviceName(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.device;
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name;
    }
    return 'Unknown';
  }

  Future<void> UpdateStatus(BuildContext context) async {
    setisloading(true);
    // showLoaderDialog(context);
    CustomerViewModel customersViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);
    String address = await getAddressFromCoordinates(
        double.parse(customersViewModel.myLocX),
        double.parse(customersViewModel.myLocY));

    SalesManModel salesManModelend = SalesManModel(
      userID: Globalvireables.manNo,
      endLocation: address,
      endCoorX: customersViewModel.myLocX,
      endCoorY: customersViewModel.myLocY,
      notes2: NoteController.text,
    );
    String TabletName = await getDeviceName(context);
    SalesManModel salesManModelstart = SalesManModel(
        userID: Globalvireables.manNo,
        startLocation: address,
        coorX: customersViewModel.myLocX,
        coorY: customersViewModel.myLocY,
        tabletName: TabletName,
        notes: NoteController.text,
        );

    try {
      Uri apiUrl = Uri.parse(Globalvireables.UpdateManStatus+"/1");
      switch (_type) {
        case 0:
          _type = 0;
          setisloading(false);
          break;
        case 1:
          {
            http.Response response = await http.post(apiUrl,
                headers: {"Content-Type": "application/json"},
                body: json.encode(salesManModelstart));
            var jsonResponse = await jsonDecode(response.body);
            await GetManStatus();
            if (jsonResponse == 0) {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("تم بدء الدوام من قبل"),
              ));
              setisloading(false);
            }else if (jsonResponse == 1){
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("تم بدء الدوام"),
              ));
                          await GetManStatus();

              setisloading(false);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("حدث خطأ"),
              ));
            }
            break;
          }
        case 2:
          {
             apiUrl = Uri.parse(Globalvireables.UpdateManStatus+"/2");
            http.Response response = await http.post(apiUrl,
                headers: {"Content-Type": "application/json"},
                body: json.encode(salesManModelend));
            var jsonResponse = await jsonDecode(response.body);
            if (jsonResponse == 1) {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("تم انهاء الدوام"),
              ));
              await GetManStatus();

              setisloading(false);
            } else {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("حدث خطأ"),
              ));
              setisloading(false);
            }
            break;

          }
          case 3 :
          {
                apiUrl = Uri.parse(Globalvireables.UpdateManStatus+"/3");
            http.Response response = await http.post(apiUrl,
                headers: {"Content-Type": "application/json"},
                body: json.encode(salesManModelend));
            var jsonResponse = await jsonDecode(response.body);
            if (jsonResponse == 1) {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("تم تقديم مغادرة "),
              ));
              await GetManStatus();

              setisloading(false);
            } else {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("حدث خطأ"),
              ));
              setisloading(false);
            }
            break;
          }
          case 4 :
          {
                apiUrl = Uri.parse(Globalvireables.UpdateManStatus+"/4");
            http.Response response = await http.post(apiUrl,
                headers: {"Content-Type": "application/json"},
                body: json.encode(salesManModelend));
            var jsonResponse = await jsonDecode(response.body);
            if (jsonResponse == 1) {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("تم تسجيل العودة من مغادرة "),
              ));
              await GetManStatus();

              setisloading(false);
            } else {
              NoteController.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("حدث خطأ"),
              ));
              setisloading(false);
            }
          }
      }
    } catch (e) {
      setisloading(false);
      print(e);
    }
  }
    Future<void> GetAllSalesmanAtt()async{
    try {
      setisloading(true);
      Uri apiUrl = Uri.parse(Globalvireables.GetAllSalesManAtt+"/"+Globalvireables.manNo.toString()+"/"+_employeeNo.toString()+"/"+_fromDate+"/"+_toDate);
      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);
        List<SalesManAttResult> salesManModel = (jsonResponse as List)
          .map((item) => SalesManAttResult.fromJson(item))
          .toList();
        setsalesManAttResult(salesManModel);
        setisloading(false);
      
    } catch (e) {
      print(e);
      setisloading(false);
    }
    
  }
 Future<void> GetDropdownList() async {
    Uri apiUrl =
        Uri.parse(Globalvireables.DropDownlist + Globalvireables.manNo.toString());
try {
    http.Response response = await http.get(apiUrl);
    
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
             setmanList(
        setmanList((jsonData['Mans'] as List)
          .map((item) => Man.fromJson(item))
          .toList()));
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
  }
}   
}
