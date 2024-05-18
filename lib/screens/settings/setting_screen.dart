
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_post_app/controllers/settings/setting_controller.dart';
import 'package:we_post_app/screens/auth/login_screen.dart';
import 'package:we_post_app/theme/theme_colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FontColor.colorBlack,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: BackgroundColor.colorWhite,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(fontSize: 15),
                    hintText: 'Search here...',
                    suffixIcon: const Icon(
                      Icons.search,
                      color: IconColor.colorLightBlue,
                      size: 30,
                    ),
                    // border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 290,
            ),
            Text("Comming soon..."),
            const SizedBox(
              height: 280,
            ),
            GestureDetector(
              onTap: () {
                print("Logout..........");
                final box = GetStorage();
                box.remove('token');
                Get.offAll(LoginScreen());
                Get.snackbar(
                  "Logout",
                  "Successfully logged out....",
                  colorText: Colors.white,
                  backgroundColor: BackgroundColor.colorLightBlue,
                );
              },
              child: Container(
                height: 30,
                width: 130,
                decoration: BoxDecoration(
                  color: BackgroundColor.colorRed,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: BackgroundColor.colorRed,
                    width: 1.0,
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      BackgroundColor.colorYellow,
                      BackgroundColor.mySecondThemeColor,
                    ], // List of colors to blend
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: FontColor.colorBlack,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.logout,
                      color: IconColor.colorRed,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
