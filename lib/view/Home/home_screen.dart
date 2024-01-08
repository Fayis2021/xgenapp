import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/firebase_controller.dart';
import '../../model/auth_model.dart';
import '../note_add_page/add_note.dart';
import 'inside_screen.dart';
import 'profile/profile_screen.dart';

class Home extends StatelessWidget {
  final FirebaseController controller = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
        leading: IconButton(
          onPressed: () {
            Get.to(() => const ProfileScreen());
          },
          icon: const Icon(Icons.person),
        ),
      ),
      body: GetBuilder<FirebaseController>(
        builder: (controller) {
          if (controller.userDatas.isEmpty &&
              controller.apicallCondition.value == false) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.userDatas.isEmpty &&
              controller.apicallCondition.value == true) {
            return const Center(child: Text('No data available.'));
          }

          return ListView.builder(
            itemCount: controller.userDatas.length,
            itemBuilder: (context, index) {
              UserData user = controller.userDatas[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => Inside_Show( userdata:user ,));
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      user.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 29, 28, 29)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.content,
                        ),
                        const SizedBox(height: 8.0),
                        Text('Timestamp: ${user.timestamp.toLocal()}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => NotePage()),
        label: const Text('Create Note'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
