
// ignore_for_file: camel_case_types, deprecated_member_use, file_names

import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/DataBase/SQLHelper.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/Home/widget/Button_Widget.dart';
import 'package:galaxyvisits/Ui/Home/widget/GoogleMap.dart';
import 'package:galaxyvisits/Ui/Home/widget/Header_Widget.dart';
import 'package:galaxyvisits/Ui/UpdateData/Update_Body.dart';
import 'package:galaxyvisits/Ui/VisitsHistory/VisitsHistory_Body.dart';
import 'package:galaxyvisits/ViewModel/LoginViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/Drawers.dart';
import 'package:galaxyvisits/widget/customDiloag.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/CustomerViewModel.dart';
import '../../ViewModel/GlobalViewModel/HomeViewModel.dart';

class Home_Body extends StatefulWidget {
  const Home_Body({Key? key}) : super(key: key);

  @override
  _Home_Body createState() => _Home_Body();
}

class _Home_Body extends State<Home_Body> {
  clearSelectedItem() async {
    //await SQLHelper.clearItemsSelected();
    // await SQLHelper.clearImagesSelected();
  }

  @override
  void initState() {
    super.initState();
      final viewModel = context.read<CustomerViewModel>();
      final loginviewmodel = context.read<LoginViewModel>();
         WidgetsBinding.instance.addPostFrameCallback((_) async{
          loginviewmodel.GetManType();
    await  SQLHelper.getSettings().then((value) {
        viewModel.setSetting(value);
      if(value["isOpen"]==1) {
       viewModel.setCustomerName(value["cusName"]);
     viewModel.setCustomerNo(value["cusNo"]);
      viewModel.setisopen(value["isOpen"]);
      }
    });
viewModel.getCustomers();
    });
    var homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.fillvisited();
    homeViewModel.loadCustomPersonIcon();
    homeViewModel.loadcompanyIcon();
    SQLHelper.GetCustomers().then((value) => {
          if (value.isEmpty)
            {
              CustomDialog.showYesNoDialog(
                blendMode: BlendMode.clear,
                content: "يجب تحديث البيانات للحصول على افضل تجربه",
                title: "تحديث البيانات",
                context: context, //
                nobuttoncolorbackground: Colors.red.withOpacity(0.5),
                yesbuttoncolorbackground: HexColor(Globalvireables.basecolor),
                barrierDismissible: true,
                yesButtonText: "تحديث البيانات",
                noButtonText: "تم",
                onYesPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Update_Body()));
                },
                onNoPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          endDrawer: const HomeDrawers(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 8,
            selectedItemColor: HexColor(Globalvireables.white),
            unselectedItemColor: Colors.white,
            backgroundColor: HexColor(Globalvireables.basecolor),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.update,
                ),
                label: 'تحديث البيانات',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'الرئيسية'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_history), label: 'سجل الزيارات'),
            ],
            iconSize: 30,
            unselectedFontSize: 12,
            selectedFontSize: 16,
            showUnselectedLabels: true,
            currentIndex: selectedIndex,
            selectedIconTheme:
                IconThemeData(color: HexColor(Globalvireables.white)),
            onTap: _onItemTapped,
          ),
          drawerEnableOpenDragGesture: false,
          backgroundColor: HexColor(Globalvireables.white3),
          body: Container(
            margin: const EdgeInsets.only(top: 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: HexColor(Globalvireables.white3),
            child: Consumer<CustomerViewModel>(
              builder: (context, value, child) => LoadingWidget(
                isLoading: value.isloading,
                text: "جار بدء الزيارة يرجى الإنتظار",
                child: Stack(
                  children: [
                    HeaderWidget(),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.23,
                          ),
                          GoogleMapWidget()
                        ]),
                    ButtonWidget()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int selectedIndex = 1;
  final List<Widget> nav = [
    const Update_Body(),
    const Home_Body(),
    const VisitsHistory_Body(),
  ];

  _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        selectedIndex = index;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nav[index]),
        );
      });
    }
  }
}
