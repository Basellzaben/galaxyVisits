import 'package:flutter/cupertino.dart';

//Doctor.dart

class CustomerStockListModel {
  int? Id;
  int? VisitOrderNo;
  String? ExpiryTransData;
  int? OrderQty;
  String? TransData;
  int? CustId;
  int? ManId;

  String? ItemNo;
  int? Qty;
  String? Item_Name;
  String? Ename;


  CustomerStockListModel(
      {this.Id,
        this.VisitOrderNo,
        this.ExpiryTransData,
        this.TransData,
        this.ManId,
        this.CustId,
        this.OrderQty,

        this.ItemNo,
        this.Qty,
        this.Item_Name,
        this.Ename,
      });

  CustomerStockListModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    VisitOrderNo = json['VisitOrderNo'];
    ExpiryTransData = json['ExpiryTransData'];
    TransData = json['TransData'];
    CustId = json['CustId'];
    ManId = json['ManId'];
    OrderQty = json['OrderQty'];

    ItemNo = json['ItemNo'];
    Qty = json['Qty'];
    Item_Name = json['Item_Name'];
    Ename = json['Ename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['VisitOrderNo'] = this.VisitOrderNo;
    data['ExpiryTransData'] = this.ExpiryTransData;
    data['TransData'] = this.TransData;
    data['CustId'] = this.CustId;
    data['ManId'] = this.ManId;
    data['OrderQty'] = this.OrderQty;

    data['ItemNo'] = this.ItemNo;
    data['Qty'] = this.Qty;
    data['Item_Name'] = this.Item_Name;
    data['Ename'] = this.Ename;
    return data;
  }
}