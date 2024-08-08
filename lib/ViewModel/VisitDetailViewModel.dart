// ignore_for_file: non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, file_names, prefer_final_fields
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galaxyvisits/Models/datalist.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../GlobalVaribales.dart';
import '../Models/visitdetailadmin.dart';

class VisitDetailViewModel with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;
  int  _manNo = -1;
  int get manNo => _manNo;
  int _customerNo = -1;
  int get customerNo => _customerNo;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _fromDate =   DateFormat('dd-MM-yyyy').format(DateTime.now());
  String _toDate =DateFormat('dd-MM-yyyy').format(DateTime.now());
  String get fromDate => _fromDate;
  String get toDate => _toDate;
  List<Man> _manList=[];
  List<Man> get manList => _manList;
  List<CustomerBranch> _customer=[] ;
  List<CustomerBranch> get customer => _customer;
  List<Visit> _visitList =[];
  List<Visit> get visitList => _visitList;
  TextEditingController _fromDateController = TextEditingController(text:  DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController _toDateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController get fromDateController => _fromDateController;
  TextEditingController get toDateController => _toDateController;
   List<String>? _branchNames;
  List<String>? get branchNames => _branchNames;
  String? _value;
  String? get value => _value;
  setvalue(String value) {
    _value = value;
    notifyListeners();
  }
  setbranchNames(List<String> value) {
    _branchNames = value;
    notifyListeners();
  }
  setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }
    setvisitList(List<Visit> value) {
    _visitList = value;
    notifyListeners();
  }
setcustomerNo(int value) {
    _customerNo = value;
    notifyListeners();
  }
  setmanNo(int value) {
    _manNo = value;
    notifyListeners();
  }
setmanList(List<Man> value) {
    _manList = value;
    notifyListeners();
  }
  setcustomer(List<CustomerBranch> value) {
    _customer = value;
    notifyListeners();
  }
  void resetValues() {
    _fromDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _toDateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
  setfromDateController(String value) {
    _fromDateController.text = value;
    notifyListeners();
  }
  settoDateController(String value) {
    _toDateController.text = value;
    notifyListeners();
  }

  setFromDate(String value) {
    _fromDate = value;
    notifyListeners();
  }
  setToDate(String value) {
    _toDate = value;
    notifyListeners();
  }
 
  GetDropdownList() async {
    Uri apiUrl =
        Uri.parse(Globalvireables.DropDownlist + Globalvireables.manNo.toString());
try {
    http.Response response = await http.get(apiUrl);
    
    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> jsonData = json.decode(response.body);
      
      // Extract data from JSON and create model objects
      _customer = (jsonData['CustomerBranches'] as List)
          .map((item) => CustomerBranch.fromJson(item))
          .toList();
          setbranchNames((jsonData['CustomerBranches'] as List)
    .map((item) => CustomerBranch.fromJson(item).branchName)
    .toList());
    setvalue(_branchNames!.first);
    setmanList(
        setmanList((jsonData['Mans'] as List)
          .map((item) => Man.fromJson(item))
          .toList()));
      // _manList = (jsonData['Mans'] as List)
      //     .map((item) => Man.fromJson(item))
      //     .toList();
      print(_manList.length);
      // Now you have the data in model objects, you can use it as needed
      // For example, you can store it in state variables or use it directly
      
    } else {
      // Handle error
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (error) {
    // Handle exceptions
    print('Error fetching data: $error');
  }
}   
     GetlistVisitDetail() async {
      setisloading(true);
    Uri apiUrl =
        Uri.parse(Globalvireables.ListVisitDetail + _manNo.toString() + "/" +_fromDate +"/"+ _toDate +"/"+ customerNo.toString());
try {
  http.Response response = await http.get(apiUrl);
    
    if (response.statusCode == 200) {
      // Parse the JSON response
       List<dynamic> jsonData = json.decode(response.body);
       setvisitList(jsonData.map((data) => Visit.fromJson(data)).toList());
      
    setisloading(false);
    } else {
          setisloading(false);

      // Handle error
      print('Failed to load data: ${response.statusCode}');
    }
  
  } catch (error) {
        setisloading(false);

    // Handle exceptions
    print('Error fetching data: $error');
  }
}   
 GetData() async {
   setisloading(true);
   await GetDropdownList();
   await GetlistVisitDetail() ;
   setisloading(false);
   }   

  }

