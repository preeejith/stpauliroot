import 'dart:convert';

StudentAttendanceByStaffModalClass studentAttendanceByStaffModalClassFromJson(
        String str) =>
    StudentAttendanceByStaffModalClass.fromJson(json.decode(str));

class StudentAttendanceByStaffModalClass {
  List<StudentAttendanceByStaffDatum>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  StudentAttendanceByStaffModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory StudentAttendanceByStaffModalClass.fromJson(
          Map<String, dynamic> json) =>
      StudentAttendanceByStaffModalClass(
        data: json["data"] == null
            ? []
            : List<StudentAttendanceByStaffDatum>.from(json["data"]!
                .map((x) => StudentAttendanceByStaffDatum.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "responseCode": responseCode,
        "additionalData": additionalData,
      };
}

class StudentAttendanceByStaffDatum {
  int? attendanceId;
  int? classId;
  int? sectionId;
  String? className;
  String? sectionName;
  String? markFullDayAbsent;
  String? markHalfDayAbsent;
  int? studentRegisterId;
  String? studentName;
  String? createdDate;
  String? day;
  String? createdBy;
  String? others;

  StudentAttendanceByStaffDatum({
    this.attendanceId,
    this.classId,
    this.sectionId,
    this.className,
    this.sectionName,
    this.markFullDayAbsent,
    this.markHalfDayAbsent,
    this.studentRegisterId,
    this.studentName,
    this.createdDate,
    this.day,
    this.createdBy,
    this.others,
  });

  factory StudentAttendanceByStaffDatum.fromJson(Map<String, dynamic> json) =>
      StudentAttendanceByStaffDatum(
        attendanceId: json["attendanceId"],
        classId: json["classId"],
        sectionId: json["sectionId"],
        className: json["className"],
        sectionName: json["sectionName"],
        markFullDayAbsent: json["markFullDayAbsent"],
        markHalfDayAbsent: json["markHalfDayAbsent"],
        studentRegisterId: json["studentRegisterId"],
        studentName: json["studentName"],
        createdDate: json["createdDate"],
        day: json["day"],
        createdBy: json["createdBy"],
        others: json["others"],
      );

  Map<String, dynamic> toJson() => {
        "attendanceId": attendanceId,
        "classId": classId,
        "sectionId": sectionId,
        "className": className,
        "sectionName": sectionName,
        "markFullDayAbsent": markFullDayAbsent,
        "markHalfDayAbsent": markHalfDayAbsent,
        "studentRegisterId": studentRegisterId,
        "studentName": studentName,
        "createdDate": createdDate,
        "day": day,
        "createdBy": createdBy,
        "others": others,
      };
}
