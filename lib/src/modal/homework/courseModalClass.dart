import 'dart:convert';

CourseModalClass courseModalClassFromJson(String str) =>
    CourseModalClass.fromJson(json.decode(str));

class CourseModalClass {
  List<CourseData> data;
  String msg;
  String responseCode;
  String additionalData;

  CourseModalClass({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory CourseModalClass.fromJson(Map<String, dynamic> json) =>
      CourseModalClass(
        data: List<CourseData>.from(
            json["data"].map((x) => CourseData.fromJson(x))),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class CourseData {
  int subjectId;
  String subjectName;
  bool? isElective;

  CourseData({
    required this.subjectId,
    required this.subjectName,
    required this.isElective,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        subjectId: json["subjectId"],
        subjectName: json["subjectName"],
        isElective: json["isElective"],
      );
}
