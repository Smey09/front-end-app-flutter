import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/providers/api_provider.dart';
import '../../screens/main_screen.dart';

class LoginController extends GetxController {
  final _apiProvider = Get.put(APIProvider());
  final storage = GetStorage();

  void login({required String email, required String password}) async {
    try {
      final user = await _apiProvider.login(email: email, password: password);
      Get.snackbar("Success", "Logged in successfully",
          backgroundColor: Colors.green, colorText: Colors.white);
      storage.write('token', user.token);
      Get.offAll(() => MainScreen());
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
