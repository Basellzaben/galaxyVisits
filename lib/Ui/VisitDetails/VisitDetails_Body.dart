// ignore_for_file: deprecated_member_use, file_names, non_constant_identifier_names

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/VisitViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/Ui/Home/Home_Body.dart';
import 'package:galaxyvisits/Ui/inventory/inventory_Body.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import '../../widget/Widgets.dart';

// ignore: camel_case_types
class VisitDetails_Body extends StatefulWidget {
  const VisitDetails_Body({Key? key}) : super(key: key);

  @override
  _VisitDetails_Body createState() => _VisitDetails_Body();
}

// ignore: camel_case_types
class _VisitDetails_Body extends State<VisitDetails_Body> {
  @override
  void initState() {
    super.initState();
    var VisitviewModel = Provider.of<VisitViewModel>(context, listen: false);
    VisitviewModel.refreshItems();
    VisitviewModel.refreshselectedItems();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<VisitViewModel>();
      viewModel.getimg();
    });
  }

  final picker = ImagePicker();
  final TextEditingController searchcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var VisitviewModel = Provider.of<VisitViewModel>(context, listen: false);
    if (VisitviewModel.itemselectedFORPOST.isEmpty) {
      // ! todo
      VisitviewModel.refreshItems();
      VisitviewModel.refreshselectedItems();
    }
    var customersViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: HexColor(Globalvireables.white3),
            drawerEnableOpenDragGesture: false,
            appBar: AppBar(
              backgroundColor: HexColor(Globalvireables.basecolor),
              bottomOpacity: 800.0,
              leading: BackButton(
                onPressed: (() => Navigator.of(context).pop()),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 4.0,
              title: Widgets.Appbar(
                context,
                'تفاصيل الزيارة',
                'AR',
              ),
            ),
            body: Consumer<VisitViewModel>(
              builder: (context, model, child) => LoadingWidget(
                isLoading: model.isloading,
                text: 'جار اغلاق الزيارة',
                child: Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: HexColor(Globalvireables.white3),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        width: MediaQuery.of(context).size.width * .7,
                        child: Text(
                          customersViewModel.CustomerName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        ),
                        decoration: BoxDecoration(
                            color: HexColor(Globalvireables.white2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: HexColor(Globalvireables.basecolor))),
                      ),
                      model.imgs.isEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: const Text(
                                "لا يوجد صور مرفقة",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor(Globalvireables.white2),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: HexColor(
                                            Globalvireables.basecolor))),
                                margin: const EdgeInsets.only(top: 10),
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0.0,
                                    mainAxisSpacing: 0.0,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.imgs.length,
                                  itemBuilder: (context, index) => Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Container(
                                          child: getImagenBase64(
                                              model.imgs[index]['ImgBase64'])),
                                      Positioned(
                                        top: -5,
                                        right: -5,
                                        child: InkWell(
                                            onTap: () async {
                                              model.deleteImage(index);
                                            },
                                            child: const Align(
                                              alignment: Alignment.topRight,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              // shape: CircleBorder(),
                              backgroundColor:
                                  HexColor(Globalvireables.basecolor),
                            ),
                            child: Container(
                              width: 100,
                              height: 30,
                              alignment: Alignment.center,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: const Text(
                                "أرفاق صور",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              model.showPicker(context);
                            },
                          ),
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 2,
                        color: HexColor(Globalvireables.basecolor),
                      ),
                      if (model.itemselected.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              const Spacer(),
                              const Spacer(),
                              SizedBox(
                                  width: 90,
                                  child: Center(
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              left: 5,
                                              right: 5),
                                          child: const Text(
                                            "الطلبية المقترحة",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )))),
                              const Spacer(),
                              Center(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 5, right: 5),
                                      child: const Text(
                                        "الكمية           ",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ))),
                              const Spacer(),
                              const Spacer(),
                              Center(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 30,
                                          right: 30),
                                      child: const Text(
                                        "اسم المنتج",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ))),
                            ],
                          ),
                        ),
                      ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: model.itemselected.length,
                        itemBuilder: (context, index) => Container(
                          margin:
                              const EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Card(
                            color:Colors.white,
                            shadowColor:Colors.blue,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          model.showAlertDialog(context, index);
                                        },
                                        child: const Center(
                                          child: Icon(
                                            Icons.delete,
                                            size: 30.0,
                                            color: Colors.red,
                                          ),
                                        )),
                                    const Spacer(),
                                    // ignore: avoid_unnecessary_containers
                                    Container(
                                        child: Center(
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Text(
                                                  model.itemselected[index]
                                                          ['OrderQty']
                                                      .toString(),
                                                  textDirection:
                                                      ui.TextDirection.rtl,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )))),
                                    const Spacer(),
                                    Center(
                                        child: Container(
                                            width: 50,
                                            margin: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Text(
                                              model.itemselected[index]['Qty']
                                                  .toString(),
                                              textDirection:
                                                  ui.TextDirection.rtl,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700),
                                            ))),
                                    const Spacer(),
                                    const Spacer(),
                                    SizedBox(
                                        width: 150,
                                        child: Center(
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Text(
                                                  model.itemselected[index]
                                                      ['name'],
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      ui.TextDirection.rtl,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )))),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Text(
                                          model.itemselected[index]['Note']
                                              .toString(),
                                          // textDirection: ui.TextDirection.rtl,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                        )),
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: const Text(
                                          "ملاحظات :",
                                          textDirection: ui.TextDirection.rtl,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // shape: CircleBorder(),
                                backgroundColor:
                                    HexColor(Globalvireables.basecolor),
                              ),
                              child: Container(
                                width: 100,
                                height: 30,
                                alignment: Alignment.center,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: const Text(
                                  "جرد المواد",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            inventory_Body()));
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Row(
                          children: [
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    HexColor(Globalvireables.basecolor),
                              ),
                              child: Text(
                                "اغلاق الزيارة",
                                style: TextStyle(
                                    color: HexColor(Globalvireables.white)),
                              ),
                              onPressed: () async {
                                if (model.itemselectedFORPOST.isNotEmpty)
                                // ignore: curly_braces_in_flow_control_structures
                                if (model.imgFORPOST.isNotEmpty) {
                                 await model.Endvisit(context).then((istrue) {
                                    if (istrue) {
                                   
                                      Globalvireables.nocustomer = 0.0;
                                      Globalvireables.index = -1;
                                      // Globalvireables.CustomerName = "حدد العمــيل";
                                      // Globalvireables.CustomerName = "حدد العمــيل";
                                      // Globalvireables.cusNo = 0;
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Home_Body()));
                                    }
                                  });
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => const AlertDialog(
                                            title: Text('اغلاق الزيارة'),
                                            content: Text(
                                                'لا يمكن اغلاق الزيارة بدون صور للمواد'),
                                          ));
                                }
                                else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => const AlertDialog(
                                            title: Text('اغلاق الزيارة'),
                                            content: Text(
                                                'لا يمكن اغلاق الزيارة بدون جرد للمواد'),
                                          ));
                                }
                              },
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    HexColor(Globalvireables.white2),
                              ),
                              child: Text(
                                "الغاء الزيارة",
                                style: TextStyle(
                                    color: HexColor(Globalvireables.black)),
                              ),
                              onPressed: () async {
                                     await SQLHelper.updateCusNo(0.0);
                                     await SQLHelper.updateIsOpen(0);
                                     await SQLHelper.updateCusName("حدد العميل");
                                customersViewModel
                                    .setCustomerName("حدد العمــيل");
                                customersViewModel.setCustomerNo(0);
                                customersViewModel.setisopen(0);
                                Globalvireables.nocustomer = 0.0;
                                                                      Globalvireables.index = -1;

                                // Globalvireables.CustomerName = "حدد العمــيل";
                                // Globalvireables.CustomerName = "حدد العمــيل";
                                // Globalvireables.cusNo = 0;
                                final db = await SQLHelper.db();
                                await db.delete("Images");
                                var data = await SQLHelper.GetImgs();
                                await SQLHelper.clearItemsSelected();
                                var ViewModel = Provider.of<VisitViewModel>(
                                    context,
                                    listen: false);
                                ViewModel.setimgs(data);
                                      var customerviewModel = Provider.of<CustomerViewModel>(context, listen: false);
             await customerviewModel.getCustomers();
                                   Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home_Body()),
              (route) => false);
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    ]))),
              ),
            )));
  }

  Widget getImagenBase64(String imagen) {
    String _imageBase64 = imagen;
    const Base64Codec base64 = Base64Codec();
    Uint8List bytes = base64.decode(_imageBase64);
    return Container(
      decoration: BoxDecoration(
        color: HexColor(Globalvireables.white2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor(Globalvireables.basecolor)),
        shape: BoxShape.rectangle,
        backgroundBlendMode: BlendMode.dstOut,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      margin: const EdgeInsets.all(5),
      height: 100,
      width: 100,
      child: Image.memory(
        bytes,
        width: 80,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class ImagesCropper {
  static cropImage(File file) async {
    final File? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: HexColor(Globalvireables.basecolor),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    return croppedImage;
  }
}
