// To parse this JSON data, do
//
//     final getFillMarksModel = getFillMarksModelFromMap(jsonString);

import 'dart:convert';

GetFillMarksModel getFillMarksModelFromMap(String str) =>
    GetFillMarksModel.fromMap(json.decode(str));

String getFillMarksModelToMap(GetFillMarksModel data) =>
    json.encode(data.toMap());

class GetFillMarksModel {
  Data? data;
  String? msg;

  GetFillMarksModel({
    this.data,
    this.msg,
  });

  factory GetFillMarksModel.fromMap(Map<String, dynamic> json) =>
      GetFillMarksModel(
        data: json["data"] != null ? Data.fromMap(json["data"]) : Data(),
        msg: json["msg"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "data": data!.toMap(),
        "msg": msg,
      };
}

class Data {
  List<StudentList>? data;
  List<SubjectNames>? headerData;

  Data({
    this.data,
    this.headerData,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        data: json["data"] != null
            ? List<StudentList>.from(
                json["data"].map((x) => StudentList.fromMap(x)))
            : [],
        headerData: json["headerData"] != null
            ? List<SubjectNames>.from(
                json["headerData"].map((x) => SubjectNames.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "headerData": List<dynamic>.from(headerData!.map((x) => x.toMap())),
      };
}

class StudentList {
  String? studentId;
  String? studentName;
  String? obtainedMarks;
  String? maximumMarks;
  String? batchId;
  List<StudentTestObtMark>? studentTestObtMarks;

  StudentList({
    this.studentId,
    this.studentName,
    this.obtainedMarks,
    this.maximumMarks,
    this.batchId,
    this.studentTestObtMarks,
  });

  factory StudentList.fromMap(Map<String, dynamic> json) => StudentList(
        studentId: (json["studentId"] ?? "").toString(),
        studentName: (json["studentName"] ?? "").toString(),
        obtainedMarks: (json["obtainedMarks"] ?? "").toString(),
        maximumMarks: (json["maximumMarks"] ?? "").toString(),
        batchId: (json["batchId"] ?? "").toString(),
        studentTestObtMarks: json["studentTestObtMarks"] != null
            ? List<StudentTestObtMark>.from(json["studentTestObtMarks"]
                .map((x) => StudentTestObtMark.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "studentId": studentId,
        "studentName": studentName,
        "obtainedMarks": obtainedMarks,
        "maximumMarks": maximumMarks,
        "batchId": batchId,
        "studentTestObtMarks":
            List<dynamic>.from(studentTestObtMarks!.map((x) => x.toMap())),
      };
}

class StudentTestObtMark {
  String? testId;
  String? obtainedMarks;
  String? maximumdMarks;
  String? testName;
  String? remark;
  bool? isElective;
  bool? isOptional;

  StudentTestObtMark({
    this.testId,
    this.obtainedMarks,
    this.maximumdMarks,
    this.testName,
    this.remark,
    this.isElective,
    this.isOptional,
  });

  factory StudentTestObtMark.fromMap(Map<String, dynamic> json) =>
      StudentTestObtMark(
        testId: (json["testID"] ?? "").toString(),
        // obtainedMarks: (json["obtainedMarks"] ?? "").toString(),
        // maximumdMarks: (json["maximumdMarks"] ?? "").toString(),
        obtainedMarks: (json["obtainedMarks"] ?? "").toString() == "0"
            ? ""
            : (json["obtainedMarks"] ?? "").toString(),
        maximumdMarks: (json["maximumdMarks"] ?? "").toString() == "0"
            ? ""
            : (json["maximumdMarks"] ?? "").toString(),
        testName: (json["testName"] ?? "").toString(),
        remark: (json["remark"] ?? "").toString(),
        isElective: json["isElective"] ?? false,
        isOptional: json["isOptional"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "testID": testId,
        "obtainedMarks": obtainedMarks,
        "maximumdMarks": maximumdMarks,
        "testName": testName,
        "remark": remark,
        "isElective": isElective,
        "isOptional": isOptional,
      };
}

class SubjectNames {
  String? testId;
  String? classId;
  String? subjectId;
  String? testName;
  String? testType;
  String? maximumMarks;
  String? termId;
  String? boardId;
  bool? isOptional;

  SubjectNames({
    this.testId,
    this.classId,
    this.subjectId,
    this.testName,
    this.testType,
    this.maximumMarks,
    this.termId,
    this.boardId,
    this.isOptional,
  });

  factory SubjectNames.fromMap(Map<String, dynamic> json) => SubjectNames(
        testId: (json["testId"] ?? "").toString(),
        classId: (json["classId"] ?? "").toString(),
        subjectId: (json["subjectId"] ?? "").toString(),
        testName: (json["testName"] ?? "").toString(),
        testType: (json["testType"] ?? "").toString(),
        maximumMarks: (json["maximumMarks"] ?? "").toString(),
        termId: (json["termId"] ?? "").toString(),
        boardId: (json["boardId"] ?? "").toString(),
        isOptional: json["isOptional"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "testId": testId,
        "classId": classId,
        "subjectId": subjectId,
        "testName": testName,
        "testType": testType,
        "maximumMarks": maximumMarks,
        "termId": termId,
        "boardId": boardId,
        "isOptional": isOptional,
      };
}
