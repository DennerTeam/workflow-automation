import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workflow_automation/ui/pages/home_page.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void login() async {
    if (dotenv.env['ADMIN_USERNAME'] == username.value &&
        dotenv.env['ADMIN_PASSWORD'] == password.value) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      isLoggedIn.value = true;
      Get.offAll(HomePage()); // Navigate to HomeScreen
    } else {
      Get.snackbar("Error", "Invalid credentials",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn.value) {
      Get.offAll(HomePage()); // Navigate to HomeScreen if already logged in
    }
  }
}
