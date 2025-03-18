// class StudentAttendanceModel {
//   String? message;
//   String? responseCode;
//   Data? data;

//   StudentAttendanceModel({this.message, this.responseCode, this.data});

//   StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     responseCode = json['responseCode'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['responseCode'] = this.responseCode;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   List<Null>? dateRangeAttendance;
//   List<YearlyAttendanceSummary>? yearlyAttendanceSummary;

//   Data({this.dateRangeAttendance, this.yearlyAttendanceSummary});

//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['dateRangeAttendance'] != null) {
//       dateRangeAttendance = <Null>[];
//       json['dateRangeAttendance'].forEach((v) {
//         // dateRangeAttendance!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['yearlyAttendanceSummary'] != null) {
//       yearlyAttendanceSummary = <YearlyAttendanceSummary>[];
//       json['yearlyAttendanceSummary'].forEach((v) {
//         yearlyAttendanceSummary!.add(new YearlyAttendanceSummary.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.dateRangeAttendance != null) {
//       // data['dateRangeAttendance'] =
//       //     this.dateRangeAttendance!.map((v) => v.toJson()).toList();
//     }
//     if (this.yearlyAttendanceSummary != null) {
//       data['yearlyAttendanceSummary'] =
//           this.yearlyAttendanceSummary!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class YearlyAttendanceSummary {
//   int? year;
//   int? month;
//   int? totalPresent;
//   int? totalAbsent;
//   int? totalLeave;

//   YearlyAttendanceSummary(
//       {this.year,
//       this.month,
//       this.totalPresent,
//       this.totalAbsent,
//       this.totalLeave});

//   YearlyAttendanceSummary.fromJson(Map<String, dynamic> json) {
//     year = json['year'];
//     month = json['month'];
//     totalPresent = json['totalPresent'];
//     totalAbsent = json['totalAbsent'];
//     totalLeave = json['totalLeave'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['year'] = this.year;
//     data['month'] = this.month;
//     data['totalPresent'] = this.totalPresent;
//     data['totalAbsent'] = this.totalAbsent;
//     data['totalLeave'] = this.totalLeave;
//     return data;
//   }
// }

class StudentAttendanceModel {
  String? message;
  String? responseCode;
  Data? data;

  StudentAttendanceModel({this.message, this.responseCode, this.data});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['responseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<DateRangeAttendance>? dateRangeAttendance;
  List<YearlyAttendanceSummary>? yearlyAttendanceSummary;

  Data({this.dateRangeAttendance, this.yearlyAttendanceSummary});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['dateRangeAttendance'] != null) {
      dateRangeAttendance = <DateRangeAttendance>[];
      json['dateRangeAttendance'].forEach((v) {
        dateRangeAttendance!.add(DateRangeAttendance.fromJson(v));
      });
    }
    if (json['yearlyAttendanceSummary'] != null) {
      yearlyAttendanceSummary = <YearlyAttendanceSummary>[];
      json['yearlyAttendanceSummary'].forEach((v) {
        yearlyAttendanceSummary!.add(YearlyAttendanceSummary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dateRangeAttendance != null) {
      data['dateRangeAttendance'] =
          dateRangeAttendance!.map((v) => v.toJson()).toList();
    }
    if (yearlyAttendanceSummary != null) {
      data['yearlyAttendanceSummary'] =
          yearlyAttendanceSummary!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateRangeAttendance {
  int? attendanceId;
  String? className;
  String? sectionName;
  int? studentRegisterId;
  String? studentName;
  String? createdDate;
  String? markFullDayAbsent;
  String? markHalfDayAbsent;
  String? others;

  DateRangeAttendance(
      {this.attendanceId,
      this.className,
      this.sectionName,
      this.studentRegisterId,
      this.studentName,
      this.createdDate,
      this.markFullDayAbsent,
      this.markHalfDayAbsent,
      this.others});

  DateRangeAttendance.fromJson(Map<String, dynamic> json) {
    attendanceId = json['attendanceId'];
    className = json['className'];
    sectionName = json['sectionName'];
    studentRegisterId = json['studentRegisterId'];
    studentName = json['studentName'];
    createdDate = json['createdDate'];
    markFullDayAbsent = json['markFullDayAbsent'];
    markHalfDayAbsent = json['markHalfDayAbsent'];
    others = json['others'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendanceId'] = attendanceId;
    data['className'] = className;
    data['sectionName'] = sectionName;
    data['studentRegisterId'] = studentRegisterId;
    data['studentName'] = studentName;
    data['createdDate'] = createdDate;
    data['markFullDayAbsent'] = markFullDayAbsent;
    data['markHalfDayAbsent'] = markHalfDayAbsent;
    data['others'] = others;
    return data;
  }
}

class YearlyAttendanceSummary {
  int? year;
  int? month;
  int? totalPresent;
  int? totalAbsent;
  int? totalLeave;

  YearlyAttendanceSummary(
      {this.year,
      this.month,
      this.totalPresent,
      this.totalAbsent,
      this.totalLeave});

  YearlyAttendanceSummary.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    totalPresent = json['totalPresent'];
    totalAbsent = json['totalAbsent'];
    totalLeave = json['totalLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['totalPresent'] = totalPresent;
    data['totalAbsent'] = totalAbsent;
    data['totalLeave'] = totalLeave;
    return data;
  }
}
