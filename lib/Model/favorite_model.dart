// To parse this JSON data, do
//
//     final favoriteModel = favoriteModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamropasal/Model/SingleProductModel.dart';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  FavoriteModel({
    this.id,
    this.userId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productId,
  });

  String? id;
  String? userId;
  String? productName;
  String? productImage;
  String? productPrice;
  String? productId;

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        userId: json["user_id"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
        "product_id": productId,
      };

  factory FavoriteModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      FavoriteModel(
        id: json["id"],
        userId: json["user_id"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
        productId: json["product_id"],
      );
}
