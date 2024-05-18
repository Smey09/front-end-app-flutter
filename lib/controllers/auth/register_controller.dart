import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_post_app/data/providers/api_provider.dart';

class RegisterController extends GetxController {
  final _picker = ImagePicker();
  File? image;
  final _apiProvider = Get.put(APIProvider());

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path); // convert XFile to File
      update(); // method update to fresh the UI
    }
  }

  void register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final result = await _apiProvider.register(
          email: email, name: name, password: password, image: image);
      if (result) {
        // Get.snackbar("Success", "Registered successfully");
        Get.back();
      } else {
        Get.snackbar(
          "Failed",
          "Failed to register",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
