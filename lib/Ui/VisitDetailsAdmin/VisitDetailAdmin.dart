
// ignore_for_file: camel_case_types, deprecated_member_use, file_names

import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/VisitDetailsAdmin/Widget/header.dart';
import 'package:galaxyvisits/ViewModel/VisitDetailViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:provider/provider.dart';
import '../Home/Home_Body.dart';
import 'Widget/datavisit.dart';

class VisitDetailAdmin extends StatefulWidget {
  const VisitDetailAdmin({Key? key}) : super(key: key);

  @override
  _VisitDetailAdmin createState() => _VisitDetailAdmin();
}

class _VisitDetailAdmin extends State<VisitDetailAdmin> {

  @override
  void initState() {
    super.initState();
      final viewModel = context.read<VisitDetailViewModel>();
         WidgetsBinding.instance.addPostFrameCallback((_) async{
        viewModel.GetData();
   
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: HexColor(Globalvireables.white3),
               appBar: AppBar(
           leading: BackButton(
            onPressed: () async{
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home_Body()));
            },
            
          color: Colors.white,
        ),
          backgroundColor: HexColor(Globalvireables.basecolor),
          title: const Center(child: Text('جرد العملاء', textAlign: TextAlign.center,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          color: Colors.white
          ),)),

        ),
            body: Container(
              margin: const EdgeInsets.only(top: 0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: HexColor(Globalvireables.white),
              child: Consumer<VisitDetailViewModel>(
                builder: (context, value, child) =>  SingleChildScrollView(
                    child:LoadingWidget(
                  isLoading: value.isloading,
                  text: "جار احضار البيانات",
                  child: Column(
                      children: [
                      
                        
                        SizedBox(
                          height: MediaQuery.of(context).size.height *.52,
                          child: const HeaderVisit()),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *.7,
                          child: const DataVisit()),
                      
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
