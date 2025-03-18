// To parse this JSON data, do
//
//     final getClassModel = getClassModelFromMap(jsonString);

import 'dart:convert';

GetClassModel getClassModelFromMap(String str) =>
    GetClassModel.fromMap(json.decode(str));

String getClassModelToMap(GetClassModel data) => json.encode(data.toMap());

class GetClassModel {
  List<ClassModel>? data;
  String? msg;
  String? responseCode;

  GetClassModel({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory GetClassModel.fromMap(Map<String, dynamic> json) => GetClassModel(
        data: json["data"] != null
            ? List<ClassModel>.from(
                json["data"].map((x) => ClassModel.fromMap(x)))
            : [],
        msg: json["msg"] ?? "",
        responseCode: json["responseCode"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "msg": msg,
        "responseCode": responseCode,
      };
}

class ClassModel {
  String? dataListItemId;
  String? dataListItemName;
  String? dataListId;
  String? dataListName;
  String? status;

  ClassModel({
    this.dataListItemId,
    this.dataListItemName,
    this.dataListId,
    this.dataListName,
    this.status,
  });

  factory ClassModel.fromMap(Map<String, dynamic> json) => ClassModel(
        dataListItemId: (json["dataListItemId"] ?? "").toString(),
        dataListItemName: (json["dataListItemName"] ?? "").toString(),
        dataListId: (json["dataListId"] ?? "").toString(),
        dataListName: (json["dataListName"] ?? "").toString(),
        status: (json["status"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "dataListItemId": dataListItemId,
        "dataListItemName": dataListItemName,
        "dataListId": dataListId,
        "dataListName": dataListName,
        "status": status,
      };
}
