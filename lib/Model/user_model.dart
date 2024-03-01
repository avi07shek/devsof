import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? productModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String productModelToJson(UserModel? data) => json.encode(data!.toJson());

class UserModel {
  String? id;
  String? userId;
  String? fullname;
  String? email;
  String? password;

  UserModel({this.id, this.userId, this.fullname, this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      userId: json["user_id"],
      fullname: json["fullname"],
      email: json["email"],
      password: json["password"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "fullname": fullname,
        "email": email,
        "password": password,
      };

  factory UserModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      UserModel(
        id: json.id,
        userId: json["user_id"],
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
      );
}
