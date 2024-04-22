// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';


class Widgets {

  static Widget Appbar(BuildContext context,
  String title,String lan,[String? shown='true']) {

    if(lan=="EN"){
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(

        color:Colors.transparent,
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.5 ),
            ),
            const Spacer(),
           Container()
          ],
        ),
      ),
    );}else{
      return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          children: [
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 21.5 ),
            ),
            const SizedBox(
              width: 0,
            ),



          ],
        ),
      );
    }
  }


















}
