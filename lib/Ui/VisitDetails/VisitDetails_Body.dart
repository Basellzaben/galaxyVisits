import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';


import 'package:galaxyvisits/Ui/Home/Home_Body.dart';
import 'package:galaxyvisits/Ui/inventory/inventory_Body.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:barcode_scan/model/scan_result.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/services.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
class VisitDetails_Body extends StatefulWidget {
  @override
  _VisitDetails_Body createState() => _VisitDetails_Body();
}

class _VisitDetails_Body extends State<VisitDetails_Body>   {

  List<Map<String, dynamic>> imgs = [];
  List<Map<String, dynamic>> imgFORPOST = [];
  List<Map<String, dynamic>> itemselectedFORPOST = [];

  @override
  void initState() {


    setState(() {

      _refreshItems();
      _refreshselectedItems();

    });


  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  final TextEditingController searchcontroler = TextEditingController();

  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> itemselected = [];

int count =0;
  @override
  Widget build(BuildContext context) {

    if(itemselectedFORPOST.length<1){
      _refreshItems();
      _refreshselectedItems();
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor(Globalvireables.white3),
        drawerEnableOpenDragGesture: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200), // Set this height
          child: Container(
            height: 100,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 0.0)),
                color: HexColor(Globalvireables.bluedark)),
            child: Row(
              children: [
                Spacer(),
                Container(
                    margin: EdgeInsets.only(left: 5,right: 5,top: 17),
                    child: Text(
                  '???????????? ??????????????',
                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w800),
                )),


                Container(
                    margin: EdgeInsets.only(left: 8,right: 8,top: 17),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back_outlined,
                      size: 30.0,
                      color:HexColor(Globalvireables.white),

                    )
                ),

              ],
            ),
          ),
        ),
        body:Container(
          margin: EdgeInsets.only(top: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor(Globalvireables.white3),
          child: SingleChildScrollView(
            child: Column(
              children: [
               Row(
                  children: [
                    Spacer(),

                    Container(
                      width: 190,
                        margin: EdgeInsets.only(left: 5,right: 5,top: 5),
                        child: Text(
                         Globalvireables.CustomerName,
                          style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w800),
                        )),

                    Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                        child: Text(
                          ': ?????? ??????????????',
                          style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w400),
                        )),



                  ],
                ),

                Row(
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // shape: CircleBorder(),
                          primary: HexColor(Globalvireables.basecolor),
                        ),
                        child: Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            "?????????? ??????",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                        ),
                        onPressed: () {

                          _showPicker(context);

                        },
                      ),),
                  ],
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(

                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: imgs.length,
                    itemBuilder: (context, index)
                    => Container(

                      child: new InkWell(
                        onTap: () async {
                          setState(() {


                          });  },
                        child:

 Stack(
                        children: <Widget>[Container(
                              child: getImagenBase64(imgs[index]['ImgBase64'])
                          ),
                        new InkWell(
                          onTap: () async {
                            setState(() {
                              deleteImage(index);
                            });  }, child: Container(
                        height: 25,
                        color: HexColor(Globalvireables.white3),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Icon(Icons.close,color: Colors.red,),
                        ),
                      ))
                      ],
                    ),
                      ),
                    ),

                  ),
                ),

                Row(
                  children: [
                    Spacer(),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // shape: CircleBorder(),
                          primary: HexColor(Globalvireables.basecolor),
                        ),
                        child: Container(
                          width: 100,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Text(
                            "?????? ????????????",
                            style: TextStyle(fontSize: 18,color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                        },
                      ),),
                  ],
                ),
if(itemselected.length>0)
                Container(
                  margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                  child: Row(
                    children: [
                      Spacer(),
                      Spacer(),

                      Container(
                        width: 90,
                          child: Center(child: Container(
                              margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                              child: Text("?????????????? ????????????????",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)))
                      ),
Spacer(),
                      Container(
                          child: Center(child: Container(
                          margin: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                          child: Text("????????????           ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)))
                               ),
                      Spacer(),
                      Spacer(),

                      Container(
                          child: Center(child: Container(
                              margin: EdgeInsets.only(top: 5,bottom: 5,left: 30,right: 30),
                              child: Text("?????? ????????????",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),)))
                               ),




                    ],
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemselected.length,
                    itemBuilder: (context, index)
                    =>Container(
                      margin: EdgeInsets.only(top: 0,left: 10,right: 10),
                      child: Card(
                        child: Row(children: [
               new InkWell(
                  onTap: () async {
                  setState(() {
                    deleteItem(itemselected[index]['ItemNo']);

                     });  },
                          child: Center(
                            child: Container(
                                child: Icon(
                                  Icons.delete,
                                  size: 30.0,
                                  color:Colors.red,

                                )
                            ),
                          )),

                          Spacer(),

                          Container(
                              child: Center(child: Container(
                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                  child: Text(itemselected[index]['OrderQty'].toString(), textDirection:ui.TextDirection.rtl,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)))
                          ),
Spacer(),
                          Container(
                              child: Center(child: Container(
                                width: 50,
                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                  child: Text(itemselected[index]['Qty'].toString(), textDirection:ui.TextDirection.rtl,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)))
                          ),
                          Spacer(),
                          Spacer(),

                          Container(
                            width: 150,
                              child: Center(child: Container(
                                  margin: EdgeInsets.only(top: 5,bottom: 5),
                                  child: Text(itemselected[index]['name'],textAlign: TextAlign.center, textDirection:ui.TextDirection.rtl,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w700),)))
                          ),

                        ],),

                      ),
                    ),
                  ),



                )

,

                Center(
                  child: Row(children: [

                    Container(
                      height: 50,

                      width: MediaQuery.of(context).size.width/2.2,
                      margin: EdgeInsets.only(top: 20,left: 5,right: 5),

                      color:HexColor(Globalvireables.white),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:HexColor(Globalvireables.basecolor),
                        ),
                        child: Text(

                          "?????????? ??????????????"
                          ,style: TextStyle(color: HexColor(Globalvireables.white)),
                        ),
                        onPressed:
                            () async {

                          if(itemselectedFORPOST.length>0)
                            Endvisit();
                          else{
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('?????????? ??????????????'),
                                  content: Text('???? ???????? ?????????? ?????????????? ???????? ?????? ????????????'),
                                )
                            );

                          }

                        },
                      ),
                    ),

                    Spacer(),

                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/2.2,
                      margin: EdgeInsets.only(top: 20,left: 5,right: 5),
                      color:HexColor(Globalvireables.white),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:HexColor(Globalvireables.white2),
                        ),
                        child: Text(

                          "?????????? ??????????????"
                          ,style: TextStyle(color: HexColor(Globalvireables.black)),
                        ),
                        onPressed:
                            () async {
                              Globalvireables.CustomerName="?????? ????????????????";
                              Globalvireables.CustomerName="?????? ????????????????";
                              Globalvireables.cusNo=0;
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => Home_Body()));

                        },
                      ),
                    ),



                  ],),
                )





                ])))));

  }


  Widget getImagenBase64(String imagen) {
   String _imageBase64 = imagen;
    const Base64Codec base64 = Base64Codec();
    if (_imageBase64 == null) return new Container();
   Uint8List  bytes = base64.decode(_imageBase64);
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: 80,
      child: Image.memory(
        bytes,
        width: 80,
        fit: BoxFit.fitWidth,

      ),
    );
  }

  void _refreshItems() async {
    if(imgs.isEmpty) {
      var data = await SQLHelper.GetImgs();
      setState(() {
        imgs = data;
      });

     // var data2 = await SQLHelper.GetImgsFORPOST();
      setState(() {
        imgFORPOST = data;
      });


      print(data.toString() + " thiss");
    }
   }
   _showPicker(BuildContext context)  async{
   /* final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera ,
      imageQuality: 40
    );*/

   var imgFile = await picker.pickImage(
        source: ImageSource.camera,
            imageQuality: 40
    );
   final imageFile = File(imgFile!.path);

   File? selected = await ImagesCropper.cropImage(imageFile);



    setState(() {
      final imageFile = File(selected!.path).readAsBytesSync();
      String base64Image =  base64Encode(imageFile);
      saveImage(base64Image);

    });



  }





  saveImage(String base) async {
    await SQLHelper.createImage(base).then((value) => _refreshItems());
    var data = await SQLHelper.GetImgs();
    setState(() {
      imgs = data;
    });

  }
  void test(){
    print("thisJSON:  "+JsonEncoder().convert(itemselected));
                      }

  void _refreshselectedItems() async {
    //showLoaderDialog(context,"?????? ?????? ??????????????");
    // showLoaderDialog(context);

    var data = await SQLHelper.GetSelectedItem();
    setState(() {
      itemselected = data;
    });
    var data2 = await SQLHelper.GetSelectedItemFORPOST();
    setState(() {
      itemselectedFORPOST = data2;
    });

    test();


  }


  void deleteItem(String itemno) async {
   await SQLHelper.deleteselectedItem(itemno);

   _refreshselectedItems();
  }


  Endvisit() async {
    try {
      Uri apiUrl = Uri.parse(Globalvireables.timeAPI);

      http.Response response = await http.get(apiUrl);
      var jsonResponse = jsonDecode(response.body);

      setState(() {
        Globalvireables.endTime = jsonResponse.toString();
        print(jsonResponse.toString() + "  end-timee");
      });
      check_two_times_is_before(Globalvireables.startTime+":00",Globalvireables.endTime+":11");



    } catch(_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("?????? ?????? ?????????? ???????????? ???????????? ?????????????? , ???????? ???????????? ???? ?????????? ????????????????"),
      ));
    }




  }
  check_two_times_is_before(String start_time, String end_time){
    var format = DateFormat("HH:mm");




    var start = format.parse(start_time);
    var end = format.parse(end_time);
    print(start.toString()+"startt  "+end.toString());


      print(start.toString()+"startt  "+end.toString());

      end = end.add(Duration(days: 1));
      Duration diff = end.difference(start);
      final hours = diff.inHours;
      final minutes = diff.inMinutes % 60;
      print('$hours hours $minutes minutes');


      Globalvireables.duration=(end.hour-start.hour).toString()+":"+(end.minute-start.minute).toString();

    SendData(context,"","","");

  }
void SendData(BuildContext context,
    String Note,String Loct,String Duration)async {
  DateTime now = DateTime.now();
  int Nday = now.weekday;
  String Tr_Data = now.year.toString() + "-" + now.month.toString() + "-" +
      now.day.toString();

  try {

  Uri apiUrl = Uri.parse(Globalvireables.VisitsPost);

  String x = await JsonEncoder().convert(itemselectedFORPOST);


  Map<String, dynamic> payload = {
    "Start_Time": Globalvireables.startTime + ":00", //string
    "End_Time": Globalvireables.endTime + ":00", // string
    "CusNo": Globalvireables.cusNo, // double
    "ManNo": Globalvireables.manNo, // integer
    "X_Lat": Globalvireables.X_Lat, // string
    "Y_Long": Globalvireables.Y_Long,
    "DayNum": Nday, //integer
    "Tr_Data": Tr_Data /*"2022-03-30"*/, // string
    "Note": "Note", // string
    "Loct": "Loct", // addr
    "Duration": Globalvireables.duration,
    "CustomersStockModelList": itemselectedFORPOST,
    "VisitsImageList": /* [{"ImgBase64":Globalvireables.vv}]*/imgs
    /*  JsonEncoder().convert(imgFORPOST)*/
  };


  print("siize"+imgFORPOST.length.toString());
  print("jsonjsonjson : " + payload.toString());

  http.Response response = await http.post(apiUrl,
      headers: { "Content-Type": "application/json"},
      body: json.encode(payload));

  var jsonResponse = jsonDecode(response.body);


  print("wheen" + jsonResponse.toString());

if(jsonResponse.toString().length>10){
  if (jsonResponse["ManNo"] == Globalvireables.manNo) {


    Globalvireables.CustomerName="?????? ????????????????";
    Globalvireables.cusNo=0;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(" ???? ?????????? ?????????????? ?????????? , " +Globalvireables.username),


    ));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home_Body()));
  }
else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("?????? ?????? ?????????? ???????????? ???????????? ?????????????? , ???????? ???????????? ???? ?????????? ????????????????"),
    ));

}}else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("?????? ?????? ?????????? ???????????? ???????????? ?????????????? , ???????? ???????????? ???? ?????????? ????????????????"),
  ));
}

  } catch(_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("?????? ?????? ?????????? ???????????? ???????????? ?????????????? , ???????? ???????????? ???? ?????????? ????????????????"),
    ));
  }

}

deleteImage(int index) async {
  await SQLHelper.deleteImage(imgs[index]['id']);

  var data = await SQLHelper.GetImgs();
  setState(() {
    imgs = data;
  });

}

} class ImagesCropper {
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
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    return croppedImage;
  }
}