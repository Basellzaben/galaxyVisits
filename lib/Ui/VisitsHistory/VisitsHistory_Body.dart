import 'dart:async';
import 'dart:convert';
import 'package:galaxyvisits/Ui/VisitsInfoH/VisitsHistory_Body.dart';
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

class VisitsHistory_Body extends StatefulWidget {
  @override
  _VisitsHistory_Body createState() => _VisitsHistory_Body();
}

class _VisitsHistory_Body extends State<VisitsHistory_Body>   {
  Future <List<itemsinfo>> fetchData() async {
    Uri ItemsAPI = Uri.parse(Globalvireables.ItemsAPI+Globalvireables.username);
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
  List<Map<String, dynamic>> ss = [];
  TextEditingController ExpiryDatecontroler = TextEditingController();


  List<dynamic> _journals = [];
  List<dynamic> _journals2 = [];
  @override
  void initState() {
    _refreshItems();

    fillvisited();

    _refreshItems();
/*
datecontroler.text= DateTime.now().year.toString()+
    "-"+DateTime.now().month.toString()+"-"+DateTime.now().day.toString();

fillAll(datecontroler.text);
*/

  }
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController searchcontroler = TextEditingController();



  final TextEditingController datecontroler = TextEditingController();

  var cR=HexColor(Globalvireables.white3);

  var count =0;
  @override
  Widget build(BuildContext context) {

    return Container(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: HexColor(Globalvireables.white3),
            drawerEnableOpenDragGesture: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80), // Set this height
              child: Container(
                  height: 80,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 0.0)),
                      color: HexColor(Globalvireables.bluedark)),
                  child:
                  Center(child: Container(

                      margin: EdgeInsets.only(top: 18),

                      child: Text("سجل الزيارات",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w700),)))

                /*Row(
              children: [



              ],
            ),*/
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


                  /*  Container(
                    child: Text('الزيارات حسب تاريخ الزيارة'),
                    ),
*/ Container(
                            margin: EdgeInsets.only(left: 5,right: 5),
  child:   Row(



                      children: [

                          Container(

                            width: MediaQuery.of(context).size.width/6,

                            child: GestureDetector(

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
        Globalvireables.date=DateFormat('yyyy-MM-dd').format(selectedDate);

        setState(() {

        _refreshItems();

        });



        }

        });



      }, child: Container(

                              width: 30,

                              height: 30,

                              margin: EdgeInsets.only(left: 0,right: 0,top: 10),

                              alignment: Alignment.center,

                              child: Icon(

                                Icons.calendar_today_outlined,

                                size: 35.0,

                                color:HexColor(Globalvireables.basecolor),



                              )

                        )),

                          ),



                        Container(

                          width: MediaQuery.of(context).size.width/1.3,

                          margin: const EdgeInsets.only(top: 10, left: 0, right: 0),

                          //  alignment: Alignment.center,



                          child: TextFormField(

  onChanged: s(),

                            //readOnly: true,

                            controller: datecontroler,



                            decoration: InputDecoration(



                              prefixIcon: Icon(Icons.search),

                            //suffixIcon: Icon(Icons.close,color: Colors.red,),
                              suffixIcon: IconButton(
                                onPressed:(){
                                  datecontroler.clear();
                                  Globalvireables.date="";
                                },
                                icon: Icon(Icons.clear),
                              ),


                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor(Globalvireables.basecolor) , width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0)

                              ),



                              contentPadding: EdgeInsets.only(

                              top: 18, bottom: 18, right: 20, left: 20),

                              fillColor: Colors.white,

                              filled: true,

                              hintText: 'البحث',



                            ),

                      /*      onTap: () async {

                              await showDatePicker(

                                context: context,

                                initialDate: DateTime.now(),

                                firstDate: DateTime(2021),

                                lastDate: DateTime(2040),

                              ).then((selectedDate) {

                                if (selectedDate != null) {



                                  datecontroler.text =

                                      DateFormat('yyyy-MM-dd').format(selectedDate);

  setState(() {

    _refreshItems();

  });



                                }

                              });



                              //  calculatelongtimee();

                            },*/

                            validator: (value) {

                              if (value == null || value.isEmpty) {

                                return 'Please enter date.';

                              }

                              return null;

                            },

                          ))]),
),


                          if(_journals.length>0)
                           Container(
                              color: cR,
                              child: Container(
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _journals.length,
                                  itemBuilder: (context, index)
                                  =>Container(
                                    // height: 80,
                                    margin: EdgeInsets.only(top: 10,left: 10,right: 10),
                                      child: new GestureDetector(
                                        onTap: (){
                                          if(_journals[index]['name']!=null)
                                          Globalvireables.custselected=_journals[index]['name'];
                                          if(_journals[index]['name']!=null)
                                            Globalvireables.vtimeselected=_journals[index]['date'].toString().substring(0,10)+ " - "+_journals[index]['time'].toString();

                                          Globalvireables.visitno=_journals[index]['orederno'].toInt().toString();
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context) =>
                                                  VisitsInfoH_Body()
                                              )

                                          );


                                        },
                                      child: Card(
                                      child: Column(children: [
                                        if(_journals[index]['name']!=null)
                                          Container(margin: EdgeInsets.all(5),child: Text(_journals[index]['name'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700),)),
                                        if(_journals[index]['name']!=null)
                                          Container(margin: EdgeInsets.all(5),child: Text(_journals[index]['date'].toString().substring(0,10) + " - "+_journals[index]['time'].toString())),
                                      ],),
                                    ),)
                                  ),
                                ),
                              ),
                            )else
                            Container(
                                child: Container(
                                    padding: EdgeInsets.all(12.0),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 120),
                                      child: new Image.asset('assets/notfound.png'
                                        ,height:100 ,width:100 , ),

                                    ))
                              /* margin: EdgeInsets.only(top: 400),
                                child: Center(child: CircularProgressIndicator())*/
                            )])))));

  }




/*

  void _refreshItems() async {
    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);

print(Globalvireables.VisitsListAPI+"/"+Globalvireables.username +"    linkk");
    Uri apiUrl = Uri.parse(Globalvireables.VisitsListAPI+Globalvireables.username);
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
  print(data.toString()+"  dddatta ");

      setState(() {
        _journals = data;
      });


    */
/*  for(int i=0;i<_journals.length;i++){
        SQLHelper.createvisit(_journals[i]['OrderNo'],
            _journals[i]['CustomerNameA']
        ,_journals[i]['Tr_Data'],_journals[i]['Start_Time']);
      }
*//*




    }

   fillAll(String date) async {

    Uri apiUrl = Uri.parse(Globalvireables.VisitsListAPI+Globalvireables.username);
    http.Response response = await http.get(apiUrl);
    var data = await json.decode(response.body);
    print(data.toString()+"  dddatta ");

    setState(() {
      _journals = data;
    });

int x=0;
      for(var i=0;i<_journals.length;i++){
      if(_journals[i]['Tr_Data'].toString().contains(date)){
        setState(() {
          _journals2[x] = _journals[i];
          x++;
        });

      }
    }

setState(() {
  _journals=_journals2;
});
print( _journals.length.toString() +"ssss")
     ;

  }
*/


  void _refreshItems() async {

    //showLoaderDialog(context,"جار جلب العملاء");
    // showLoaderDialog(context);
String gg="";
var data;
data = await SQLHelper.GetVisited();

    if((datecontroler.text==null || datecontroler.text=="") && Globalvireables.date==""){
       data = await SQLHelper.GetVisited();
    }else {

      if(Globalvireables.date.contains("20") && (datecontroler.text!=null && datecontroler.text!="")){
        data = await SQLHelper.searchvisited(datecontroler.text);

      }

     else if(Globalvireables.date.contains("20") && (datecontroler.text==null || datecontroler.text=="")){
        data = await SQLHelper.searchvisiteddate(Globalvireables.date);

      }else{
        data = await SQLHelper.searchvisited(datecontroler.text);
      }

    }
    setState(() {
      _journals = data;
    });
    print( data.toString() +"jjjjj");

    print(data.length.toString()+" ghyt");


  }

s(){
  _refreshItems();
}
  fillvisited() async{
    Uri apiUrl = Uri.parse(Globalvireables.VisitsListAPI+Globalvireables.username);

    http.Response response = await http.get(apiUrl);
    SQLHelper.deletevisit();
    //List<String, dynamic> list = json.decode(response.body);
    var list = json.decode(response.body) as List;
    //await SQLHelper.deleteCustomers();

    for(var i=0;i<list.length;i++){
      await SQLHelper.createvisit(list[i]["OrderNo"],list[i]["CustomerNameA"],list[i]["Tr_Data"],list[i]["Start_Time"]);
      if(i==list.length-1){
      }
    }

  }


  clear(){
    datecontroler.clear();
    Globalvireables.date="";
  }

}