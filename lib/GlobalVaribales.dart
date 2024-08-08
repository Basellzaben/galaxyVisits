
// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Globalvireables {
  static String languageCode = Platform.localeName.split('_')[0];

  static String imageselected="";
  static String lantext="";
  static String visitno="";
  static int? ManType;


  //Colors
  static String basecolor="#273746";
 // static String basecolor="#6b3054";
  static String white="#ffffff";
  static String black="#121212";
  static String white3="#ECECEC";
  static String secondarycolor="#dd7826";
  static String white2="#E5E5E5";
  static String bluedark="#273746";
  static String green="#228B22";
  static String timeAPI="http://"+Globalvireables.connectIP+"/api/Login/GetDateTime";
  static String loginAPI="http://"+Globalvireables.connectIP+"/api/Login/PostUserDefinition";
  static String GetUser="http://"+Globalvireables.connectIP+"/api/Login/GetUserDefinition";
  static String ItemsAPI="http://"+Globalvireables.connectIP+"/api/Items/GetinvfByManId/";
  static String CustomersAPI="http://"+Globalvireables.connectIP+"/api/Customers/GetcusfByManId";
  static String VisitsPost="http://"+Globalvireables.connectIP+"/api/Visits/PostManVisit";
  static String UpdateManStatus="http://"+Globalvireables.connectIP+"/api/SalesMan/UpdateManStatus";
  static String GetManStatus="http://"+Globalvireables.connectIP+"/api/SalesMan/GetManStatus";
  static String GetAllSalesManAtt="http://"+Globalvireables.connectIP+"/api/SalesMan/GetAllSalesMan";
  static String VisitsListAPI="http://"+Globalvireables.connectIP+"/api/Visits/GetManVisitsList/";
  static String DropDownlist="http://"+Globalvireables.connectIP+"/api/Visits/GetfollowerMan/";
  static String ListVisitDetail="http://"+Globalvireables.connectIP+"/api/Visits/GetVisitDetails/";
  static String VisitsImageAPI="http://"+Globalvireables.connectIP+"/api/Visits/GetVisitsImagesList/";
  static String VisitsitemsAPI="http://"+Globalvireables.connectIP+"/api/Visits/GetCustomerStockList/";
  static String Getusertype="http://"+Globalvireables.connectIP+"/api/Login/Getusertype/";
  static String UpdateLoc="http://"+Globalvireables.connectIP+"/api/Customers/UpdateLoc";
  static String custselected="";
  static String vtimeselected="";
  static String startTimeselected="";
  static String dateTimeselected="";
  static String endTimeselected="";
  static String date="";
  static String name="";
  static String email="";
  static int sizeCustomers=0;
  static int sizeItems=0;

  static int manNo=-1;
  static String startTime="";
  static String endTime="";
  static String duration="";
  static double nocustomer=0.0;
  static int index=-1;
  static String username="";
  static var data;
  static List<String> itemsSpiner = [''];
  //"+Globalvireables.connectIP+" static ip
  //static String connectIP="37.220.121.20:3752";
  // static String connectIP="10.0.1.50:7580";
  //static String connectIP="10.0.1.60:92";
  //static String connectIP="10.0.1.120:9998";
  // static String connectIP="10.0.1.50:3755";
  // static String connectIP="10.0.1.60:9870";
  static String connectIP="192.168.20.106:1221";

  static TextStyle? styleHedear = GoogleFonts.aBeeZee(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
 static TextStyle? style1 = GoogleFonts.elsie(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
 static TextStyle? style2 = GoogleFonts.abel(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  
 


}