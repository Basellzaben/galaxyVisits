
class VisitsImageModel {
  double? id;
  String customerNo = '';
  String userNo = '';
  String visitOrderNo = '';
  String orderNo = '';
  DateTime? orderDate;
  DateTime? imageTime;
  String imageDesc = '';
  String imgBase64 = '';

  VisitsImageModel({
    this.id,
    this.customerNo = '',
    this.userNo = '',
    this.visitOrderNo = '',
    this.orderNo = '',
    this.orderDate,
    this.imageTime,
    this.imageDesc = '',
    this.imgBase64 = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CustomerNo': customerNo,
      'UserNo': userNo,
      'Visit_OrderNo': visitOrderNo,
      'Order_No': orderNo,
      'OrderDate': orderDate?.toIso8601String(),
      'ImageTime': imageTime?.toIso8601String(),
      'ImageDesc': imageDesc,
      'ImgBase64': imgBase64,
    };
  }
  factory VisitsImageModel.fromJson(Map<String, dynamic> json) {
    return VisitsImageModel(
      id: json['ID'],
      customerNo: json['CustomerNo'],
      userNo: json['UserNo'],
      visitOrderNo: json['Visit_OrderNo'],
      orderNo: json['Order_No'],
      orderDate: DateTime.tryParse(json['OrderDate']),
      imageTime: DateTime.tryParse(json['ImageTime']),
      imageDesc: json['ImageDesc'],
      imgBase64: json['ImgBase64'],
    );
  }
}

class ManVisitModel {
  double? id;
  double? cusNo;
  int? dayNum;
  String startTime = '';
  String endTime = '';
  int? manNo;
  DateTime? trData;
  int? no;
  double? orderNo;
  String note = '';
  String xLat = '';
  String yLong = '';
  String loct = '';
  int? isException;
  String computerName = '';
  String orderinvisit = '';
  String duration = '';
  List<String> images = [];
  List<VisitsImageModel> visitsImageList = [];
  List<CustomersStock> customersStockModelList = [];
  String customerNameA = '';
  String customerNameE = '';

  ManVisitModel({
    this.id,
    this.cusNo,
    this.dayNum,
    this.startTime = '',
    this.endTime = '',
    this.manNo,
    this.trData,
    this.no,
    this.orderNo,
    this.note = '',
    this.xLat = '',
    this.yLong = '',
    this.loct = '',
    this.isException,
    this.computerName = '',
    this.orderinvisit = '',
    this.duration = '',
    this.images = const [],
    this.visitsImageList = const [],
    this.customersStockModelList = const [],
    this.customerNameA = '',
    this.customerNameE = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CusNo': cusNo,
      'DayNum': dayNum,
      'Start_Time': startTime,
      'End_Time': endTime,
      'ManNo': manNo,
      'Tr_Data': trData?.toIso8601String(),
      'no': no,
      'OrderNo': orderNo,
      'Note': note,
      'X_Lat': xLat,
      'Y_Long': yLong,
      'Loct': loct,
      'IsException': isException,
      'COMPUTERNAME': computerName,
      'orderinvisit': orderinvisit,
      'Duration': duration,
      'Images': images,
      'VisitsImageList': visitsImageList.map((e) => e.toJson()).toList(),
      'CustomersStockModelList': customersStockModelList.map((e) => e.toJson()).toList(),
      'CustomerNameA': customerNameA,
      'CustomerNameE': customerNameE,
    };
  }
  factory ManVisitModel.fromJson(Map<String, dynamic> json) {
    return ManVisitModel(
      id: json['ID'] ?? 0,
      cusNo: json['CusNo'] ?? 0,
      dayNum: json['DayNum'] ?? 0,
      startTime: json['Start_Time']   ?? '',
      endTime: json['End_Time'] ?? '',
      manNo: json['ManNo'] ?? 0,
      trData: json['Tr_Data'],
      no: json['no'] ?? 0,
      orderNo: json['OrderNo'] ?? 0,
      note: json['Note'] ?? '',
      xLat: json['X_Lat'] ?? '',
      yLong: json['Y_Long'] ?? '',
      loct: json['Loct'] ?? '',
      isException: json['IsException'] ?? 0,
      computerName: json['COMPUTERNAME'] ?? '',
      orderinvisit: json['orderinvisit'] ?? '',
      duration: json['Duration'] ?? '',
      images: List<String>.from(json['Images'] ?? []),
      visitsImageList: List<VisitsImageModel>.from(
        (json['VisitsImageList'] ?? []).map(
          (v) => VisitsImageModel.fromJson(v),
        ),
      ),
      customersStockModelList: List<CustomersStock>.from(
        (json['CustomersStockModelList'] ?? []).map(
          (v) => CustomersStock.fromJson(v),
        ),
      ),
      customerNameA: json['CustomerNameA'] ?? '',
      customerNameE: json['CustomerNameE'] ?? '',
    );
  }
}

class CustomersStock {
  int id = 0;
  int visitOrderNo = 0;
  DateTime? transDate = DateTime.now();
  int custId = 0;
  int manId = 0;
  String itemNo = '';
  int qty = 0;
  int orderQty = 0;
  DateTime? expiryDate = DateTime.now();
  int transNo = 0;
  String note = '';

  CustomersStock({
    this.id = 0,
    this.visitOrderNo = 0,
    this.transDate ,
    this.custId = 0,
    this.manId = 0,
    this.itemNo = '',
    this.qty = 0,
    this.orderQty = 0,
    this.expiryDate,
    this.transNo = 0,
    this.note = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'VisitOrderNo': visitOrderNo,
      'TransDate': transDate?.toIso8601String(),
      'CustId': custId,
      'ManId': manId,
      'ItemNo': itemNo,
      'Qty': qty,
      'OrderQty': orderQty,
      'ExpiryDate': expiryDate?.toIso8601String(),
      'TransNo': transNo,
      'Note': note,
    };
  }
  factory CustomersStock.fromJson(Map<String, dynamic> json) {
    return CustomersStock(
      id: json['Id'],
      visitOrderNo: json['VisitOrderNo'],
      transDate: DateTime.tryParse(json['TransDate']),
      custId: json['CustId'],
      manId: json['ManId'],
      itemNo: json['ItemNo'],
      qty: json['Qty'],
      orderQty: json['OrderQty'],
      expiryDate: DateTime.tryParse(json['ExpiryDate']),
      transNo: json['TransNo'],
      note: json['Note'],
    );
  }
}
