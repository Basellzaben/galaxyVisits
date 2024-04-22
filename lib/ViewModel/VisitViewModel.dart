// ignore_for_file: non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, avoid_print, file_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/Models/visitModel.dart';
import 'package:galaxyvisits/Ui/Home/Home_Body.dart';
import 'package:galaxyvisits/Ui/VisitDetails/VisitDetails_Body.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../GlobalVaribales.dart';
import '../Models/Qurblelist.dart';
import 'GlobalViewModel/HomeViewModel.dart';

class VisitViewModel with ChangeNotifier {
  final picker = ImagePicker();
  bool _isloading = false;
  bool get isloading => _isloading;
  void setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> itemselected = [];
  List<Map<String, dynamic>> imgs = [];
  List<Map<String, dynamic>> imgFORPOST = [];
  List<Map<String, dynamic>> itemselectedFORPOST = [];

  void setitemsSelected(List<Map<String, dynamic>> items) {
    itemselected = items;
    notifyListeners();
  }

  void setitemsSelectedFORPOST(List<Map<String, dynamic>> items) {
    itemselectedFORPOST = items;
    notifyListeners();
  }

  void setimgs(List<Map<String, dynamic>> items) {
    imgs = items;
    notifyListeners();
  }

  void setimgFORPOST(List<Map<String, dynamic>> items) {
    imgFORPOST = items;
    notifyListeners();
  }

  void refreshItems() async {
    if (imgs.isEmpty) {
      var data = await SQLHelper.GetImgs();
      setimgs(data);
      setimgFORPOST(data);

      // imgs = data;

      // var data2 = await SQLHelper.GetImgsFORPOST();
      // imgFORPOST = data;

      print(data.toString() + " thiss");
    }
  }

  saveImage(String base) async {
    await SQLHelper.createImage(base).then((value) => refreshItems());
    var data = await SQLHelper.GetImgs();
    setimgs(data);
    // imgs = data;
  }

  getimg() async {
    var data = await SQLHelper.GetImgs();
    setimgs(data);
    // imgs = data;
  }

  showPicker(BuildContext context) async {
    /* final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera ,
      imageQuality: 40
    );*/

    var imgFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 40);
    final imageFile = File(imgFile!.path);

    // File? selected = await ImagesCropper.cropImage(imageFile);

    // final imageFile1 = File(selected!.path).readAsBytesSync();
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    saveImage(base64Image);
  }

  Future<void> refreshselectedItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);

    var data = await SQLHelper.GetSelectedItem()
        .then((value) => setitemsSelected(value));
    // setState(() {
    // itemselected = data;
    // });
    var data2 = await SQLHelper.GetSelectedItemFORPOST();
    setitemsSelectedFORPOST(data2);
    // setState(() {
    // itemselectedFORPOST = data2;
    // });

    //  test();
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("رجوع"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("حذف"),
      onPressed: () {
        Navigator.pop(context);

        deleteItem(itemselected[index]['ItemNo']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("حذف"),
      content: const Text("هل انت متاكد من حذف الماده"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteItem(String itemno) async {
    await SQLHelper.deleteselectedItem(itemno);

    refreshselectedItems();
  }

  Future<void> SendData(
      BuildContext context, String Note, String Loct, String Duration) async {
    setisloading(true);
    DateTime now = DateTime.now();
    int Nday = now.weekday;
    String Tr_Data = now.year.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.day.toString();
    var ViewModel = Provider.of<HomeViewModel>(context, listen: false);
    var customersViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);
    try {
      Uri apiUrl = Uri.parse(Globalvireables.VisitsPost);
      Map<String, dynamic> payload = {
        "Start_Time": Globalvireables.startTime + ":00", //string
        "End_Time": Globalvireables.endTime + ":00", // string
        "CusNo": customersViewModel.cusNo, // double
        "ManNo": Globalvireables.manNo, // integer
        "X_Lat": ViewModel.X_Lat, // string
        "Y_Long": ViewModel.Y_Long,
        "DayNum": Nday, //integer
        "Tr_Data": Tr_Data /*"2022-03-30"*/, // string
        "Note": customersViewModel.CustomerName, // string
        "Loct": "Loct", // addr
        "Duration": Globalvireables.duration,
        "CustomersStockModelList": itemselectedFORPOST,
        "VisitsImageList": /* [{"ImgBase64":Globalvireables.vv}]*/ imgs
        /*  JsonEncoder().convert(imgFORPOST)*/
      };
      if (customersViewModel.cusNo == 0.0) {
        customersViewModel.setCustomerName("حدد العمــيل");
        customersViewModel.setCustomerNo(0);
        return;
      }
     print(itemselectedFORPOST.toString() + "itemselectedFORPOST");
      http.Response response = await http.post(apiUrl,
          headers: {"Content-Type": "application/json"},
          body: json.encode(payload));
      var jsonResponse = await jsonDecode(response.body);
      if (jsonResponse.toString().length > 10) {
        if (jsonResponse["ManNo"] == Globalvireables.manNo) {
          setisloading(false);
          // Navigator.of(context).pop();
          customersViewModel.setCustomerName("حدد العمــيل");
          customersViewModel.setCustomerNo(0);
          // Globalvireables.CustomerName = "حدد العمــيل";
          // Globalvireables.cusNo = 0;
          setisloading(false);
            await SQLHelper.updateCusNo(0.0);
      await SQLHelper.updateIsOpen(0);
      await SQLHelper.updateCusName("حدد العميل");
      await SQLHelper.clearData();
          customersViewModel.setCustomerName("حدد العمــيل");
          customersViewModel.setCustomerNo(0);
          customersViewModel.setisopen(0);
          await SQLHelper.clearItemsSelected();
          final db = await SQLHelper.db();
          await db.delete("Images");
          var data = await SQLHelper.GetImgs();
          setimgs(data);
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(" تم اغلاق الزيارة بنجاح , " + Globalvireables.username),
          ));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Home_Body()));
        } else {
          setisloading(false);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "حدث حطأ اثناء اعتماد بيانات الزيارة , يرجى التاكد من اتصال الانترنت"),
          ));
        }
      } else {
        setisloading(false);

        // Navigator.of(context).pop();
      }
    } catch (_) {
      String endTime = DateFormat("HH:mm").format(DateTime.now());
      Map<String, dynamic> payload = {
        "Start_Time": Globalvireables.startTime + ":00", //string
        "End_Time": endTime, // string
        "CusNo": customersViewModel.cusNo, // double
        "ManNo": Globalvireables.manNo, // integer
        "X_Lat": ViewModel.X_Lat, // string
        "Y_Long": ViewModel.Y_Long,
        "DayNum": Nday, //integer
        "Tr_Data": Tr_Data /*"2022-03-30"*/, // string
        "Note": customersViewModel.CustomerName, // string
        "Loct": "Loct", // addr
        "Duration": Globalvireables.duration,
        "CustomersStockModelList": "itemselectedFORPOST",
        "VisitsImageList": /* [{"ImgBase64":Globalvireables.vv}]*/
          "imgs"
        /*  JsonEncoder().convert(imgFORPOST)*/
      };
      int insertedId = await SQLHelper.insertPayload(payload);
      await SQLHelper.setPayloadItems(insertedId, itemselectedFORPOST);
      await SQLHelper.setPayloadImages(insertedId, imgs);


      List<Map<String, dynamic>> item = await SQLHelper.getPayloadItems(insertedId);
      List<Map<String, dynamic>> img = await SQLHelper.getPayloadImages(insertedId);
      print(item.toString() + "item");
      print(img.toString() + "img");

      // Navigator.of(context).pop();
        await SQLHelper.updateCusNo(0.0);
      await SQLHelper.updateIsOpen(0);
      await SQLHelper.updateCusName("حدد العميل");
      await SQLHelper.clearData();
      customersViewModel.setCustomerName("حدد العمــيل");
      customersViewModel.setCustomerNo(0);
      // Globalvireables.CustomerName = "حدد العمــيل";
      // Globalvireables.cusNo = 0;
      await SQLHelper.clearItemsSelected();
      final db = await SQLHelper.db();
      await db.delete("Images");
      var data = await SQLHelper.GetImgs();
      setimgs(data);
      setisloading(false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home_Body()));
      // Navigator.of(context).pop();
      customersViewModel.setCustomerName("حدد العمــيل");
      customersViewModel.setCustomerNo(0);
      customersViewModel.setisopen(0);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "تم حفظ الزيارة في الجهاز , يرجى الذهاب الى صفحة الزيارات لارسالها للسيرفر"),
      ));
      setisloading(false);
      // Navigator.of(context).pop();
    }
  }
  check_two_times_is_before(
      BuildContext context, String start_time, String end_time) async {
    print("start-visit" + start_time + "  " + end_time);
    var format = DateFormat("HH:mm");
    var start = format.parse(start_time);
    var end = format.parse(end_time);
    print(start.toString() + "startt  " + end.toString());
    print(start.toString() + "startt  " + end.toString());

    end = end.add(const Duration(days: 1));
    Duration diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    print('$hours hours $minutes minutes');
    Globalvireables.duration = (end.hour - start.hour).toString() +
        ":" +
        (end.minute - start.minute).toString();
    await SendData(context, "", "", "");
  }

  // If No Connection
  check_two_times_is_before_OffLine(
      BuildContext context, String start_time) async {
    String end_time = DateFormat("HH:mm").format(DateTime.now());
    print("start-visit" + start_time + "  " + end_time);
    var format = DateFormat("HH:mm");
    var start = format.parse(start_time);
    var end = format.parse(end_time);
    print(start.toString() + "startt  " + end.toString());
    print(start.toString() + "startt  " + end.toString());

    end = end.add(const Duration(days: 1));
    Duration diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    print('$hours hours $minutes minutes');
    Globalvireables.duration = (end.hour - start.hour).toString() +
        ":" +
        (end.minute - start.minute).toString();
    await SendData(context, "", "", "");
  }

  Future<bool> Endvisit(BuildContext context) async {
    setisloading(true);
      Globalvireables.startTime = await SQLHelper.getStartTime();

    print("end-visit");
    try {
      Uri apiUrl = Uri.parse(Globalvireables.timeAPI);

      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);

      Globalvireables.endTime = jsonResponse.toString();
      print(jsonResponse.toString() + "  end-timee");
      await check_two_times_is_before(context,
          Globalvireables.startTime + ":00", Globalvireables.endTime + ":11");
    
      return true;
    } catch (_) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(
      //       "حدث حطأ اثناء اعتماد بيانات الزيارة , يرجى التاكد من اتصال الانترنت"),
      // ));
      check_two_times_is_before_OffLine(
          context, Globalvireables.startTime + ":00");
      await SQLHelper.updateCusNo(0.0);
      await SQLHelper.updateIsOpen(0);
      await SQLHelper.updateCusName("حدد العميل");
      setisloading(false);
      return true;
    }
  }

  deleteImage(int index) async {
    await SQLHelper.deleteImage(imgs[index]['id']);

    var data = await SQLHelper.GetImgs();
    setimgs(data);
    // imgs = data;
  }
  // upload data to server 
  Future<void> uploadData(BuildContext context) async {
    setisloading(true);
    var data = await SQLHelper.getAllPayloads();
    print(data.toString() + "data");
    try{
      List<Map<String, dynamic>>? data1;
  for (var item in data) {
      Uri apiUrl = Uri.parse(Globalvireables.VisitsPost);
      Map<String,dynamic> items = Map.from(item);
      // print type of varible 
      // print(items[''].runtimeType);
      print(items['Start_Time'].toString().substring(0,5));
      print(items['End_Time']);
      print(items['CusNo']);
      print(items['ManNo']);
      print(items['X_Lat']);
      print(items['Y_Long']);
      print(items['DayNum']);
      print(items['Tr_Data']);
      print(items['Note']);
      print(items['Loct']);
      print(items['Duration']);
      List<Map<String, dynamic>> itemselected = await SQLHelper.getPayloadItems(items['id']);
      List<Map<String, dynamic>> imgs = await SQLHelper.getPayloadImages(items['id']);
      List<Map<String, dynamic>> itemselectedFORPOST = [];
      List<Map<String, dynamic>> imgFORPOST = [];
      for (var item in itemselected) {
        Map<String, dynamic> items = Map.from(item);
        items.remove('id');
        items.remove('payloadId');
        items.remove('itemName');
        itemselectedFORPOST.add(items);

      }
      for (var item in imgs) {
        Map<String, dynamic> items = Map.from(item);
        items.remove('payloadId');
        imgFORPOST.add(items);
      }
      

  Map<String, dynamic> payload = {
        "Start_Time": items['Start_Time'].toString().substring(0,5), //string
        "End_Time": items['End_Time'], // string
        "CusNo": items['CusNo'], // double
        "ManNo": items['ManNo'], // integer
        "X_Lat":  items['X_Lat'], // string
        "Y_Long": items['Y_Long'],
        "DayNum": items['DayNum'], //integer
        "Tr_Data": items['Tr_Data'], // string
        "Note": items['Note'], // string
        "Loct": items['Loct'], // addr
        "Duration": items['Duration'],
        "VisitsImageList": imgFORPOST,
        "CustomersStockModelList":itemselectedFORPOST,
};
       http.Response response = await http.post(apiUrl,
          headers: {"Content-Type": "application/json"},
          body: json.encode(payload));
      var jsonResponse = await jsonDecode(response.body);
      if (jsonResponse.toString().length > 10) {
        if (jsonResponse["ManNo"] == Globalvireables.manNo) {
          await SQLHelper.deleteItemById(item['id']);
          await SQLHelper.deleteImageById(item['id']);
          await SQLHelper.deletePayloadById(item['id']);
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: Text ("تم ارسال الزيارة رقم ${item['id'].toString()} بنجاح")
  ));
          // await SQLHelper.deletePayload(item['id']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            content: Text(
                "حدث حطأ اثناء اعتماد بيانات الزيارة رقم ${item['id'].toString()} , يرجى التاكد من اتصال الانترنت"),
          ));
        }
      } else {
        setisloading(false);
      }
  }

    }catch(_){
      setisloading(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "حدث حطأ اثناء اعتماد بيانات الزيارة , يرجى التاكد من اتصال الانترنت"),
      ));
    }
    setisloading(false);
  }
 
  
}
