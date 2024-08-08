import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/SalesManViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PermanencyStatus_body extends StatefulWidget {
  const PermanencyStatus_body({Key? key}) : super(key: key);

  @override
  State<PermanencyStatus_body> createState() => _PermanencyStatus_bodyState();
}

class _PermanencyStatus_bodyState extends State<PermanencyStatus_body> {
  @override
  void initState() {
    super.initState();
    var ViewModel = Provider.of<SalesManViewModel>(context, listen: false);
    ViewModel.GetManStatus();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor(Globalvireables.basecolor),
              title: const Text(
                "حالة الدوام",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              centerTitle: true,
              leading: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white.withOpacity(0.8),
            body: SingleChildScrollView(
                child: Consumer<SalesManViewModel>(
                    builder: (context, model, child) => LoadingWidget(
                          isLoading: model.salesManModel == null
                              ? true
                              : model.isloading,
                          text: "جاري تحميل البيانات",
                          child: Column(children: [
                            // add appbarhere center text حالة الدوام وزر للعودة

                            Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.03),
                                        spreadRadius: 10,
                                        blurRadius: 3,
                                        // changes position of shadow
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 25, right: 15, left: 15),
                                  child: Column(children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: Image.asset(
                                                          "assets/img.jpg")
                                                      .image,
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                Globalvireables.manNo
                                                    .toString(),
                                                style: Globalvireables.style2),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(" : رقم الموظف",
                                                style: Globalvireables
                                                    .styleHedear),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 0.5,
                                              height: 40,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(Globalvireables.username,
                                                style: Globalvireables.style2),
                                            Text(" : الموظف",
                                                style: Globalvireables
                                                    .styleHedear),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      // Create tow widget on to the date and one to the time in this row
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                DateTime.now().day.toString() +
                                                    "/" +
                                                    DateTime.now()
                                                        .month
                                                        .toString() +
                                                    "/" +
                                                    DateTime.now()
                                                        .year
                                                        .toString(),
                                                style: Globalvireables.style2),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              "التاريخ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 0.5,
                                          height: 40,
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                                DateFormat('h:mm a')
                                                    .format(DateTime.now()),
                                                style: Globalvireables.style2),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              "الوقت الحالي",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Center(
                                      child: Text(
                                        "حالة الدوام",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // create tow row in this row create tow card
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Card(
                                            color: Colors.white,
                                            shadowColor: Colors.grey,
                                            elevation: 5,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    "نهاية الدوام",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  // text field to enter notes enrtry
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 10,
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: model.salesManModel
                                                                    .actionNo ==
                                                                2
                                                            ? Colors.green
                                                            : (model.salesManModel
                                                                        .actionNo ==
                                                                    1
                                                                ? Colors.blue
                                                                : Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Text(
                                                      model.salesManModel
                                                                  .actionNo ==
                                                              1
                                                          ? "في الدوام"
                                                          : (model.salesManModel
                                                                      .actionNo ==
                                                                  2
                                                              ? DateFormat(
                                                                      'h:mm a')
                                                                  .format(DateFormat(
                                                                          'HH:mm:ss')
                                                                      .parse(model
                                                                          .salesManModel
                                                                          .endTime!))
                                                              : "خارج الدوام"),
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Expanded(
                                          child: Card(
                                            color: Colors.white,
                                            shadowColor: Colors.grey,
                                            elevation: 5,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    "بداية الدوام",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            bottom: 5,
                                                            left: 10,
                                                            right: 10),
                                                    decoration: BoxDecoration(
                                                        color: model.salesManModel
                                                                    .actionNo ==
                                                                2
                                                            ? Colors.green
                                                            : (model.salesManModel
                                                                        .actionNo ==
                                                                    1
                                                                ? Colors.green
                                                                : Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Text(
                                                      model.salesManModel.actionNo == 2
                                                          ? DateFormat('h:mm a')
                                                              .format(DateFormat(
                                                                      'HH:mm:ss')
                                                                  .parse(model
                                                                      .salesManModel
                                                                      .startTime!))
                                                          : (model.salesManModel
                                                                      .actionNo ==
                                                                  1
                                                              ? DateFormat('h:mm a').format(
                                                                  DateFormat('HH:mm:ss')
                                                                      .parse(model
                                                                          .salesManModel
                                                                          .startTime!))
                                                              : "لم تبدأ دوامك"),
                                                      style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // create Text Field to enter notes
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              width: 2),
                                          shape: BoxShape.rectangle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white
                                                  .withOpacity(0.03),
                                              spreadRadius: 10,
                                              blurRadius: 3,
                                              // changes position of shadow
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                            right: 10),
                                        child: TextField(
                                          textAlign: TextAlign.right,
                                          controller: model.NoteController,
                                          decoration: InputDecoration(
                                              hintText: model.salesManModel
                                                          .actionNo ==
                                                      1
                                                  ? "اكتب ملاحظة للخروج"
                                                  : (model.salesManModel
                                                              .actionNo ==
                                                          2
                                                      ? "اكتب ملاحظة للخروج"
                                                      : "اكتب ملاحظة للدخول"),
                                              border: InputBorder.none,
                                              hintStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                    // add button to break or return from break
                                    // Container(
                                    //     margin: const EdgeInsets.only(
                                    //         top: 15, bottom: 15),
                                    //     child: MaterialButton(
                                    //       color: HexColor(Globalvireables.basecolor),
                                    //       shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(15)),
                                    //       padding: const EdgeInsets.only(
                                    //           top: 10,
                                    //           bottom: 10,
                                    //           left: 20,
                                    //           right: 20),
                                    //       onPressed: () async{
                                    //         model.salesManModel.breakStatus == 1
                                    //             ? await model.settype(4)
                                    //             : await model.settype(3);
                                    //         model.UpdateStatus(context);
                                    //       },
                                    //       child: Text(
                                    //         model.salesManModel.breakStatus == 1 ?
                                    //         "العودة من الاستراحة":
                                    //         "الذهاب الى الاستراحة"
                                            
                                    //         ,
                                    //         style: const TextStyle(
                                    //             fontSize: 15,
                                    //             fontWeight: FontWeight.bold,
                                    //             color: Colors.white),
                                    //       )
                                    //     )),
                                 
                                    


                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                model.salesManModel.actionNo ==
                                                        1
                                                    ? "انهاء الدوام"
                                                    : (model.salesManModel
                                                                .actionNo ==
                                                            2
                                                        ? "انهاء الدوام"
                                                        : "بدء الدوام"),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              MaterialButton(
                                                  color: HexColor(
                                                      Globalvireables
                                                          .basecolor),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          bottom: 10,
                                                          left: 20,
                                                          right: 20),
                                                  onPressed: ()async {
                                                    model.salesManModel
                                                                .actionNo ==
                                                            1
                                                        ? await model.settype(2)
                                                        : (model.salesManModel
                                                                    .actionNo ==
                                                                2
                                                            ? await model.settype(2)
                                                            :  await model.settype(1));
                                                    model.UpdateStatus(context);
                                                  },
                                                  child: Image.asset(
                                                    "assets/fingerprint.png",
                                                    color: HexColor(
                                                        Globalvireables.white),
                                                    width: 50,
                                                    height: 50,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 45,
                                    ),
                                    // create Table to Show status of start SHow notes and starttime
                                    model.salesManModel.actionNo == 1 ||
                                            model.salesManModel.actionNo == 2
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    width: 2),
                                                shape: BoxShape.rectangle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.03),
                                                    spreadRadius: 10,
                                                    blurRadius: 3,
                                                    // changes position of shadow
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          const Text(
                                                            "ملاحظات الدخول",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    left: 10,
                                                                    right: 10),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            child: Text(
                                                              model.salesManModel
                                                                          .notes ==
                                                                      null || model.salesManModel
                                                                          .notes == ""
                                                                  ? "لا يوجد ملاحظات"
                                                                  : model
                                                                      .salesManModel
                                                                      .notes!,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 0.5,
                                                        height: 40,
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                      ),
                                                      Column(children: [
                                                        const Text(
                                                          "بداية الدوام",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 5,
                                                                  left: 10,
                                                                  right: 10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Text(
                                                            model.salesManModel
                                                                        .startTime ==
                                                                    null
                                                                ? "لم تبدأ دوامك"
                                                                : DateFormat(
                                                                        'h:mm a')
                                                                    .format(DateFormat(
                                                                            'HH:mm:ss')
                                                                        .parse(model
                                                                            .salesManModel
                                                                            .startTime!)),
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ])
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    const Divider(),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    model.salesManModel.actionNo == 2
                                        ? Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    width: 2),
                                                shape: BoxShape.rectangle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white
                                                        .withOpacity(0.03),
                                                    spreadRadius: 10,
                                                    blurRadius: 3,
                                                    // changes position of shadow
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        const Text(
                                                          "ملاحظات الخروج",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 5,
                                                                  left: 10,
                                                                  right: 10),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Text(
                                                            model.salesManModel
                                                                        .notes2 ==
                                                                    null || model.salesManModel
                                                                        .notes2 == ""
                                                                ? "لا يوجد ملاحظات"
                                                                : model
                                                                    .salesManModel
                                                                    .notes2!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width: 0.5,
                                                      height: 40,
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                    ),
                                                    Column(children: [
                                                      const Text(
                                                        "نهاية الدوام",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 5,
                                                                bottom: 5,
                                                                left: 10,
                                                                right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Text(
                                                          model.salesManModel
                                                                      .endTime ==
                                                                  null
                                                              ? "لم تنهي دوامك"
                                                              : DateFormat(
                                                                      'h:mm a')
                                                                  .format(DateFormat(
                                                                          'HH:mm:ss')
                                                                      .parse(model
                                                                          .salesManModel
                                                                          .endTime!)),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                    ])
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ]),
                                )),
                          ]),
                        )))));
  }
}
