// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromMap(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  final String id;
  final String token;
  final bool isFirstTime;

  LoginResponseModel({
    required this.id,
    required this.token,
    required this.isFirstTime,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["_id"],
        token: json["token"],
        isFirstTime: json["isFirstTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "token": token,
        "isFirstTime": isFirstTime,
      };
}
