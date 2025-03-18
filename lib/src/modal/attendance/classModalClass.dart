import 'dart:convert';

ClassModalClass classModalClassFromJson(String str) =>
    ClassModalClass.fromJson(json.decode(str));

class ClassModalClass {
  List<ClassData> data;
  String msg;
  String responseCode;
  String additionalData;

  ClassModalClass({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory ClassModalClass.fromJson(Map<String, dynamic> json) =>
      ClassModalClass(
        data: List<ClassData>.from(
            json["data"].map((x) => ClassData.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class ClassData {
  int dataListItemId;
  String dataListItemName;
  String dataListId;
  String dataListName;
  String status;

  ClassData({
    required this.dataListItemId,
    required this.dataListItemName,
    required this.dataListId,
    required this.dataListName,
    required this.status,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) => ClassData(
        dataListItemId: json["dataListItemId"] ?? "",
        dataListItemName: json["dataListItemName"] ?? "",
        dataListId: json["dataListId"] ?? "",
        dataListName: json["dataListName"] ?? "",
        status: json["status"] ?? "",
      );
}
