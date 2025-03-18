// To parse this JSON data, do
//
//     final getTermModel = getTermModelFromMap(jsonString);

import 'dart:convert';

GetTermModel getTermModelFromMap(String str) =>
    GetTermModel.fromMap(json.decode(str));

String getTermModelToMap(GetTermModel data) => json.encode(data.toMap());

class GetTermModel {
  List<TermModel>? data;
  String? msg;
  String? responseCode;

  GetTermModel({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory GetTermModel.fromMap(Map<String, dynamic> json) => GetTermModel(
        data: json["data"] != null
            ? List<TermModel>.from(
                json["data"].map((x) => TermModel.fromMap(x)))
            : [],
        msg: json["msg"],
        responseCode: json["responseCode"],
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "msg": msg,
        "responseCode": responseCode,
      };
}

class TermModel {
  String? termId;
  String? termName;
  String? boardId;
  String? batchId;

  TermModel({
    this.termId,
    this.termName,
    this.boardId,
    this.batchId,
  });

  factory TermModel.fromMap(Map<String, dynamic> json) => TermModel(
        termId: (json["termId"] ?? "").toString(),
        termName: (json["termName"] ?? "").toString(),
        boardId: (json["boardId"] ?? "").toString(),
        batchId: (json["batchId"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "termId": termId,
        "termName": termName,
        "boardId": boardId,
        "batchId": batchId,
      };
}
