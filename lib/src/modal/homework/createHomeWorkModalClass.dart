import 'dart:convert';

CreateHomeWorkModalClass createHomeWorkModalClassFromJson(String str) =>
    CreateHomeWorkModalClass.fromJson(json.decode(str));

class CreateHomeWorkModalClass {
  dynamic data;
  String msg;
  String responseCode;
  String additionalData;

  CreateHomeWorkModalClass({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory CreateHomeWorkModalClass.fromJson(Map<String, dynamic> json) =>
      CreateHomeWorkModalClass(
        data: json["data"],
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}
