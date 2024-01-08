import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/auth_model.dart';

class AuthController extends GetxController {
  final AuthModel _authModel = AuthModel();

  RxBool isLoading = false.obs;

  Future<void> signUp(String email, String password) async {
    isLoading.value = true;
    await _authModel.signUp(email, password);
    isLoading.value = false;
    update();
  }

  Future<void> signIn(String email, String password) async {
    isLoading.value = true;
    await _authModel.signIn(email, password);
    isLoading.value = false;
    update();
  }
}

class SharedPreferencesService {
  static const String dataKey = 'Email';

  static Future<void> setData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(dataKey, value);
  }

  static Future<String> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedData = prefs.getString(dataKey) ?? '';
    return storedData;
  }
}
