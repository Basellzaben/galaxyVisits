// ignore_for_file: camel_case_types, unnecessary_new, deprecated_member_use, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Models/CustomersModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:http/http.dart' as http;

import '../../widget/Widgets.dart';
import '../Home/Home_Body.dart';
import '../VisitsHistory/VisitsHistory_Body.dart';
class Update_Body extends StatefulWidget {
  const Update_Body({Key? key}) : super(key: key);

  @override
  _Update_Body createState() => _Update_Body();
}

class _Update_Body extends State<Update_Body>   {

  getcountcust() async {
    var data = await SQLHelper.GetCustomers();
    var data2 = await SQLHelper.GetItems();
     setState(() {
       Globalvireables.sizeItems=data2.length;
       Globalvireables.sizeCustomers=data.length;


     });
  }

  @override
  void initState() {
    super.initState();
    getcountcust();

  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController searchcontroler = TextEditingController();
bool isloading=false;
int _selectedValue = 1;

  @override
  Widget build(BuildContext context) {

    return LoadingWidget(
      isLoading: isloading,
      text: "جار تحديث البيانات",
      child: new WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(Globalvireables.basecolor),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.update,),
                label: 'تحديث البيانات',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_history),
                  label: 'سجل الزيارات'),
            ],
            iconSize: 30 ,
            unselectedFontSize: 12 ,
            selectedFontSize: 16 ,
            showUnselectedLabels: true,
            currentIndex: selectedIndex,
            selectedIconTheme:
            IconThemeData(color: HexColor(Globalvireables.white)),
            onTap: _onItemTapped,
          ),
      
          appBar: AppBar(
            backgroundColor: HexColor(Globalvireables.basecolor),
            bottomOpacity: 800.0,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 4.0,
            title: Widgets.Appbar(
              context,
              'تحديث البيانات',
              'AR',
            ),
          ),
          key: _scaffoldKey,
          drawerEnableOpenDragGesture: false,
          backgroundColor: HexColor(Globalvireables.white),
        //  endDrawer: NavDrawer(),
      
          body:Container(
            margin: const EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: HexColor(Globalvireables.white),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: new Image.asset('assets/update2.png'
                      ,height:200 ,width:300 , ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Card(
              child: Column(
              children: [
      
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: const Center(
                  child:Text("العملاء",style: TextStyle(color: Colors.black54,fontSize: 18),)
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:10),
              child: Center(
                    child:Text(Globalvireables.sizeCustomers.toString(),style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 40),)
              ),
            ),
                Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildRadioButtonWithText(3, 'كلاهما'),
            _buildRadioButtonWithText(2, 'عملاء الموظف البديل '),
            _buildRadioButtonWithText(1, 'عملائي'),
          ],
        ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 40,
                  width: MediaQuery.of(context).size.width/1.2,
                  color:HexColor(Globalvireables.white),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(Globalvireables.basecolor),
                    ),
                    child: Text(
                      "تحديث العملاء"
                      ,style: TextStyle(color: HexColor(Globalvireables.white)),
                    ),
                    onPressed:
                        () async {
      setState(() {
        isloading=true;
      });
                       await fillCustomers(context);
      setState(() {
        isloading=false;
      });
                        /*  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
      */
                    },
                  ),
                ),
      
      
              ])
                    ),
      
      
      
                  ),
      
      
                  Container(
                    margin: const EdgeInsets.all(15),
                    child: Card(
                        child: Column(
                            children: [
      
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: const Center(
                                    child:Text("المواد",style: TextStyle(color: Colors.black54,fontSize: 18),)
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top:10),
                                child: Center(
                                    child:Text(Globalvireables.sizeItems.toString(),style: TextStyle(color: HexColor(Globalvireables.basecolor),fontSize: 40),)
                                ),
                              ),
      
                              Container(
                                margin: const EdgeInsets.all(10),
                                height: 40,
                                width: MediaQuery.of(context).size.width/1.2,
                                color:HexColor(Globalvireables.white),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor(Globalvireables.basecolor),
                                  ),
                                  child: Text(
                                    "تحديث المواد"
                                    ,style: TextStyle(color: HexColor(Globalvireables.white)),
                                  ),
                                  onPressed:
                                      () async {
      
                                    // setState((){
                                      setState(() {
                                        isloading=true;
                                      });
                                      await fillItems(context,"جار تحديث المواد");
                                      setState(() {
                                        isloading=false;
                                      });
                                      /*   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>inventory_Body()));
      */
                                    // });
                                  },
                                ),
                              ),
      
      
                            ])
                    ),
      
      
      
                  )
      
      
      
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




  fillCustomers(BuildContext context,) async{
    try {
      Uri apiUrl = Uri.parse(
          "${Globalvireables.CustomersAPI}/${Globalvireables.username}/$_selectedValue");
           http.Response response = await http.get(apiUrl);
          if (response.statusCode == 200) {
              var list;
           try {
              list = json.decode(response.body) as List;
                } catch (e) {
              print('Error decoding JSON: $e');}
      await SQLHelper.deleteCustomers();
      if (list.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("لا يوجد عملاء")));
        // Navigator.pop(context);
      } else {
        for (var i = 0; i < list.length; i++) {
        try{
 await SQLHelper.createCustomers(
                   list[i]['Name'],  list[i]['Name'],  list[i]['No'] ?? 0,  list[i]['BranchId'] ?? -1, list[i]['LocX']?? "0" , list[i]['LocY'] ?? "0"
              );
        }catch(e){
          print(e.toString());
        }              
        }
      }
          ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text("تم تحديث العملاء بنجاح")));
      getcountcust();
      }else{
        // Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("يوجد مشكله في الإتصال بالخادم")));

      }
    }catch(e){
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(e.toString() +"يوجد مشكلة , يرجى المحاولة لاحقا")));
    }

  }

  fillItems(BuildContext context, String text) async{
    try {
    Uri apiUrl = Uri.parse(Globalvireables.ItemsAPI+Globalvireables.username);

    // showLoaderDialog(context,text);
    http.Response response = await http.get(apiUrl);
    if (response.statusCode == 200) {

      print("ggggg"+response.body.toString());
    //List<String, dynamic> list = json.decode(response.body);
    var list = await json.decode(response.body) as List;
    SQLHelper.deleteitems();
 //   await SQLHelper.createCustomers(list[i]["Name"],list[i]["Person"],list[i]["No"]);


   if(list.isEmpty){

    //  Navigator.pop(context);

     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       content: Text("لا يوجد مواد")));



   }else{
    for(var i=0;i<list.length;i++){
      print(list[i]["barcode"]);
      double price=0.00;
      String Item_Name="";
      String Unit="0.00";
      String Item_No="-1";
      String barcode="";
      if(list[i]["Price"]!=null){
        price=list[i]["Price"];
      }
      if(list[i]["Item_Name"]!=null){
        Item_Name=list[i]["Item_Name"];
      }
      if(list[i]["Item_No"]!=null){
        Item_No=list[i]["Item_No"];
      }
      if(list[i]["Unit"]!=null){
        Unit=list[i]["Unit"];
      }
      if(list[i]["barcode"]!=null){
        barcode=list[i]["barcode"];
      }
      await SQLHelper.createitems(Item_Name,
     Unit,price,Item_No,barcode);
      print("count :"+i.toString()+"  Item_No="+Item_No.toString());

    }
    // Navigator.pop(context);
    }

    getcountcust();

 }else{
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("يوجد مشكلة , يرجى المحاولة لاحقا")));
    }}catch(err){
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(err.toString() +"يوجد مشكلة , يرجى المحاولة لاحقا...")));
  // Navigator.pop(context);
     }
  }
  int selectedIndex = 0;
  final List<Widget> nav = [
    const Update_Body(),
    const Home_Body(),
    const VisitsHistory_Body(),
  ];
  _onItemTapped(int index) {


    if(index != 0){
      setState(() {
        selectedIndex = index;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });}
    
}
     Widget _buildRadioButtonWithText(int value, String text) {
    return Column(
      children: [
        Radio<int>(
          value: value,
          groupValue: _selectedValue,
          onChanged: (int? newValue) {
            setState(() {
              _selectedValue = newValue!;
            });
          },
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}