import 'package:flutter/material.dart';

import '../../model/auth_model.dart';

class Inside_Show extends StatelessWidget {
  Inside_Show({super.key, required this.userdata});
  UserData userdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userdata.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              userdata.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(userdata.content),
            Text(userdata.timestamp.toString()),
          ],
        ),
      ),
    );
  }
}
