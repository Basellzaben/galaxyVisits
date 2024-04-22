class SalesManModel {
  final int? userID;
  final int? actionNo;
  final DateTime? actionDate;
  final String? actionTime;
  final String? coorX;
  final String? coorY;
  final String? manAddress;
  final String? notes;
  final String? img;
  final String? battryLevel;
  final String? tabletName;
  final int? dayNo;
  final String? dayNm;
  final String? endTime;
  final String? startLocation;
  final String? endLocation;
  final String? startTime;
  final String? endCoorX;
  final String? endCoorY;
  final String? notes2; 
  final String? startBreak;
  final String? endBreak;
  final int? breakStatus;

  SalesManModel({
    this.userID,
    this.actionNo,
    this.actionDate,
    this.actionTime,
    this.coorX,
    this.coorY,
    this.manAddress,
    this.notes,
    this.img,
    this.battryLevel,
    this.tabletName,
    this.dayNo,
    this.dayNm,
    this.endTime,
    this.startLocation,
    this.endLocation,
    this.startTime,
    this.endCoorX,
    this.endCoorY,
    this.notes2,
    this.startBreak,
    this.endBreak,
    this.breakStatus,
  });

  factory SalesManModel.fromJson(Map<String, dynamic> json) {
    return SalesManModel(
      userID: json['UserID'],
      actionNo: json['ActionNo'],
      actionDate: json['ActionDate'] != null
          ? DateTime.parse(json['ActionDate'])
          : null,
      actionTime: json['ActionTime'],
      coorX: json['Coor_X'],
      coorY: json['Coor_Y'],
      manAddress: json['ManAddress'],
      notes: json['Notes'],
      img: json['Img'],
      battryLevel: json['BattryLevel'],
      tabletName: json['TabletName'],
      dayNo: json['DayNo'],
      dayNm: json['DayNm'],
      endTime: json['EndTime'],
      startLocation: json['StartLocation'],
      endLocation: json['EndLocation'],
      startTime: json['StartTime'],
      endCoorX: json['EndCoor_X'],
      endCoorY: json['EndCoor_Y'],
      notes2: json['Notes2'],
      startBreak: json['StartBreak'],
      endBreak: json['EndBreak'],
      breakStatus: json['BreakStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'ActionNo': actionNo,
      'ActionDate': actionDate?.toIso8601String(),
      'ActionTime': actionTime,
      'Coor_X': coorX,
      'Coor_Y': coorY,
      'ManAddress': manAddress,
      'Notes': notes,
      'Img': img,
      'BattryLevel': battryLevel,
      'TabletName': tabletName,
      'DayNo': dayNo,
      'DayNm': dayNm,
      'EndTime': endTime,
      'StartLocation': startLocation,
      'EndLocation': endLocation,
      'StartTime': startTime,
      'EndCoor_X': endCoorX,
      'EndCoor_Y': endCoorY,
      'Notes2': notes2,
      'StartBreak': startBreak,
      'EndBreak': endBreak,
      'BreakStatus': breakStatus,
    };
  }
}
