// To parse this JSON data, do
//
//     final getBatchModel = getBatchModelFromMap(jsonString);

import 'dart:convert';

GetBatchModel getBatchModelFromMap(String str) =>
    GetBatchModel.fromMap(json.decode(str));

String getBatchModelToMap(GetBatchModel data) => json.encode(data.toMap());

class GetBatchModel {
  List<BatchModel>? data;
  String? msg;
  String? responseCode;

  GetBatchModel({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory GetBatchModel.fromMap(Map<String, dynamic> json) => GetBatchModel(
        data: json["data"] != null
            ? List<BatchModel>.from(
                json["data"].map((x) => BatchModel.fromMap(x)))
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

class BatchModel {
  String? batchId;
  String? batchName;

  BatchModel({
    this.batchId,
    this.batchName,
  });

  factory BatchModel.fromMap(Map<String, dynamic> json) => BatchModel(
        batchId: (json["batchId"] ?? "").toString(),
        batchName: (json["batchName"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "batchId": batchId,
        "batchName": batchName,
      };
}
