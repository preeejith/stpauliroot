import 'dart:convert';

AdminSectionModalClass adminSectionModalClassFromJson(String str) =>
    AdminSectionModalClass.fromJson(json.decode(str));

class AdminSectionModalClass {
  List<AdminSectionDatum>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  AdminSectionModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory AdminSectionModalClass.fromJson(Map<String, dynamic> json) =>
      AdminSectionModalClass(
        data: json["data"] == null
            ? []
            : List<AdminSectionDatum>.from(
                json["data"]!.map((x) => AdminSectionDatum.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class AdminSectionDatum {
  int? sectionId;
  String? section;
  dynamic datumClass;
  String? classId;

  AdminSectionDatum({
    this.sectionId,
    this.section,
    this.datumClass,
    this.classId,
  });

  factory AdminSectionDatum.fromJson(Map<String, dynamic> json) =>
      AdminSectionDatum(
        sectionId: json["sectionId"],
        section: json["section"],
        datumClass: json["class"],
        classId: json["classId"],
      );
}
