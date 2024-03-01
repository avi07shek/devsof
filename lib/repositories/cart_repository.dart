import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamropasal/Model/favorite_model.dart';
import '../Model/SingleProductModel.dart';
import '../services/service_management.dart';

class CartRepository {
  CollectionReference<SingleProductModel> productRef =
      FirebaseService.db.collection("carts").withConverter<SingleProductModel>(
            fromFirestore: (snapshot, _) {
              return SingleProductModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );

  Future<List<QueryDocumentSnapshot<SingleProductModel>>>
      getAllProducts() async {
    try {
      final response = await productRef.get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<SingleProductModel>>> getProductFromList(
      List<String> productIds) async {
    try {
      final response = await productRef
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<SingleProductModel>>> getMyProducts(
      String userId) async {
    try {
      final response =
          await productRef.where("user_id", isEqualTo: userId).get();
      var products = response.docs;
      return products;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> removeProduct(String productId, String userId) async {
    try {
      final response = await productRef.doc(productId).get();
      if (response.data()!.userId != userId) {
        return false;
      }
      await productRef.doc(productId).delete();
      return true;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<SingleProductModel>> getOneProduct(String id) async {
    try {
      final response = await productRef.doc(id).get();
      if (!response.exists) {
        throw Exception("Product doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool?> addProductsToCart({required SingleProductModel product}) async {
    try {
      final response = await productRef.add(product);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool?> favorites({required SingleProductModel product}) async {
    try {
      final response = await productRef.add(product);
      return true;
    } catch (err) {
      return false;
      rethrow;
    }
  }
}
