import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  Data? data;
  String? msg;
  String? responseCode;
  String? additionalData;

  LoginResponse({
    required this.data,
    required this.msg,
    required this.responseCode,
    required this.additionalData,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
        responseCode: json["responseCode"],
        additionalData: json["additionalData"],
      );
}

class Data {
  String? tokenType;
  String? accessToken;
  int? expiresIn;
  int? userId;
  String? userRoleId;

  Data({
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.userId,
    required this.userRoleId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        expiresIn: json["expires_in"],
        userId: json["userId"],
        userRoleId: json["userRoleId"],
      );
}
