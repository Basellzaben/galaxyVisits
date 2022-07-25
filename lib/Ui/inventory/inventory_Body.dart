import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:barcode_scan/model/scan_result.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/itemsinfo.dart';
import 'package:galaxyvisits/Ui/VisitDetails/VisitDetails_Body.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class inventory_Body extends StatefulWidget {
  @override
  _inventory_Body createState() => _inventory_Body();
}

class _inventory_Body extends State<inventory_Body>   {
  Future <List<itemsinfo>> fetchData() async {
    Uri ItemsAPI = Uri.parse(Globalvireables.ItemsAPI+Globalvireables.username);



   /* http.Response response = await http.get(apiUrl);
    var jsonResponse = jsonDecode(response.body);

    // var parsedJson = json.decode(jsonResponse);
    data = itemsinfo.fromJson(jsonResponse);
    print(jsonResponse.toString()+"resssssspnse");
    return data;
*/

    //Uri ItemsAPI = Uri.parse(Globalvireables.ItemsAPI);
    final response = await http.get(ItemsAPI);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new itemsinfo.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  late Future <List<itemsinfo>>? futureData;
  var data;
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _controllers1 = [];
  List<TextEditingController> _controllers2 = [];
  List<Map<String, dynamic>> ss = [];


  List<Map<String, dynamic>> _journals = [];
  List<int> intArr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,];



  @override
  void initState() {
 //   futureData=fetchData();
  //  data=fetchData();
    _refreshItems();

  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController searchcontroler = TextEditingController();

  var cR=HexColor(Globalvireables.white3);

var count =0;
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor(Globalvireables.white3),
        drawerEnableOpenDragGesture: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(200), // Set this height
          child: Container(
            height: 150,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        MediaQuery.of(context).size.width, 0.0)),
                color: HexColor(Globalvireables.bluedark)),
            child: Row(
              children: [
                Container(
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
                ),
                new GestureDetector(
                  onTap: (){
                    barcodeScanning();
                  },
                child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 40,left: 10),

                    child: Icon(
                      Icons.camera_alt,
                      size: 30.0,
                      color: Colors.white,
                    )),)


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

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 50,
                    width: 150,
                   // margin: EdgeInsets.only(top: 100),
                    color:HexColor(Globalvireables.basecolor),
                    child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                        primary:HexColor(Globalvireables.basecolor),

                      ),
                      child: Text(
                        "تفاصيل الزيارة"
                        ,style: TextStyle(color: HexColor(Globalvireables.white)),
                      ),
                      onPressed:
                          () {
                        setState((){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VisitDetails_Body()));

                        });
                      },
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                  alignment: Alignment.bottomRight,
                  child: Container(
                  child: Text(":جرد المــواد",style: TextStyle(fontSize: 20),)
                  ),
                ),


         /*   FutureBuilder <List<itemsinfo>>(
                future: futureData,
                builder: (context, snapshot) {*/
                if(_journals.length>0)
                      Container(
                        color: cR,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _journals.length,
                          itemBuilder: (context, index)

                          =>Container(
                            margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                            child: Card(
                              child: Column(children: [
                                Center(
                                  child: Container(
                                    alignment: Alignment.center,
                                      child: Center(child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 15),
                                          child: Text(_journals[index]['name'], textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)))

                                  ),
                                ),


                                Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 5,bottom: 20),
                                      child: Center(
                                        child: Row(children: [

                                          Spacer(),
                                          Container(
                                            height: 50,
                                       width: 100,
                                       //       child: Center(child: Text(intArr[index].toString(),style: TextStyle(fontWeight: FontWeight.w800)))
                                              child: Container(
                                                child: Center(

                                                    child: Container(
                                                      child: TextField(
                                                        controller: _controllers[index],
                                                        onChanged: refrechtext(index),
                                                        textAlign: TextAlign.center,
                                                        keyboardType: TextInputType.number,
                                                        decoration: new InputDecoration(
                                                          filled: true,
                                                          fillColor: HexColor(Globalvireables.white),
                                                       //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                         // hintText: "البحث",
                                                          enabledBorder: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                                    )


                                                ),
                                              ) ),
                                          Spacer(),

                                          Text("        : كمية الجرد",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),


                                        ],),




                                      )),
                                ),
                                Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 5,bottom: 20),
                                      child: Center(
                                        child: Row(children: [

                                          Spacer(),
                                          Container(
                                              height: 50,
                                              width: 100,
                                              //       child: Center(child: Text(intArr[index].toString(),style: TextStyle(fontWeight: FontWeight.w800)))
                                              child: Center(

                                                  child: Container(
                                                    child: TextField(
                                                      controller: _controllers1[index],
                                                      onChanged: refrechtext(index),
                                                      textAlign: TextAlign.center,
                                                      keyboardType: TextInputType.number,
                                                      decoration: new InputDecoration(
                                                        filled: true,
                                                        fillColor: HexColor(Globalvireables.white),
                                                        //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                        // hintText: "البحث",
                                                        enabledBorder: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                                  )


                                              ) ),
                                          Spacer(),

                                          Text(" : الطلبية المقترحة",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),




                                        ],),




                                      )),
                                ),
                                Center(
                                  child: Container(
                                      margin: EdgeInsets.only(top: 5,bottom: 20),
                                      child: Center(
                                        child: Row(children: [

                                          Spacer(),
                                          Container(
                                              height: 60,
                                              width: 180,
                                              //       child: Center(child: Text(intArr[index].toString(),style: TextStyle(fontWeight: FontWeight.w800)))
                                              child: Center(

                                                child: GestureDetector(
                                                     child: Container(
                                                child: TextField(
                                                enabled: false,
                                                controller: _controllers2[index],
                                                onChanged: refrechtext(index),
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.number,
                                                decoration: new InputDecoration(
                                                  filled: true,
                                                  fillColor: HexColor(Globalvireables.white),
                                                  //   suffixIcon: new Icon(Icons.search,color: HexColor(Globalvireables.basecolor),),
                                                  // hintText: "البحث",
                                                  enabledBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                          ),
                                                    onTap: () async {


                                                      await showDatePicker(

                                                        context: context,

                                                        initialDate: DateTime.now(),

                                                        firstDate: DateTime(2021),

                                                        lastDate: DateTime(2040),

                                                      ).then((selectedDate) {

                                                        if (selectedDate != null) {



                                                          /* datecontroler.text =

        DateFormat('yyyy-MM-dd').format(selectedDate);*/
                                                       //   Globalvireables.date=DateFormat('yyyy-MM-dd').format(selectedDate);

                                                          setState(() {
                                                            _controllers2[index].text=DateFormat('yyyy-MM-dd').format(selectedDate);
                                                        //    _refreshItems();

                                                          });



                                                        }

                                                      });



                                                    })





                                              ) ),
                                          Spacer(),


                                           Container(

                                             child: Text(": تاريخ الصلاحية",
                                                  style: TextStyle(fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w500)),
                                           ),



                                        ],),




                                      )),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 0.0,bottom: 8),
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // shape: CircleBorder(),
                                      primary: HexColor(Globalvireables.basecolor),
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(shape: BoxShape.circle),
                                      child: Text(
                                        "أضـافة",
                                        style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
                                     // await SQLHelper.selectItem(_journals[index]['name'],intArr[index],_journals[index]['no']);


                                      if( _controllers[index].text.contains('-') || _controllers[index].text.contains(','))
                                        {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text("قيمة الكمية غير صحيحة"),
                                          ));
                                        }

if(_controllers[index].text.isEmpty)
  intArr[index]=0;
                                      AddItem(_journals[index]['no'],_journals[index]['name'],intArr[index],int.parse(_controllers1[index].text),_controllers2[index].text);

                                      _refreshItems();


                                      setState(() {



                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("تمت اضافة المادة"),
                                        ));

                                        /* cR=HexColor(Globalvireables.green);

                                        Timer(Duration(milliseconds:  10),
                                              ()=>
                                             cR=HexColor(Globalvireables.white3)
                                        );

*/
                                      });

                                    },
                                  ),),
                              ],),

                            ),
                          ),
                    ),
                        ),
                      )
                else
                 Container(
                      padding: EdgeInsets.all(12.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 120),
                        child: new Image.asset('assets/notfound.png'
                          ,height:100 ,width:100 , ),

                      ))

                /*;}else
                      Container(
                          margin: EdgeInsets.only(top: 400),
                          child: Center(child: CircularProgressIndicator()));*/
              /*        ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 75,
                              color: Colors.white,
                              child: Center(child: Text(data[index].title),
                              ),);
                          }
                      );*/
                 // })






              ])))));

  }


  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);

    int to;
      var data = await SQLHelper.GetItems();
      setState(() {
        _journals = data;
      });
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      print(data.toString() + " thiss");
      if(data.length>50)
        to=49;
      else{
        to=data.length;
      }
   for(var i=0;i<to;i++){
     intArr[i]=1;
     _controllers.add(new TextEditingController());
     _controllers[i].text=1.toString();

     _controllers1.add(new TextEditingController());
     _controllers1[i].text=0.toString();

     _controllers2.add(new TextEditingController());
     String formattedDate = formatter.format(now);
     _controllers2[i].text=formattedDate;

   }

      for(var i=0;i<to;i++){
        _controllers[i].text="1";

      }






  }


    void creatcounters(){



    }


   void add(int index) {
    if((int.parse( _controllers[index].text))>=1)
      setState(() {
    //    count=count+1;
        //intArr[index]=intArr[index]+1;
        _controllers[index].text=(int.parse(_controllers[index].text)+1).toString();
      });
  }
   void minues(int index) {
    if(int.parse( _controllers[index].text)>1)
      setState(() {
       // intArr[index]=intArr[index]-1;
        _controllers[index].text=(int.parse( _controllers[index].text)-1) as String;

      });
  }
  void refreshSearch(String txt) async {
    var data = await SQLHelper.search(txt);
    setState(() {
      _journals = data;
    });
   }

  void refreshSearchBarcode(String txt) async {
    var data = await SQLHelper.searchbar(txt);
    setState(() {
      _journals = data;
      print(data.toString()+" barr");
    });
  }

  refrech() {
    setState(() {
      refreshSearch(searchcontroler.text);
    });
  }

  Future barcodeScanning() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() {
searchcontroler.text=barcode.rawContent;
   //   refreshSearchBarcode(barcode.rawContent);
      print(barcode.rawContent+"  barcc");
      }/*print(barcode.rawContent+"  bars")*/);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
        //  cardnocontroler.text = 'No camera permission!';
        });
      } else {
       // setState(() => // cardnocontroler.text = 'Unknown error: $e');
      }
    } on FormatException {
    //  setState(() =>  cardnocontroler.text =
     // 'Nothing captured.');
    } catch (e) {
    //  setState(() =>  cardnocontroler.text = 'Unknown error: $e');
    }
  }


  AddItem(String no,String name,int qty,int sugg,String ex) async {

  var data=  await SQLHelper.itemSelected(no);
  setState(() {
    ss = data;
  });
 if(ss.length>0){
/*print("exx"+ss[0]['Qty']);*/
   int sumqty=ss[0]['Qty']+qty;
   await SQLHelper.updateItem(sumqty,ss[0]['id'],sugg,ex);
 }else{
   //print("noexx"+ss[0]['Qty']);
   await SQLHelper.selectItem(name,qty,no,sugg,ex);
 }
  }

  refrechtext(var index) {
try {
  intArr[index] = int.parse(_controllers[index].text);
} catch (err) {
  intArr[index]=1;
}
  }





}