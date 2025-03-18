// To parse this JSON data, do
//
//     final getStaffModel = getStaffModelFromMap(jsonString);

import 'dart:convert';

GetStaffModel getStaffModelFromMap(String str) =>
    GetStaffModel.fromMap(json.decode(str));

String getStaffModelToMap(GetStaffModel data) => json.encode(data.toMap());

class GetStaffModel {
  List<StaffModel>? data;
  String? msg;
  String? responseCode;

  GetStaffModel({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory GetStaffModel.fromMap(Map<String, dynamic> json) => GetStaffModel(
        data: json["data"] != null
            ? List<StaffModel>.from(
                json["data"].map((x) => StaffModel.fromMap(x)))
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

class StaffModel {
  String? stafId;
  String? uin;
  String? name;
  String? empId;
  String? userId;

  StaffModel({
    this.stafId,
    this.uin,
    this.name,
    this.empId,
    this.userId,
  });

  factory StaffModel.fromMap(Map<String, dynamic> json) => StaffModel(
        stafId: (json["stafId"] ?? "").toString(),
        uin: (json["uin"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        empId: (json["empId"] ?? "").toString(),
        userId: (json["userId"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "stafId": stafId,
        "uin": uin,
        "name": name,
        "empId": empId,
        "userId": userId,
      };
}
