import 'package:cloud_firestore/cloud_firestore.dart';

class SingleProductModel {
  String? id;
  String? userId;
  String? productName;
  String? productImage;
  String? productModel;
  double? productPrice;
  double? productOldPrice;
  String? productSecondImage;
  String? productThirdImage;
  String? productFourImage;
  SingleProductModel({
    this.id,
    this.userId,
    this.productThirdImage,
    this.productFourImage,
    this.productImage,
    this.productModel,
    this.productName,
    this.productOldPrice,
    this.productPrice,
    this.productSecondImage,
  });

  factory SingleProductModel.fromJson(Map<String, dynamic> json) =>
      SingleProductModel(
        id: json["id"],
        userId: json["user_id"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
      };

  factory SingleProductModel.fromFirebaseSnapshot(
          DocumentSnapshot<Map<String, dynamic>> json) =>
      SingleProductModel(
        id: json["id"],
        userId: json["user_id"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
      );
}
