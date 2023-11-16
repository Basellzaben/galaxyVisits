import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/rendering.dart';
import 'dart:io' as io;

import 'Home/Home_Body.dart';


class CustomersDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<CustomersDialog>
    with SingleTickerProviderStateMixin {
   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late http.Response response;
   List<Map<String, dynamic>> _journals = [];
   final TextEditingController searchcontroler = TextEditingController();

  @override
  void initState() {

   if(Globalvireables.journals.length<1)
    _refreshItems();
   else
    _journals =Globalvireables.journals;

  }


  @override
  Widget build(BuildContext context) {
  //  if(_journals.length>0)
return Container(
  child:   Center(
        child: Scaffold(

          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body:Container(
  child: SingleChildScrollView(
    child: Column(children: [
      Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100
              ,margin: EdgeInsets.only(top: 44),
              child: GestureDetector(
                onTap: () {},
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 25.0,
                    color: HexColor(Globalvireables.basecolor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, // add custom icons also
                ),
              ),
            ),
          ),
          Container(
          height: 100,
          width: MediaQuery.of(context).size.width/1.2,
          child: Container(
            height: 65,
            margin: EdgeInsets.only(top: 40,left: 10,right: 10),
            width: MediaQuery.of(context).size.width/1.3,
            child: TextField(
             controller: searchcontroler,
              onChanged: refrech(),
              textAlign: TextAlign.right,
              decoration: new InputDecoration(
                filled: true,
                fillColor: HexColor(Globalvireables.white),
                suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                hintText: "البحث",
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: HexColor(Globalvireables.basecolor)),
                ),
              ),
            ),
          )),




        ],
      ),
if(_journals.length>0)
      Container(
        height: MediaQuery.of(context).size.height,

          child: ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _journals.length,
            itemBuilder: (context, index)
            =>new GestureDetector(
              onTap: () {
              // setState(() {
                 Globalvireables.CustomerName=_journals[index]['name'];
                 Globalvireables.cusNo=_journals[index]['no'];

                 print(_journals[index]['no'].toString()+" nooo");
                 Navigator.pushAndRemoveUntil(
                   context,
                   MaterialPageRoute(builder: (context) => Home_Body()),
                       (Route<dynamic> route) => false,
                 );
               /*  Navigator.pop(context);
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Body()));
*/
             //  });
              },child: Container(
margin: EdgeInsets.only(top: 5),
                color: index %2==0 ? Colors.white:Colors.black26,
                height: 50,
                child: Center(child: Text(_journals[index]['name'],textAlign: TextAlign.center))
            ),)






          ),

      ) else
  Container(
      padding: EdgeInsets.all(12.0),
      child: Container(
        margin: EdgeInsets.only(top: 120),
        child: new Image.asset('assets/notfound.png'
           ),

      ))


    ],),
  ),
          )
        ),
      ),
);
  /*else
    return      Container(

        child: Scaffold(

        key: _scaffoldKey,
        backgroundColor: Colors.white,

            body: Container(
        margin: EdgeInsets.only(top: 400),
        child: Center(child: CircularProgressIndicator())
            )
        )
    );*/
  }
   void _refreshItems() async {

   //  showLoaderDialog(context);

     Globalvireables.journals = await SQLHelper.GetCustomers();
     setState(() {
       _journals =  Globalvireables.journals;
     });
   }
   showLoaderDialog(BuildContext context){
     AlertDialog alert=AlertDialog(
       content: new Row(
         children: [
           CircularProgressIndicator(),
           Container(margin: EdgeInsets.only(left: 7),child:Text("تسجيل الدخول ..." )),
         ],),
     );
     showDialog(barrierDismissible: false,
       context:context,
       builder:(BuildContext context){
         return alert;
       },
     );
   }

   refrech() {
     setState(() {
       refreshSearch(searchcontroler.text);
     });
   }

   void refreshSearch(String txt) async {
     var data = await SQLHelper.searchCustomers(txt);
     setState(() {
       _journals = data;
     });
   }




}


