import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xgen/model/auth_model.dart';

import '../../constants.dart';
import '../../controllers/firebase_controller.dart';

class NotePage extends StatelessWidget {
  final FirebaseController firebaseController = Get.put(FirebaseController());
  final NoteController noteController = Get.put(NoteController());
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<FirebaseController>(
          builder: (controller) => Form(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: noteController.titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: noteController.contentController,
                    decoration: const InputDecoration(labelText: 'Note'),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Note';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await firebaseController.addUserData(UserData(
                            title: noteController.titleController.text,
                            content: noteController.contentController.text,
                            timestamp: DateTime.now()));
                        await firebaseController.fetchUserData();

                        Get.back();
                        Get.snackbar("Noted Added", "Succesful");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5.0,
                      backgroundColor: buttonColor,
                      shadowColor: const Color.fromARGB(255, 67, 21, 21),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
