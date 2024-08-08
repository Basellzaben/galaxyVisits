class Visit {
  HeaderInfo? headerInfo;
  List<VisitsImages>? visitsImages;
  List<CustomerStock>? customerStock;

  Visit({this.headerInfo, this.visitsImages, this.customerStock});

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      headerInfo: HeaderInfo.fromJson(json['HeaderInfo']),
      visitsImages: (json['VisitsImages'] as List)
          .map((item) => VisitsImages.fromJson(item))
          .toList(),
      customerStock: (json['CustomerStock'] as List)
          .map((item) => CustomerStock.fromJson(item))
          .toList(),
    );
  }
}

class HeaderInfo {
  String? transDate;
  double? transNo;
  double? custId;
  int? manId;
  double? visitOrderNo;
  String? arabicName;
  String? name;
  String? startTime;
  String? endTime;

  HeaderInfo(
      {this.transDate,
      this.transNo,
      this.custId,
      this.manId,
      this.visitOrderNo,
      this.arabicName,
      this.name,
      this.startTime,
      this.endTime
      });

  factory HeaderInfo.fromJson(Map<String?, dynamic> json) {
    return HeaderInfo(
      transDate: json['TransDate'],
      transNo: json['TransNo'],
      custId: json['CustId'],
      manId: json['ManId'],
      visitOrderNo: json['VisitOrderNo'],
      arabicName: json['ArabicName'],
      name: json['Name'],
      startTime: json['StartTime'],
      endTime: json['EndTime']
    );
  }
}

class VisitsImages {
  double? id;
  String? customerNo;
  String? userNo;
  String? visitOrderNo;
  String? orderNo;
  String? orderDate;
  String? imageTime;
  String? imageDesc;
  String? imgBase64;

  VisitsImages(
      {this.id,
      this.customerNo,
      this.userNo,
      this.visitOrderNo,
      this.orderNo,
      this.orderDate,
      this.imageTime,
      this.imageDesc,
      this.imgBase64});

  factory VisitsImages.fromJson(Map<String?, dynamic> json) {
    return VisitsImages(
      id: json['ID'],
      customerNo: json['CustomerNo'],
      userNo: json['UserNo'],
      visitOrderNo: json['Visit_OrderNo'],
      orderNo: json['Order_No'],
      orderDate: json['OrderDate'],
      imageTime: json['ImageTime'],
      imageDesc: json['ImageDesc'],
      imgBase64: json['ImgBase64'],
    );
  }
}

class CustomerStock {
  String? itemNo;
  int? qty;
  String? itemNameA;
  String? itemNameE;
  int? orderQty;
  String? expiryDate;

  CustomerStock(
      {this.itemNo,
      this.qty,
      this.itemNameA,
      this.itemNameE,
      this.orderQty,
      this.expiryDate});

  factory CustomerStock.fromJson(Map<String?, dynamic> json) {
    return CustomerStock(
      itemNo: json['ItemNo'],
      qty: json['Qty'],
      itemNameA: json['ItemNameA'],
      itemNameE: json['ItemNameE'],
      orderQty: json['OrderQty'],
      expiryDate: json['ExpiryDate'],
    );
  }
}
