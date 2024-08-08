import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/SalesManViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'widgets/employeelist.dart';
import 'widgets/headerfilteradmin.dart';

class PermanencyStatusAdmin extends StatefulWidget {
  const PermanencyStatusAdmin({Key? key}) : super(key: key);

  @override
  State<PermanencyStatusAdmin> createState() => _PermanencyStatusAdminState();
}

class _PermanencyStatusAdminState extends State<PermanencyStatusAdmin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  final viewModel = context.read<SalesManViewModel>();
         WidgetsBinding.instance.addPostFrameCallback((_) async{
        viewModel.GetDropdownList();
        viewModel.GetAllSalesmanAtt();
   
    });
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor(Globalvireables.basecolor),
              title: const Text(
                "دوام الموظفين",
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
                          isLoading: model.isloading,
                          text: "جاري تحميل البيانات",
                          child: Column(children: [
                          SizedBox(
                          height: MediaQuery.of(context).size.height *.43,
                          child: const HeaderFilter()),
                      SizedBox(
                          height: MediaQuery.of(context).size.height *.7,
                          child: const EmployeeData()),
                                     
                                 
                          ]),
                        )))));
  }
}
