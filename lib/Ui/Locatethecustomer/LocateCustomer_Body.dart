import 'package:flutter/material.dart' hide Action;
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/Ui/Home/Home_Body.dart';
import 'package:galaxyvisits/Ui/Home/Home_Main.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:galaxyvisits/widget/loading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocateCustomer extends StatefulWidget {
  const LocateCustomer({Key? key}) : super(key: key);

  @override
  _LocateCustomer createState() => _LocateCustomer();
}

class _LocateCustomer extends State<LocateCustomer> {
  String currentTime = "";
  late int cc;

  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  String dropdownvalue = '';

//List<String> items ;

  List<String> items = [''];



  @override
  void initState() {
    super.initState();
  }

  final TextEditingController searchcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
             drawerEnableOpenDragGesture: false,
        backgroundColor: HexColor(Globalvireables.white3),
        appBar: AppBar(
           leading: BackButton(
            onPressed: () async{
            var customerviewModel = Provider.of<CustomerViewModel>(context, listen: false);
            //  await customerviewModel.getCustomers();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home_Body()));
            },
            
          color: Colors.white,
        ),
          backgroundColor: HexColor(Globalvireables.basecolor),
          title: const Center(child: Text('موقع العميل', textAlign: TextAlign.center,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          color: Colors.white
          ),)),

        ),
        body: Container(
          margin: const EdgeInsets.only(top: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor(Globalvireables.white3),
          child: Consumer2<CustomerViewModel,HomeViewModel>(
            builder: (context, model,value, child) => LoadingWidget(
              isLoading: model.isloading,
              text: 'جار حفظ موقع العميل يرجى الإنتظار',
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor(Globalvireables.white2),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: HexColor(Globalvireables.basecolor)),
                      ),
                       child: Center(
                         child: Text(
                          model.cusNo==0? "يرجى اختيار العميل من الصفحة الرئيسية": "العميل : ${model.CustomerName}"
                                             ),
                       )
              
                    ),
                  ),
              
                                  Card(
                    color: HexColor(Globalvireables.basecolor),
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: GoogleMap(
                        onTap: (LatLng latLng) {
                          model.setdata(latLng.latitude.toString(),
                              latLng.longitude.toString());
                        },
                        markers: {
                          Marker(
                            draggable: true,
                            onDrag: (value) 
                            => model.setdata(
                                value.latitude.toString(),
                                value.longitude.toString()),
              
                              markerId: const MarkerId('1'),
                              position:  
                            
                              
                                LatLng(double.parse(model.X_Lat), double.parse(model.Y_Long)),
                            
                                
                              
                              infoWindow: const InfoWindow(title: 'موقعي'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue)),
                        },
                        initialCameraPosition:
                            CameraPosition(target: _initialcameraposition),
                        mapType: MapType.normal,
                        onMapCreated: model.onMapCreated,
                        onLongPress: (value){
                          model.setdata(value.latitude.toString(), value.longitude.toString());
                        },
                        
                      ),
                    ),
                  ),
              Container(
                width: 300,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: HexColor(Globalvireables.white2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: HexColor(Globalvireables.white2)),
                ),
                child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor(Globalvireables.basecolor)
                    ),
                                  onPressed: () {
                                    model.updateCustomer(context);
                    // model.UpdateLocation();
                  },
                  child: const Text('حفظ موقع العميل',style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontSize: 20,
                  ),),
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
  
}
