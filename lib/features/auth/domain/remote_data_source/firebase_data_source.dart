import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseDataSource {
  Future<User?> login({
    required String email,
    required String password,
  });

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
  });
}

class FirebaseDataSourceImpl implements FirebaseDataSource {
  @override
  Future<User?> login({required String email, required String password}) async {
    var userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<User?> signUp(
      {required String email,
      required String password,
      required String name}) async {
    var userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
        'uid': userCredential.user?.uid,
        'createdAt': DateTime.now().toIso8601String(),
        'image': 'https://th.bing.com/th/id/OIP.z6mejm1rZ-RJ9wxhdSm6qAAAAA?rs=1&pid=ImgDetMain',
      });
    } catch (ex) {
      log(ex.toString());
    }
    return userCredential.user;
  }
}
