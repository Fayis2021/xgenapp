import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/splash_controllers.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});
   final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/splash.gif"),
      ),
    );
  }
}
