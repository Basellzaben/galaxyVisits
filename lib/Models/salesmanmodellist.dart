class SalesManAttResult {
  int? userID;
  int? actionNo;
  DateTime? actionDate;
  String? actionTime;
  String? notes;
  String? dayNm;
  String? endTime;
  String? startLocation;
  String? endLocation;
  String? startTime;
  String? notes2;
  String? arabicName;

  SalesManAttResult({
    this.userID,
    this.actionNo,
    this.actionDate,
    this.actionTime,
    this.notes,
    this.dayNm,
    this.endTime,
    this.startLocation,
    this.endLocation,
    this.startTime,
    this.notes2,
    this.arabicName,
  });

  factory SalesManAttResult.fromJson(Map<String, dynamic> json) {
    return SalesManAttResult(
      userID: json['UserID'] as int?,
      actionNo: json['ActionNo'] as int?,
      actionDate: json['ActionDate'] != null ? DateTime.parse(json['ActionDate']) : null,
      actionTime: json['ActionTime'] as String?,
      notes: json['Notes'] as String?,
      dayNm: json['DayNm'] as String?,
      endTime: json['EndTime'] ,
      startLocation: json['StartLocation'] as String?,
      endLocation: json['EndLocation'] as String?,
      startTime: json['StartTime'] ,
      notes2: json['Notes2'] as String?,
      arabicName: json['ArabicName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'ActionNo': actionNo,
      'ActionDate': actionDate?.toIso8601String(),
      'ActionTime': actionTime,
      'Notes': notes,
      'DayNm': dayNm,
      'EndTime': endTime?.toString(),
      'StartLocation': startLocation,
      'EndLocation': endLocation,
      'StartTime': startTime?.toString(),
      'Notes2': notes2,
      'ArabicName': arabicName,
    };
  }

  static Duration? parseDuration(String? duration) {
    if (duration == null) return null;
    final parts = duration.split(':');
    if (parts.length != 3) return null;
    return Duration(
      hours: int.parse(parts[0]),
      minutes: int.parse(parts[1]),
    );
  }
  

  
    String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String get actionDateString => actionDate != null ? formatDate(actionDate!) : '';
    String translateDayName(String? dayName) {
    if (dayName == null) return '';
    Map<String, String> dayTranslations = {
      'Monday': 'الإثنين',
      'Tuesday': 'الثلاثاء',
      'Wednesday': 'الأربعاء',
      'Thursday': 'الخميس',
      'Friday': 'الجمعة',
      'Saturday': 'السبت',
      'Sunday': 'الأحد',
    };
    return dayTranslations[dayName] ?? dayName; // Return the translated name or original if not found
  }
}
