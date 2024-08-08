// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/SalesManViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:provider/provider.dart';

class EmployeeData extends StatefulWidget {
  const EmployeeData({
    Key? key,
  }) : super(key: key);

  @override
  _EmployeeData createState() => _EmployeeData();
}

@override
class _EmployeeData extends State<EmployeeData> {
 

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    var textscalefactor = MediaQuery.of(context).textScaleFactor;
    double _h = MediaQuery.of(context).size.height;
    return Consumer<SalesManViewModel>(builder: (context, viewModel, child) {
      // create list view table to show data such 1 - name emplyee 2 - date 3 - start time 4 - end time 5 -note1 6 - note2 
     return Directionality(
      textDirection: TextDirection.rtl,
       child: Container(
        color: Colors.white,
        // create listview table to show data return card
        child:  AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: viewModel.salesManAttResult.length,
            itemBuilder: (BuildContext c, int i) {
              print(viewModel.salesManAttResult[i].endTime);
              return AnimationConfiguration.staggeredList(
                position: i,
                delay: Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  horizontalOffset: 30,
                  verticalOffset: 300.0,
                  child: FlipAnimation(
                    duration: Duration(milliseconds: 3000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    flipAxis: FlipAxis.y,
                    child: Container(
                      margin: EdgeInsets.only(bottom: _h * .02),
                      height: _h * .34,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor(Globalvireables.basecolor),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 
                                // رقم الموظف 
                                Container(
                                  child: Text(
                                    "رقم الموظف : ${viewModel.salesManAttResult[i].userID ?? ""}",
                                    style: TextStyle(
                                      fontSize: textscalefactor*15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                               Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                   "الموظف : ${viewModel.salesManAttResult[i].arabicName ?? ""}",
                                    style: TextStyle(
                                      fontSize: textscalefactor*15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                 // اضافة التاريخ + وقت بداية الدوام + وقت نهاية الدوام
                               
                              ],
                            ),
                           Divider(),
                           
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "التاريخ : ${viewModel.salesManAttResult[i].actionDateString }",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // اليوم 
                                    Text(
                                      "اليوم : ${viewModel.salesManAttResult[i].translateDayName(viewModel.salesManAttResult[i].dayNm) }",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              Divider(),
                            
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // وقت بداية الدوام
                                    Text(
                                      "وقت بداية الدوام : ${viewModel.salesManAttResult[i].startTime }",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // وقت نهاية الدوام
                                  (viewModel.salesManAttResult[i].endTime != null)?  Text(
                                      "وقت نهاية الدوام : ${viewModel.salesManAttResult[i].endTime ?? ""}",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ):
                                    Container(
                                      // create green decoration 
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                     "لم ينهي الدوام بعد ",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ),
                                  ],
                                ),
                              Divider(),  // اضافة موقع الدخول والخروج 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // موقع الدخول
                                    Text(
                                      "موقع الدخول : ${viewModel.salesManAttResult[i].startLocation ?? ""}",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // موقع الخروج
                                                                        Divider(),

                                     (viewModel.salesManAttResult[i].endTime != null)?   Text(
                                      "موقع الخروج : ${viewModel.salesManAttResult[i].endLocation ?? ""}",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ):
                                    Container(
                                      // create green decoration 
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(4),
                                      child: Text(
                                     "لم ينهي الدوام بعد ",
                                      style: TextStyle(
                                        fontSize: textscalefactor*15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
           ),
     );
    });
  }
}

    