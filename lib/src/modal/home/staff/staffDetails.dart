// To parse this JSON data, do
//
//     final staffDetailsModal = staffDetailsModalFromMap(jsonString);

import 'dart:convert';

StaffDetailsModal staffDetailsModalFromMap(String str) =>
    StaffDetailsModal.fromMap(json.decode(str));

String staffDetailsModalToMap(StaffDetailsModal data) =>
    json.encode(data.toMap());

class StaffDetailsModal {
  List<StaffDetail>? data;
  String? msg;
  String? responseCode;

  StaffDetailsModal({
    this.data,
    this.msg,
    this.responseCode,
  });

  factory StaffDetailsModal.fromMap(Map<String, dynamic> json) =>
      StaffDetailsModal(
        data: json["data"] != null
            ? List<StaffDetail>.from(
                json["data"].map((x) => StaffDetail.fromMap(x)))
            : [],
        msg: (json['msg'] ?? "").toString(),
        responseCode: (json['responseCode'] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "msg": msg,
        "responseCode": responseCode,
      };
}

class StaffDetail {
  String? staffid;
  String? userId;
  String? email;
  String? address;
  String? name;
  String? avatar;

  StaffDetail({
    this.staffid,
    this.userId,
    this.email,
    this.address,
    this.name,
    this.avatar,
  });

  factory StaffDetail.fromMap(Map<String, dynamic> json) => StaffDetail(
        staffid: (json["staffid"] ?? "").toString(),
        userId: (json["userId"] ?? "").toString(),
        email: (json["email"] ?? "").toString(),
        address: (json["address"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        avatar: (json["avatar"] ?? "").toString(),
      );

  Map<String, dynamic> toMap() => {
        "staffid": staffid,
        "userId": userId,
        "email": email,
        "address": address,
        "name": name,
        "avatar": avatar,
      };
}

class StaffClassModel {
  List<Data>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  StaffClassModel(
      {this.data, this.msg, this.responseCode, this.additionalData});

  StaffClassModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    msg = json['msg'];
    responseCode = json['responseCode'];
    additionalData = json['additionalData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    data['responseCode'] = responseCode;
    data['additionalData'] = additionalData;
    return data;
  }
}

class Data {
  int? dataListItemId;
  String? dataListItemName;
  String? dataListId;
  String? dataListName;
  String? status;
  bool? isClassTeacher;

  Data(
      {this.dataListItemId,
      this.dataListItemName,
      this.dataListId,
      this.dataListName,this.isClassTeacher,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    dataListItemId = json['dataListItemId'];
    dataListItemName = json['dataListItemName'];
    dataListId = json['dataListId'];
    dataListName = json['dataListName'];
    isClassTeacher=json['isClassTeacher'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataListItemId'] = dataListItemId;
    data['dataListItemName'] = dataListItemName;
    data['dataListId'] = dataListId;
    data['dataListName'] = dataListName;
    data['status'] = status;
    return data;
  }
}
