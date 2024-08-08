// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:galaxyvisits/Models/visitdetailadmin.dart';
import 'package:galaxyvisits/ViewModel/VisitDetailViewModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../GlobalVaribales.dart';
import '../../../color/HexColor.dart';
import '../../../widget/ImageDialog.dart';

class DataVisit extends StatefulWidget {
  const DataVisit({
    Key? key,
  }) : super(key: key);

  @override
  _DataVisit createState() => _DataVisit();
}

@override
class _DataVisit extends State<DataVisit> {
  @override
  void initState() {
    super.initState();
    // final viewModel = context.read<VisitDetailViewModel>();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   viewModel.resetValues();
    // });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Consumer<VisitDetailViewModel>(builder: (context, viewModel, child) {
      if (viewModel.visitList.isEmpty) {
        return Image.asset(
          "assets/notfound.png",
          height: h,
          width: w,
          fit: BoxFit.cover,
        );
      }
      return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Container(
            color: HexColor(Globalvireables.white),
            child: AnimationLimiter(
                child: ListView.builder(
                    padding: EdgeInsets.all(w / 30),
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: viewModel.visitList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        delay: const Duration(milliseconds: 100),
                        child: SlideAnimation(
                          duration: const Duration(milliseconds: 2500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          verticalOffset: -250,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Container(
                              padding: EdgeInsets.all(w / 30),
                              margin: EdgeInsets.only(bottom: w / 30),
                              height: h * 0.35,
                              decoration: BoxDecoration(
                                color: HexColor(Globalvireables.white)
                                    .withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: HexColor(Globalvireables.basecolor)
                                        .withOpacity(0.4),
                                    blurRadius: 1,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "اسم المندوب : ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          viewModel.visitList[index].headerInfo!
                                              .arabicName
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: HexColor(
                                                Globalvireables.basecolor),
                                          )),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "رقم الحركة : ",
                                                style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables
                                                          .basecolor),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                viewModel.visitList[index]
                                                    .headerInfo!.visitOrderNo
                                                    .toString(),
                                                style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables
                                                          .basecolor),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "تاريخ الحركة : ",
                                                style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables
                                                          .basecolor),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                //format date as dd-mm-yy
                                                viewModel.visitList[index]
                                                    .headerInfo!.transDate
                                                    .toString()
                                                    .split("T")[0],

                                                style: TextStyle(
                                                  color: HexColor(
                                                      Globalvireables
                                                          .basecolor),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: HexColor(
                                                Globalvireables.basecolor),
                                          )),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0,top: 8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "وقت بداية الزيارة  : ",
                                                  style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('hh:mm a').format(DateFormat('HH:mm').parse( viewModel.visitList[index]
                                                      .headerInfo!.startTime
                                                      .toString()))
                                                 ,
                                                  style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "وقت نهاية الزيارة : ",
                                                  style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                                                       DateFormat('hh:mm a').format(DateFormat('HH:mm').parse( viewModel.visitList[index]
                                                      .headerInfo!.endTime
                                                      .toString())),                                               
                                                                                      
                                                  style: TextStyle(
                                                    color: HexColor(
                                                        Globalvireables
                                                            .basecolor),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    
                                    // add text in center with border radus about text
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: HexColor(
                                              Globalvireables.basecolor),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "العميل : ",
                                            style: TextStyle(
                                              color: HexColor(
                                                  Globalvireables.basecolor),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              viewModel.visitList[index]
                                                  .headerInfo!.name
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              softWrap:
                                                  true, // Allow text to wrap to new line
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Add Tow Icon Button In row 1-Button to show ImageVisit 2-Button to show Visit Details
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Add Icon Button to show ImageVisit
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: HexColor(
                                                Globalvireables.basecolor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: HexColor(
                                                  Globalvireables.basecolor),
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              _showImageVisitDialog(viewModel
                                                  .visitList[index]
                                                  .visitsImages);
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "صور الزيارة",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.image,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: HexColor(
                                                Globalvireables.basecolor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: HexColor(
                                                  Globalvireables.basecolor),
                                            ),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              _showCustomerStockDialog(viewModel
                                                  .visitList[index]
                                                  .customerStock);
                                            },
                                            child: const Row(
                                              children: [
                                                Text(
                                                  "تفاصيل الزيارة",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  Icons.info,
                                                  color: Colors.white,
                                                  size: 25,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    }))),
      );
    });
  }

  void _showCustomerStockDialog(List<CustomerStock>? customerStock) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var textscalefactor = MediaQuery.of(context).textScaleFactor;
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Directionality(
            textDirection:  ui.TextDirection.rtl,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                              child: Text(
                        "المادة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textscalefactor * 15,
                            fontWeight: FontWeight.bold),
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        "الكمية",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textscalefactor * 15,
                            fontWeight: FontWeight.bold),
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        "الكمية المقترحة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textscalefactor * 15,
                            fontWeight: FontWeight.bold),
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        "تاريخ انتهاء الصلاحية",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: textscalefactor * 15,
                            fontWeight: FontWeight.bold),
                      ))),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: customerStock?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        CustomerStock? stock = customerStock?[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  stock?.itemNameE ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: textscalefactor * 14,
                                      fontWeight: FontWeight.w600),
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  stock?.qty.toString() ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: textscalefactor * 14,
                                      fontWeight: FontWeight.w600),
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  stock?.orderQty.toString() ?? "",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: textscalefactor * 14,
                                      fontWeight: FontWeight.w600),
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  stock?.expiryDate.toString().split("T")[0] ??
                                      "",
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: textscalefactor * 14,
                                      fontWeight: FontWeight.w600),
                                ))),
                              ],
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: HexColor(Globalvireables.basecolor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'رجوع',
                      style: TextStyle(fontSize: textscalefactor * 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showImageVisitDialog(List<VisitsImages>? imagesVisit) {
    if (imagesVisit == null || imagesVisit.isEmpty) {
      // Handle the case where the images list is empty
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        var textscalefactor = MediaQuery.of(context).textScaleFactor;
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Directionality(
            textDirection:  ui.TextDirection.rtl,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: imagesVisit.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 25,
                          height: 25,
                          child: GestureDetector(
                            onTap: () {
                              showImageDialog(
                                  context,
                                  "http://${Globalvireables.connectIP}${imagesVisit[index].imgBase64}");
                            },
                            child: CachedNetworkImage(
                              imageUrl: "http://${Globalvireables.connectIP}${imagesVisit[index].imgBase64}",
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(Icons
                                  .error), // Optional: Error widget when failing to load
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: HexColor(Globalvireables.basecolor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      'رجوع',
                      style: TextStyle(fontSize: textscalefactor * 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showImageDialog(BuildContext context, String imgUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageDialog(imgUrl: imgUrl);
      },
    );
  }

}
