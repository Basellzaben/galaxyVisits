class DataModel {
  List<CustomerBranch>? customerBranches;
  List<Man>? mans;

  DataModel({this.customerBranches, this.mans});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      customerBranches: (json['CustomerBranches'] as List)
          .map((item) => CustomerBranch.fromJson(item))
          .toList(),
      mans: (json['Mans'] as List)
          .map((item) => Man.fromJson(item))
          .toList(),
    );
  }
}

class CustomerBranch {
  int? id;
  int? customerId;
  String branchName;
  String? branchTel;
  int? branchRepNo;
  dynamic locX;
  dynamic locY;
  bool? sat;
  bool? sun;
  bool? mon;
  bool? tues;
  bool? wens;
  bool? thurs;
  bool? frid;
  int? everyWeek;
  int? visitWeek;

  CustomerBranch({
    this.id,
    this.customerId,
    this.branchName = "",
    this.branchTel,
    this.branchRepNo,
    this.locX,
    this.locY,
    this.sat,
    this.sun,
    this.mon,
    this.tues,
    this.wens,
    this.thurs,
    this.frid,
    this.everyWeek,
    this.visitWeek,
  });

  factory CustomerBranch.fromJson(Map<String, dynamic> json) {
    return CustomerBranch(
      id: json['Id'],
      customerId: json['CustomerId'],
      branchName: json['BranchName'],
      branchTel: json['BranchTel'],
      branchRepNo: json['BranchRepNo'],
      locX: json['LocX'],
      locY: json['LocY'],
      sat: json['Sat'],
      sun: json['Sun'],
      mon: json['Mon'],
      tues: json['Tues'],
      wens: json['Wens'],
      thurs: json['Thurs'],
      frid: json['Frid'],
      everyWeek: json['EveryWeek'],
      visitWeek: json['VisitWeek'],
    );
  }
}

class Man {
  int? id;
  String? arabicName;
  String? englishName;
  int? manType;
  int? manSupervisor;
  int? alternativeMan;
  int? branchNo;
  int? manStatus;
  String? email;
  String? mobileNo;
  String? loginName;
  double? basicSalary;
  dynamic carId;
  String? password;
  dynamic cashComm;
  dynamic creditComm;
  dynamic quta;
  dynamic sales2;
  dynamic state;
  int? year;
  int? country;
  dynamic city;
  dynamic area;
  dynamic type;
  dynamic note;
  dynamic dis;
  int? storeNo;
  dynamic mobileNo2;
  dynamic manImage;
  dynamic imagePath;
  dynamic maxDiscount;
  dynamic maxBouns;
  dynamic fullName;
  dynamic manMaterial;
  dynamic manRegion;
  dynamic opiningBalanceVacation;
  dynamic balanceVacation;
  int? equationId;
  double? subAgent;
  dynamic customerName;
  dynamic items;
  double? salesAccNo;
  int? receiptVType;
  int? salesVType;
  int? retSalesVType;
  double? cashAccNo;
  dynamic vType;
  bool? supervisor;
  bool? allowLoginOutside;
  dynamic rangeLogin;
  double? accNum;
  bool? approveInvoicesDirectly;
  dynamic salesCeiling;

  Man({
    this.id,
    this.arabicName,
    this.englishName,
    this.manType,
    this.manSupervisor,
    this.alternativeMan,
    this.branchNo,
    this.manStatus,
    this.email,
    this.mobileNo,
    this.loginName,
    this.basicSalary,
    this.carId,
    this.password,
    this.cashComm,
    this.creditComm,
    this.quta,
    this.sales2,
    this.state,
    this.year,
    this.country,
    this.city,
    this.area,
    this.type,
    this.note,
    this.dis,
    this.storeNo,
    this.mobileNo2,
    this.manImage,
    this.imagePath,
    this.maxDiscount,
    this.maxBouns,
    this.fullName,
    this.manMaterial,
    this.manRegion,
    this.opiningBalanceVacation,
    this.balanceVacation,
    this.equationId,
    this.subAgent,
    this.customerName,
    this.items,
    this.salesAccNo,
    this.receiptVType,
    this.salesVType,
    this.retSalesVType,
    this.cashAccNo,
    this.vType,
    this.supervisor,
    this.allowLoginOutside,
    this.rangeLogin,
    this.accNum,
    this.approveInvoicesDirectly,
    this.salesCeiling,
  });

  factory Man.fromJson(Map<String, dynamic> json) {
    return Man(
      id: json['Id'],
      arabicName: json['ArabicName'],
      englishName: json['EnglishName'],
      manType: json['ManType'],
      manSupervisor: json['ManSupervisor'],
      alternativeMan: json['AlternativeMan'],
      branchNo: json['BranchNo'],
      manStatus: json['ManStatus'],
      email: json['Email'],
      mobileNo: json['MobileNo'],
      loginName: json['LoginName'],
      basicSalary: json['BasicSalary'],
      carId: json['CarId'],
      password: json['Password'],
      cashComm: json['CashComm'],
      creditComm: json['CreditComm'],
      quta: json['quta'],
      sales2: json['sales2'],
      state: json['state'],
      year: json['year'],
      country: json['country'],
      city: json['city'],
      area: json['Area'],
      type: json['Type'],
      note: json['Note'],
      dis: json['dis'],
      storeNo: json['StoreNo'],
      mobileNo2: json['MobileNo2'],
      manImage: json['ManImage'],
      imagePath: json['ImagePath'],
      maxDiscount: json['MaxDiscount'],
      maxBouns: json['MaxBouns'],
      fullName: json['FullName'],
      manMaterial: json['ManMaterial'],
      manRegion: json['ManRegion'],
      opiningBalanceVacation: json['OpiningBalanceVacation'],
      balanceVacation: json['BalanceVacation'],
      equationId: json['EquationId'],
      subAgent: json['SubAgent'],
      customerName: json['CustomerName'],
      items: json['Items'],
      salesAccNo: json['SalesAccNo'],
      receiptVType: json['ReceiptVType'],
      salesVType: json['SalesVType'],
      retSalesVType: json['RetSalesVType'],
      cashAccNo: json['CashAccNo'],
      vType: json['VType'],
      supervisor: json['Supervisor'],
      allowLoginOutside: json['AllowLoginOutside'],
      rangeLogin: json['RangeLogin'],
      accNum: json['Acc_Num'],
      approveInvoicesDirectly: json['ApproveInvoicesDirectly'],
      salesCeiling: json['SalesCeiling'],
    );
  }
}
