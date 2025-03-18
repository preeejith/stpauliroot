import 'dart:convert';

AdminClassModalClass adminClassModalClassFromJson(String str) =>
    AdminClassModalClass.fromJson(json.decode(str));

class AdminClassModalClass {
  List<AdminClassDatum>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  AdminClassModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory AdminClassModalClass.fromJson(Map<String, dynamic> json) =>
      AdminClassModalClass(
        data: json["data"] == null
            ? []
            : List<AdminClassDatum>.from(
                json["data"]!.map((x) => AdminClassDatum.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class AdminClassDatum {
  int? classId;
  String? className;

  AdminClassDatum({
    this.classId,
    this.className,
  });

  factory AdminClassDatum.fromJson(Map<String, dynamic> json) =>
      AdminClassDatum(
        classId: json["classId"],
        className: json["className"],
      );
}
