
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/Home/home_screen.dart';
import '../view/sign_up_view.dart';

class SplashController extends GetxController {
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailCheck = prefs.getString('Email');

    if (emailCheck != null) {
      Get.to(() => Home());
    } else {
      Get.to(() => SignUpView());
    }
  }
}
