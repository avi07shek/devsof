import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hamropasal/services/service_management.dart';

import '../Model/user_model.dart';

class AuthRepository {
  CollectionReference<UserModel> userRef =
      FirebaseService.db.collection("users").withConverter(
          fromFirestore: (snapshot, _) {
            return UserModel.fromFirebaseSnapshot(snapshot);
          },
          toFirestore: (model, _) => model.toJson());

  Future<UserCredential?> register(UserModel user) async {
    try {
      final response =
          await userRef.where("email", isEqualTo: user.email!).get();
      if (response.size != 0) throw Exception("User email already exit");
      UserCredential _uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      user.userId = _uc.user!.uid;

      await FirebaseService.db.collection("users").add(user.toJson());
      return _uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential _uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String id) async {
    try {
      final respose = await userRef.where("user_id", isEqualTo: id).get();
      var user = respose.docs.single.data();
      // user.fcm = "";
      await userRef.doc(user.id).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      var res = await FirebaseService.firebaseAuth
          .sendPasswordResetEmail(email: email);
      return res;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseService.firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> deleteUser(String id) async {
    try {
      final response = await userRef.where("user_id", isEqualTo: id).get();
      var user = response.docs.single.data();
      await userRef.doc(user.id).delete();
      return user;
    } catch (err) {
      rethrow;
    }
  }
}
