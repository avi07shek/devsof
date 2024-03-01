import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/favorite_model.dart';
import '../services/service_management.dart';

class FavoriteRepository {
  CollectionReference<FavoriteModel> favoriteRef =
      FirebaseService.db.collection("favorites").withConverter<FavoriteModel>(
            fromFirestore: (snapshot, _) {
              return FavoriteModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<List<QueryDocumentSnapshot<FavoriteModel>>> getFavorites(
      String productId, String userId) async {
    try {
      var data = await favoriteRef
          .where("user_id", isEqualTo: userId)
          .where("product_id", isEqualTo: productId)
          .get();
      var favorites = data.docs;
      return favorites;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<QueryDocumentSnapshot<FavoriteModel>>> getFavoritesUser(
      String userId) async {
    try {
      var data = await favoriteRef.where("user_id", isEqualTo: userId).get();
      var favorites = data.docs;
      return favorites;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> favorite({required FavoriteModel product}) async {
    try {
      await favoriteRef.add(product);
      return true;
    } catch (err) {
      rethrow;
    }
  }
}
