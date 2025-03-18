// To parse this JSON data, do
//
//     final getCoScholasticModel = getCoScholasticModelFromMap(jsonString);

import 'dart:convert';

GetCoScholasticModel getCoScholasticModelFromMap(String str) =>
    GetCoScholasticModel.fromMap(json.decode(str));

String getCoScholasticModelToMap(GetCoScholasticModel data) =>
    json.encode(data.toMap());

class GetCoScholasticModel {
  Data? data;
  String? msg;
  String? responseCode;

  GetCoScholasticModel({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory GetCoScholasticModel.fromMap(Map<String, dynamic> json) =>
      GetCoScholasticModel(
        data: json["data"] != null ? Data.fromMap(json["data"]) : Data(),
        msg: json["msg"] ?? "",
        responseCode: json["responseCode"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "data": data!.toMap(),
        "msg": msg,
        "responseCode": responseCode,
      };
}

class Data {
  List<StudentData>? data;
  List<SubjectData>? headerData;

  Data({
    this.data,
    this.headerData,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        data: json["data"] != null
            ? List<StudentData>.from(
                json["data"].map((x) => StudentData.fromMap(x)))
            : [],
        headerData: json["headerData"] != null
            ? List<SubjectData>.from(
                json["headerData"].map((x) => SubjectData.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "headerData": List<dynamic>.from(headerData!.map((x) => x.toMap())),
      };
}

class StudentData {
  String? studentId;
  String? studentName;
  String? className;
  String? sectionName;
  String? title;
  String? term;
  String? obtainedMarks;
  List<CoscholastiStuentObtData>? coscholastiStuentObtDatas;

  StudentData({
    this.studentId,
    this.studentName,
    this.className,
    this.sectionName,
    this.title,
    this.term,
    this.obtainedMarks,
    this.coscholastiStuentObtDatas,
  });

  factory StudentData.fromMap(Map<String, dynamic> json) => StudentData(
        studentId: (json["studentId"] ?? "").toString(),
        studentName: (json["studentName"] ?? "").toString(),
        className: (json["className"] ?? "").toString(),
        sectionName: (json["sectionName"] ?? "").toString(),
        title: (json["title"] ?? "").toString(),
        term: (json["term"] ?? "").toString(),
        obtainedMarks: (json["obtainedMarks"] ?? "0").toString(),
        coscholastiStuentObtDatas: json["coscholastiStuentObtDatas"] != null
            ? List<CoscholastiStuentObtData>.from(
                json["coscholastiStuentObtDatas"]
                    .map((x) => CoscholastiStuentObtData.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "studentId": studentId,
        "studentName": studentName,
        "className": className,
        "sectionName": sectionName,
        "title": title,
        "term": term,
        "obtainedMarks": obtainedMarks,
        "coscholastiStuentObtDatas": List<dynamic>.from(
            coscholastiStuentObtDatas!.map((x) => x.toMap())),
      };
}

class CoscholastiStuentObtData {
  String? coscholasticId;
  String? obtainedGrade;
  String? coscholasticName;

  CoscholastiStuentObtData({
    this.coscholasticId,
    this.obtainedGrade,
    this.coscholasticName,
  });

  factory CoscholastiStuentObtData.fromMap(Map<String, dynamic> json) =>
      CoscholastiStuentObtData(
        coscholasticId: (json["coscholasticID"] ?? "").toString(),
        obtainedGrade: (json["obtainedGrade"] ?? "").toString(),
        coscholasticName: (json["coscholasticName"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "coscholasticID": coscholasticId,
        "obtainedGrade": obtainedGrade,
        "coscholasticName": coscholasticName,
      };
}

class SubjectData {
  String? id;
  String? title;
  String? boardId;

  SubjectData({
    this.id,
    this.title,
    this.boardId,
  });

  factory SubjectData.fromMap(Map<String, dynamic> json) => SubjectData(
        id: (json["id"] ?? "").toString(),
        title: (json["title"] ?? "").toString(),
        boardId: (json["boardId"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "boardId": boardId,
      };
}
