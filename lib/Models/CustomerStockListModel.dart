
//Doctor.dart

// ignore_for_file: non_constant_identifier_names, unnecessary_this, prefer_collection_literals, file_names

class CustomerStockListModel {
  int? Id;
  int? VisitOrderNo;
  String? ExpiryTransData;
  int? OrderQty;
  String? TransData;
  int? CustId;
  int? ManId;
String? name;
  String? ItemNo;
  int? Qty;
  String? Item_Name;
  String? Ename;
  String? Note;


  CustomerStockListModel(
      {this.Id,
        this.VisitOrderNo,
        this.ExpiryTransData,
        this.TransData,
        this.ManId,
        this.CustId,
        this.OrderQty,
this.name="",
        this.ItemNo,
        this.Qty,
        this.Item_Name,
        this.Ename,
        this.Note
      });

  CustomerStockListModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    VisitOrderNo = json['VisitOrderNo'];
    ExpiryTransData = json['ExpiryTransData'];
    TransData = json['TransData'];
    CustId = json['CustId'];
    ManId = json['ManId'];
    OrderQty = json['OrderQty'];
    name = json['itemName'];

    ItemNo = json['ItemNo'];
    Qty = json['Qty'];
    Item_Name = json['Item_Name'];
    Ename = json['Ename'];
    Note = json['Note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.Id;
    data['VisitOrderNo'] = this.VisitOrderNo;
    data['ExpiryTransData'] = this.ExpiryTransData;
    data['TransData'] = this.TransData;
    data['CustId'] = this.CustId;
    data['ManId'] = this.ManId;
    data['OrderQty'] = this.OrderQty;
    data['itemName'] = this.name;

    data['ItemNo'] = this.ItemNo;
    data['Qty'] = this.Qty;
    data['Item_Name'] = this.Item_Name;
    data['Ename'] = this.Ename;
    data['Note'] = this.Note;
    return data;
  }
}