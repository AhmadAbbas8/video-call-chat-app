import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/user_model.dart';

abstract class HomeFirebaseDataSource {
  Future<List<UserModel>> getAllUsers();
}

class HomeFirebaseDataSourceImpl implements HomeFirebaseDataSource {
  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      var usersJson = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      print(usersJson.docs);
      var users =
          usersJson.docs.map((e) => UserModel.fromJson(e.data())).toList();

      return users;
    } catch (ex) {
      log(ex.toString());
      return [];
    }
  }
}
