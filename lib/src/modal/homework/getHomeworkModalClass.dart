import 'dart:convert';

GetHomeWorkModalClass getHomeWorkModalClassFromJson(String str) =>
    GetHomeWorkModalClass.fromJson(json.decode(str));

class GetHomeWorkModalClass {
  List<GetHomeWorkData>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  GetHomeWorkModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory GetHomeWorkModalClass.fromJson(Map<String, dynamic> json) =>
      GetHomeWorkModalClass(
        data: json["data"] == null
            ? []
            : List<GetHomeWorkData>.from(
                json["data"]!.map((x) => GetHomeWorkData.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class GetHomeWorkData {
  int? assignmentId;
  String? className;
  int? classId;
  String? sectionName;
  int? sectionId;
  String? subjectName;
  int? subjectId;
  String? newAssignment;
  String? assignmentDate;
  String? submittedDate;
  String? createdDate;

  GetHomeWorkData({
    this.assignmentId,
    this.className,
    this.classId,
    this.sectionName,
    this.sectionId,
    this.subjectName,
    this.subjectId,
    this.newAssignment,
    this.assignmentDate,
    this.submittedDate,
    this.createdDate,
  });

  factory GetHomeWorkData.fromJson(Map<String, dynamic> json) =>
      GetHomeWorkData(
        assignmentId: json["assignmentId"],
        className: json["className"],
        classId: json["classId"],
        sectionName: json["sectionName"],
        sectionId: json["sectionId"],
        subjectName: json["subjectName"],
        subjectId: json["subjectId"],
        newAssignment: json["newAssignment"],
        assignmentDate: json["assignmentDate"],
        submittedDate: json["submittedDate"],
        createdDate: json["createdDate"],
      );
}
