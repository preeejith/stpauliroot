

import 'dart:convert';

NotificationModalClass notificationModalClassFromJson(String str) => NotificationModalClass.fromJson(json.decode(str));


class NotificationModalClass {
  List<NotificationDatum>? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  NotificationModalClass({
    this.data,
    this.msg,
    this.responseCode,
    this.additionalData,
  });

  factory NotificationModalClass.fromJson(Map<String, dynamic> json) => NotificationModalClass(
    data: json["data"] == null ? [] : List<NotificationDatum>.from(json["data"]!.map((x) => NotificationDatum.fromJson(x))),
    msg: json["msg"],
    responseCode: json["responseCode"],
    additionalData: json["additionalData"],
  );


}

class NotificationDatum {
  int? id;
  int? userId;
  String? title;
  String? body;
  bool? isRead;

  NotificationDatum({
    this.id,
    this.userId,
    this.title,
    this.body,
    this.isRead,
  });

  factory NotificationDatum.fromJson(Map<String, dynamic> json) => NotificationDatum(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    body: json["body"],
    isRead: json["isRead"],
  );


}
