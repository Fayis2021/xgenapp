import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xgen/view/Home/home_screen.dart';
import '../controllers/auth_controllers.dart';
import '../view/Sign_in_view.dart';


class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        goTHome();
      }
      await SharedPreferencesService.setData(email);
      return userCredential.user;
    } catch (e) {
      Get.snackbar("Failed ", "Try Agin After some Times");
      return null;
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        goTHome();
      }
      await SharedPreferencesService.setData(email);
      return userCredential.user;
    } catch (e) {
      Get.snackbar("Failed", "Please check Email And Password");
      return null;
    }
  }

  void goTHome() {
    Get.to(() => Home());
  }
}

//main Data Model
class UserData {
  final String title;
  final String content;
  final DateTime timestamp;

  UserData({
    required this.title,
    required this.content,
    required this.timestamp,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      timestamp: map['timestamp'].toDate(),
    );
  }
}
