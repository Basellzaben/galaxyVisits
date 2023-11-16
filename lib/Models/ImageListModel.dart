import 'package:flutter/cupertino.dart';

//Doctor.dart

class ImageListModel {
  double? ID;
  String? CustomerNo;
  String? UserNo;
  String? Visit_OrderNo;
  String? Order_No;
  String? OrderDate;
  String? ImageTime;

  String? ImageDesc;
  String? ImgBase64;
  String? Item_Name;
  String? Ename;


  ImageListModel(
      {this.ID,
        this.CustomerNo,
        this.UserNo,
        this.Order_No,
        this.ImageTime,
        this.OrderDate,
        this.Visit_OrderNo,

        this.ImageDesc,
        this.ImgBase64,
        this.Item_Name,
        this.Ename,
      });

  ImageListModel.fromJson(Map<String, dynamic> json) {
    ID = json['ID'];
    CustomerNo = json['CustomerNo'];
    UserNo = json['UserNo'];
    Order_No = json['Order_No'];
    OrderDate = json['OrderDate'];
    ImageTime = json['ImageTime'];
    Visit_OrderNo = json['Visit_OrderNo'];

    ImageDesc = json['ImageDesc'];
    ImgBase64 = json['ImgBase64'];
    Item_Name = json['Item_Name'];
    Ename = json['Ename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.ID;
    data['CustomerNo'] = this.CustomerNo;
    data['UserNo'] = this.UserNo;
    data['Order_No'] = this.Order_No;
    data['OrderDate'] = this.OrderDate;
    data['ImageTime'] = this.ImageTime;
    data['Visit_OrderNo'] = this.Visit_OrderNo;

    data['ImageDesc'] = this.ImageDesc;
    data['ImgBase64'] = this.ImgBase64;
    data['Item_Name'] = this.Item_Name;
    data['Ename'] = this.Ename;
    return data;
  }
}