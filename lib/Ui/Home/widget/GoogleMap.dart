// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:provider/provider.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    Key? key,
  }) : super(key: key);

  @override
  _GoogleMapWidget createState() => _GoogleMapWidget();
}

class _GoogleMapWidget extends State<GoogleMapWidget> {
  String currentTime = "";
  late int cc;
  String dropdownvalue = '';
  static const CameraPosition _kJordan = CameraPosition(
    target: LatLng(31.9539, 35.9106), // Centered on Jordan
    zoom: 10,
  );
  @override
  void initState() {
    super.initState();
     var customerViewModel =
        Provider.of<CustomerViewModel>(context, listen: false);

  }

  final TextEditingController searchcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewModel, CustomerViewModel>(
        builder: (context, model, value, child) {
      return value.customers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height * .55,
              child: Padding(
                padding: const EdgeInsets.only(right: 14, left: 14, top: 1),
                child: Card(
                  color: HexColor(Globalvireables.basecolor),
                  child: Container(
                      margin: const EdgeInsets.all(0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GoogleMap(
                              markers: Set.from(value.cusNo == 0.0
                                  ? value.customers.map((customer) => Marker(
                                        onTap: () {
                                          if (customer.name ==
                                              'Current Location') {
                                            return;
                                          }
                                          value.setCustomerName(customer.name!);
                                          value.setCustomerNo(customer.no!);
                                          value.CustomerVisit.clear();
                                          if (!value.CustomerVisit.any(
                                              (marker) =>
                                                  marker.name ==
                                                  'Current Location')) {
                                            value.CustomerVisit.add(Customer(
                                                name: 'Current Location',
                                                locX: model.X_Lat,
                                                locY: model.Y_Long));
                                          }
                                          value.CustomerVisit.add(Customer(
                                            name: customer.name,
                                            locX: customer.locX,
                                            locY: customer.locY,
                                            no: customer.no,
                                          ));
                                        },
                                        markerId: MarkerId(customer.name!),
                                        position: LatLng(
                                            double.parse(customer.locX!),
                                            double.parse(customer.locY!)),
                                        infoWindow: InfoWindow(
                                          title: customer.name,
                                        ),
                                        icon:
                                            customer.name == "Current Location"
                                                ? model.customPersonIcon
                                                : model.customcompanyicon,
                                      ))
                                  : value.CustomerVisit.map((customer) =>
                                      Marker(
                                        markerId: MarkerId(customer.name!),
                                        position: LatLng(
                                            double.parse(customer.locX ?? "0"),
                                            double.parse(customer.locY ?? "0")),
                                        infoWindow: InfoWindow(
                                          title: customer.name,
                                        ),
                                        icon:
                                            customer.name == "Current Location"
                                                ? model.customPersonIcon
                                                : model.customcompanyicon,
                                      ))),
                              initialCameraPosition: _kJordan,
                              mapType: MapType.normal,
                              onMapCreated: model.onMapCreated))),
                ),
              ),
            );
    });
  }
}
