import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'dart:math' as math;

import '../color/HexColor.dart';
class Widgets {

  static Widget Appbar(BuildContext context,
  String title,String lan,[String? shown='true']) {

    if(lan=="EN"){
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(

        color:Colors.transparent,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.5 ),
            ),
            Spacer(),
           Container()
          ],
        ),
      ),
    );}else{
      return Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            Spacer(),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.5 ),
            ),
            SizedBox(
              width: 0,
            ),



          ],
        ),
      );
    }
  }


















}
