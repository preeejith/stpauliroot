// To parse this JSON data, do
//
//     final getSectionModel = getSectionModelFromMap(jsonString);

import 'dart:convert';

GetSectionModel getSectionModelFromMap(String str) =>
    GetSectionModel.fromMap(json.decode(str));

String getSectionModelToMap(GetSectionModel data) => json.encode(data.toMap());

class GetSectionModel {
  List<SectionModel>? data;
  String? msg;
  String? responseCode;

  GetSectionModel({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory GetSectionModel.fromMap(Map<String, dynamic> json) => GetSectionModel(
        data: json["data"] != null
            ? List<SectionModel>.from(json["data"].map((x) => SectionModel.fromMap(x)))
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

class SectionModel {
  String? dataListItemId;
  String? dataListItemName;
  String? dataListId;
  String? dataListName;
  String? status;

  SectionModel({
    this.dataListItemId,
    this.dataListItemName,
    this.dataListId,
    this.dataListName,
    this.status,
  });

  factory SectionModel.fromMap(Map<String, dynamic> json) => SectionModel(
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
