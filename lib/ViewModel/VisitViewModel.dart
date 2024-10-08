// ignore_for_file: non_constant_identifier_names, unused_element, prefer_typing_uninitialized_variables, avoid_print, file_names
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/Ui/Home/Home_Body.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../GlobalVaribales.dart';
import '../Models/invertory.dart';
import 'GlobalViewModel/HomeViewModel.dart';

class VisitViewModel with ChangeNotifier {
  final picker = ImagePicker();
  bool _isloading = false;
  bool get isloading => _isloading;
  void setisloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  bool _isloading1 = false;
  bool get isloading1 => _isloading1;
  void setisloading1(bool value) {
    _isloading1 = value;
    notifyListeners();
  }

  List<Item> _journals = [];
  List<Item> get journals => _journals;
  int checkJournals = 1;
  SetCheckJournals(int value) {
    checkJournals = value;
    notifyListeners();
  }

  TextEditingController _InventoryQuantityController =
      TextEditingController(text: "0");
  TextEditingController _proposedOrderController =
      TextEditingController(text: "0");
  TextEditingController _ExpireDateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TextEditingController _NoteController =
      TextEditingController(text: "لا يوجد ملاحظات");
  TextEditingController get InventoryQuantityController =>
      _InventoryQuantityController;
  TextEditingController get proposedOrderController => _proposedOrderController;
  TextEditingController get ExpireDateController => _ExpireDateController;
  TextEditingController get NoteController => _NoteController;
  setInventoryQuantityController(TextEditingController value) {
    _InventoryQuantityController = value;
    notifyListeners();
  }

  setproposedOrderController(TextEditingController value) {
    _proposedOrderController = value;
    notifyListeners();
  }

  setExpireDateController(TextEditingController value) {
    _ExpireDateController = value;
    notifyListeners();
  }

  setNoteController(TextEditingController value) {
    _NoteController = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> itemselected = [];
  List<Map<String, dynamic>> imgs = [];
  List<Map<String, dynamic>> imgFORPOST = [];
  List<Map<String, dynamic>> itemselectedFORPOST = [];
  setdefault() {
    _InventoryQuantityController.text = "0";
    _proposedOrderController.text = "0";
    _ExpireDateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());
    _NoteController.text = "لا يوجد ملاحظات";
  }

  setitems(List<Item> value) {
    _journals = value;
    notifyListeners();
  }

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
      setimgs(await SQLHelper.GetImgs());
      setimgFORPOST(await SQLHelper.GetImgs());
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
    await SQLHelper.GetSelectedItem().then((value) => setitemsSelected(value));
    setitemsSelectedFORPOST(await SQLHelper.GetSelectedItemFORPOST());
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
    String Tr_Data = "${now.year}-${now.month}-${now.day}";
    var ViewModel = Provider.of<HomeViewModel>(context, listen: false);
    var customersViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);
    try {
      Uri apiUrl = Uri.parse(Globalvireables.VisitsPost);
      Map<String, dynamic> payload = {
        "Start_Time": "${Globalvireables.startTime}:00", //string
        "End_Time": "${Globalvireables.endTime}:00", // string
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
      print(json.encode(payload));
      print("${itemselectedFORPOST}itemselectedFORPOST");
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
          setitemsSelected(await SQLHelper.GetSelectedItem());
          final db = await SQLHelper.db();
          await db.delete("Images");
          var data = await SQLHelper.GetImgs();
          setimgs(data);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(" تم اغلاق الزيارة بنجاح , ${Globalvireables.username}"),
          ));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home_Body()),
              (route) => false);
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
        "Start_Time": "${Globalvireables.startTime}:00", //string
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

      List<Map<String, dynamic>> item =
          await SQLHelper.getPayloadItems(insertedId);
      List<Map<String, dynamic>> img =
          await SQLHelper.getPayloadImages(insertedId);
      print("${item}item");
      print("${img}img");

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
      setitemsSelected(await SQLHelper.GetSelectedItem());

      final db = await SQLHelper.db();
      await db.delete("Images");
      var data = await SQLHelper.GetImgs();
      setimgs(data);
      setisloading(false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home_Body()),
          (route) => false);
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
    var format = DateFormat("HH:mm");
    var start = format.parse(start_time);
    var end = format.parse(end_time);
    end = end.add(const Duration(days: 1));
    Duration diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    print('$hours hours $minutes minutes');
    Globalvireables.duration =
        "${end.hour - start.hour}:${end.minute - start.minute}";
    await SendData(context, "", "", "");
  }

  // If No Connection
  check_two_times_is_before_OffLine(
      BuildContext context, String start_time) async {
    String end_time = DateFormat("HH:mm").format(DateTime.now());
    print("start-visit$start_time  $end_time");
    var format = DateFormat("HH:mm");
    var start = format.parse(start_time);
    var end = format.parse(end_time);
    print("${start}startt  $end");
    print("${start}startt  $end");

    end = end.add(const Duration(days: 1));
    Duration diff = end.difference(start);
    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    print('$hours hours $minutes minutes');
    Globalvireables.duration =
        "${end.hour - start.hour}:${end.minute - start.minute}";
    await SendData(context, "", "", "");
  }

  Future<bool> Endvisit(BuildContext context) async {
    setisloading(true);
    var ViewModel = Provider.of<HomeViewModel>(context, listen: false);
    var customersViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);
    // get distance between customerviewmodel and homeviewmodel]
    try {
      double distance = Geolocator.distanceBetween(
        double.parse(ViewModel.X_Lat),
        double.parse(ViewModel.Y_Long),
        double.parse(customersViewModel.X_Lat),
        double.parse(customersViewModel.Y_Long),
      );
      if (distance > 100) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("يجب ان تكون على بعد اقل من 100 متر من العميل"),
        ));
        setisloading(false);
        return false;
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "حدث حطأ اثناء اعتماد بيانات الزيارة , يرجى التاكد من اتصال الانترنت"),
      ));
      setisloading(false);
      return false;
    }

    // if distance between two points is more than 100 meters

    Globalvireables.startTime = await SQLHelper.getStartTime();

    print("end-visit");
    try {
      Uri apiUrl = Uri.parse(Globalvireables.timeAPI);

      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);

      Globalvireables.endTime = jsonResponse.toString();
      print("$jsonResponse  end-timee");
      await check_two_times_is_before(context,
          "${Globalvireables.startTime}:00", "${Globalvireables.endTime}:11");

      return true;
    } catch (_) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text(
      //       "حدث حطأ اثناء اعتماد بيانات الزيارة , يرجى التاكد من اتصال الانترنت"),
      // ));
      check_two_times_is_before_OffLine(
          context, "${Globalvireables.startTime}:00");
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
    print("${data}data");
    try {
      List<Map<String, dynamic>>? data1;
      for (var item in data) {
        Uri apiUrl = Uri.parse(Globalvireables.VisitsPost);
        Map<String, dynamic> items = Map.from(item);
        // print type of varible
        // print(items[''].runtimeType);
        print(items['Start_Time'].toString().substring(0, 5));
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
        List<Map<String, dynamic>> itemselected =
            await SQLHelper.getPayloadItems(items['id']);
        List<Map<String, dynamic>> imgs =
            await SQLHelper.getPayloadImages(items['id']);
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
          "Start_Time": items['Start_Time'].toString().substring(0, 5), //string
          "End_Time": items['End_Time'], // string
          "CusNo": items['CusNo'], // double
          "ManNo": items['ManNo'], // integer
          "X_Lat": items['X_Lat'], // string
          "Y_Long": items['Y_Long'],
          "DayNum": items['DayNum'], //integer
          "Tr_Data": items['Tr_Data'], // string
          "Note": items['Note'], // string
          "Loct": items['Loct'], // addr
          "Duration": items['Duration'],
          "VisitsImageList": imgFORPOST,
          "CustomersStockModelList": itemselectedFORPOST,
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "تم ارسال الزيارة رقم ${item['id'].toString()} بنجاح")));
            // await SQLHelper.deletePayload(item['id']);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  "حدث حطأ اثناء اعتماد بيانات الزيارة رقم ${item['id'].toString()} , يرجى التاكد من اتصال الانترنت"),
            ));
          }
        } else {
          setisloading(false);
        }
      }
    } catch (_) {
      setisloading(false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "حدث حطأ اثناء اعتماد بيانات الزيارة , يرجى التاكد من اتصال الانترنت"),
      ));
    }
    setisloading(false);
  }

  void refreshItemsinv() async {
    setisloading1(true);
    SetCheckJournals(1); // loading
    var data = await SQLHelper.GetItems();
    setitems(data.map((itemMap) => Item.fromMap(itemMap)).toList());
    SetCheckJournals(2); // Loaded
    setisloading1(false);
  }

  Future<dynamic> refreshSearch(String txt) async {
    SetCheckJournals(1); // loading
    var data = await SQLHelper.search(txt);
    setitems(data.map((itemMap) => Item.fromMap(itemMap)).toList());
    SetCheckJournals(2); // Loaded
  }

  AddItem(int index) async {
    String parsedDate = convertDateFormat(_ExpireDateController.text);

    //convert expireydate to datetime
    var data = await SQLHelper.itemSelected(
      _journals[index].no!,
    );
    if (data.isNotEmpty) {
/*print("exx"+ss[0]['Qty']);*/
      int sumqty =
          data[0]['Qty'] + int.parse(_InventoryQuantityController.text);
      await SQLHelper.updateItem(
          sumqty,
          data[0]['id'],
          int.parse(_proposedOrderController.text),
          parsedDate,
          _NoteController.text);
    } else {
      //print("noexx"+ss[0]['Qty']);
      await SQLHelper.selectItem(
          _journals[index].name!,
          int.parse(_InventoryQuantityController.text),
          _journals[index].no!,
          int.parse(_proposedOrderController.text),
          parsedDate,
          _NoteController.text);
    }
    setitemsSelected(await SQLHelper.GetSelectedItem());
  }

  String convertDateFormat(String dateString) {
    // Parse the original date string
    DateFormat originalFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = originalFormat.parse(dateString);

    // Format to the new date string
    DateFormat newFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = newFormat.format(parsedDate);

    return formattedDate;
  }
}
