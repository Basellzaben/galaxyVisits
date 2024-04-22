class CustomersModel {
  final int? no;
  final String? name;
  final String? ceName;
  final double? acc;
  final String? person;
  final String? address;
  final String? tel;
  final String? fax;
  final double? sales;
  final double? pay;
  final double? dis;
  final double? celing;
  final double? sal1;
  final double? sal2;
  final double? sal3;
  final double? sal4;
  final double? sal5;
  final double? sal6;
  final double? sal7;
  final double? sal8;
  final double? sal9;
  final double? sal10;
  final double? sal11;
  final double? sal12;
  final DateTime? opDate;
  final int? state;
  final double? sMan;
  final int? year;
  final double? catNo;
  final double? chqceling;
  final double? ratioCeling;
  final double? country;
  final double? city;
  final double? area;
  final double? optNo;
  final double? payHow;
  final double? discountPercent;
  final double? allowPeriod;
  final String? deactivateReason;
  final double? cTypeNo;
  final double? commission;
  final double? cashComm;
  final double? creditComm;
  final String? cLevel;
  final double? cluse;
  final int? sman2;
  final bool? sat;
  final bool? sun;
  final bool? mon;
  final bool? tues;
  final bool? wens;
  final bool? thurs;
  final bool? frid;
  final String? mob;
  final String? naNo;
  final String? email;
  final String? accCheck;
  final int? sMan3;
  final bool? subAgent;
  final int? everyWeek;
  final int? visitWeek;
  final String? gpsLocations;
  final String? x;
  final String? y;
  final double? taxSts;
  final double? payType;
  final double? brNo;
  final bool? allowInvoiceWithFlag;
  final String? locX;
  final String? locY;
  final int? branchId;

  CustomersModel ({
    this.no,
    this.name,
    this.ceName,
    this.acc,
    this.person,
    this.address,
    this.tel,
    this.fax,
    this.sales,
    this.pay,
    this.dis,
    this.celing,
    this.sal1,
    this.sal2,
    this.sal3,
    this.sal4,
    this.sal5,
    this.sal6,
    this.sal7,
    this.sal8,
    this.sal9,
    this.sal10,
    this.sal11,
    this.sal12,
    this.opDate,
    this.state,
    this.sMan,
    this.year,
    this.catNo,
    this.chqceling,
    this.ratioCeling,
    this.country,
    this.city,
    this.area,
    this.optNo,
    this.payHow,
    this.discountPercent,
    this.allowPeriod,
    this.deactivateReason,
    this.cTypeNo,
    this.commission,
    this.cashComm,
    this.creditComm,
    this.cLevel,
    this.cluse,
    this.sman2,
    this.sat,
    this.sun,
    this.mon,
    this.tues,
    this.wens,
    this.thurs,
    this.frid,
    this.mob,
    this.naNo,
    this.email,
    this.accCheck,
    this.sMan3,
    this.subAgent,
    this.everyWeek,
    this.visitWeek,
    this.gpsLocations,
    this.x,
    this.y,
    this.taxSts,
    this.payType,
    this.brNo,
    this.allowInvoiceWithFlag,
    this.locX,
    this.locY,
    this.branchId,
  });

  factory CustomersModel .fromJson(Map<String, dynamic> json) {
    return CustomersModel (
      no: json['No'],
      name: json['Name'],
      ceName: json['CEName'],
      acc: json['Acc'],
      person: json['Person'],
      address: json['Address'],
      tel: json['Tel'],
      fax: json['Fax'],
      sales: json['Sales'],
      pay: json['Pay'],
      dis: json['Dis'],
      celing: json['Celing'],
      sal1: json['Sal1'],
      sal2: json['Sal2'],
      sal3: json['Sal3'],
      sal4: json['Sal4'],
      sal5: json['Sal5'],
      sal6: json['Sal6'],
      sal7: json['Sal7'],
      sal8: json['Sal8'],
      sal9: json['Sal9'],
      sal10: json['Sal10'],
      sal11: json['Sal11'],
      sal12: json['Sal12'],
      opDate: DateTime.parse(json['OpDate']),
      state: json['State'],
      sMan: json['SMan'],
      year: json['year'],
      catNo: json['CatNo'],
      chqceling: json['Chqceling'],
      ratioCeling: json['RatioCeling'],
      country: json['country'],
      city: json['city'],
      area: json['area'],
      optNo: json['Opt_no'],
      payHow: json['Pay_How'],
      discountPercent: json['Discount_Percent'],
      allowPeriod: json['Allow_Period'],
      deactivateReason: json['Deactivate_Reason'],
      cTypeNo: json['CType_No'],
      commission: json['Commission'],
      cashComm: json['CashComm'],
      creditComm: json['CreditComm'],
      cLevel: json['CLevel'],
      cluse: json['Cluse'],
      sman2: json['Sman2'],
      sat: json['sat'],
      sun: json['sun'],
      mon: json['mon'],
      tues: json['tues'],
      wens: json['wens'],
      thurs: json['thurs'],
      frid: json['Frid'],
      mob: json['mob'],
      naNo: json['NaNo'],
      email: json['email'],
      accCheck: json['ACC_CHECK'],
      sMan3: json['SMan3'],
      subAgent: json['SubAgent'],
      everyWeek: json['EveryWeek'],
      visitWeek: json['VisitWeek'],
      gpsLocations: json['GpsLocations'],
      x: json['X'],
      y: json['Y'],
      taxSts: json['TaxSts'],
      payType: json['PAYTYPE'],
      brNo: json['Br_no'],
      allowInvoiceWithFlag: json['AllowInviceWithFlag'],
      locX: json['LocX'],
      locY: json['LocY'],
      branchId: json['BranchId'],
    );
  }
}
