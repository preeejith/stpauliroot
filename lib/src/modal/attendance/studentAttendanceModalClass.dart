import 'dart:convert';

StudentAttendance studentAttendanceFromJson(String str) =>
    StudentAttendance.fromJson(json.decode(str));

class StudentAttendance {
  List<Datum?> data;
  String? msg;
  String? responseCode;
  String? additionalData;

  StudentAttendance({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) =>
      StudentAttendance(
        data:List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class Datum {
  int? studentId;
  String? studentName;
  String? totalDays;
  String? totalAttendedDays;
  List<Attendance?> attendance;
  String? attendancePer;
  String? absentPer;

  Datum({
    required this.studentId,
    required this.studentName,
    required this.totalDays,
    required this.totalAttendedDays,
    required this.attendance,
    required this.attendancePer,
    required this.absentPer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        studentId: json["studentId"],
        studentName: json["studentName"],
        totalAttendedDays: json["totalAttendedDays"],
        totalDays: json["totalDays"],
        attendance: List<Attendance>.from(
            json["attendance"].map((x) => Attendance.fromJson(x))),
        attendancePer: json["attendancePer"],
        absentPer: json["absentPer"],
      );
}

class Attendance {
  int? attendanceId;
  int? classId;
  int? sectionId;
  String? className;
  String? sectionName;
  String? markFullDayAbsent;
  String? markHalfDayAbsent;
  int? studentRegisterId;
  String studentName;
  String createdDate;
  String day;
  String createdBy;
  String others;

  Attendance({
    required this.attendanceId,
    required this.classId,
    required this.sectionId,
    required this.className,
    required this.sectionName,
    required this.markFullDayAbsent,
    required this.markHalfDayAbsent,
    required this.studentRegisterId,
    required this.studentName,
    required this.createdDate,
    required this.day,
    required this.createdBy,
    required this.others,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        attendanceId: json["attendanceId"],
        classId: json["classId"],
        sectionId: json["sectionId"],
        className: json["className"] ?? "",
        sectionName: json["sectionName"] ?? "",
        markFullDayAbsent: json["markFullDayAbsent"] ?? "",
        markHalfDayAbsent: json["markHalfDayAbsent"] ?? "",
        studentRegisterId: json["studentRegisterId"] ?? "",
        studentName: json["studentName"] ?? "",
        createdDate: json["createdDate"] ?? "",
        day: json["day"] ?? "",
        createdBy: json["createdBy"] ?? "",
        others: json["others"] ?? "",
      );
}
