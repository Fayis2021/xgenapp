import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/auth_model.dart';

class FirebaseController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  RxList<UserData> userDatas = <UserData>[].obs;
  RxBool apicallCondition = false.obs;
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> addUserData(UserData userData) async {
    try {
      var a = await userDataCollection.add({
        'title': userData.title,
        'content': userData.content,
        'timestamp': userData.timestamp,
      });
    } catch (e) {
      print('Error adding user data: $e');
    }
  }

  Future<void> fetchUserData() async {
    try {
      var querySnapshot = await userDataCollection.get();

      userDatas.assignAll(
        querySnapshot.docs.map(
          (doc) => UserData.fromMap(doc.data() as Map<String, dynamic>),
        ),
      );
      apicallCondition.value = true;
    } catch (e) {
      print('Error fetching data: $e');
    }
    update();
  }
}

class NoteController extends GetxController {
  final FirebaseController firebaseController = Get.put(FirebaseController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void submitData() {
    UserData userData = UserData(
      title: titleController.text,
      content: contentController.text,
      timestamp: DateTime.now(),
    );

    firebaseController.addUserData(userData);
  }
}
