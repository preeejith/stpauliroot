import 'dart:convert';

StaffModalClass staffModalClassFromJson(String str) =>
    StaffModalClass.fromJson(json.decode(str));

class StaffModalClass {
  List<StaffData> data;
  String msg;
  String responseCode;
  String additionalData;

  StaffModalClass({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory StaffModalClass.fromJson(Map<String, dynamic> json) =>
      StaffModalClass(
        data: List<StaffData>.from(
            json["data"].map((x) => StaffData.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class StaffData {
  String? staffName;
  String? username;
  String? password;
  String? description;
  int? staffId;

  StaffData({
    required this.staffName,
    required this.username,
    required this.password,
    required this.description,
    required this.staffId,
  });

  factory StaffData.fromJson(Map<String, dynamic> json) => StaffData(
        staffName: json["staffName"],
        username: json["username"],
        password: json["password"],
        description: json["description"],
        staffId: json["staffId"],
      );
}
