import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_post_app/screens/auth/login_screen.dart';
import 'package:we_post_app/screens/posts/create_post_screen.dart';
import 'package:we_post_app/screens/posts/post_screen.dart';
import 'package:we_post_app/screens/profile/profile_screen.dart';
import 'package:we_post_app/screens/settings/setting_screen.dart';
import 'package:we_post_app/theme/theme_colors.dart';

import '../controllers/main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final _lstScreens = [
    PostScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    return GetBuilder<MainController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "We Post",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => const CreatePostScreen());
                },
                icon: const Icon(Icons.camera_alt_rounded),
              ),
              IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    icon: const Icon(
                      Icons.logout,
                      size: 40,
                      color: IconColor.colorRed,
                    ),
                    content: const Text(
                      'Are you sure you want to logout ?',
                      style: TextStyle(
                        color: FontColor.colorBlack,
                        fontSize: 17,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: FontColor.colorRed,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final box = GetStorage();
                          box.remove('token');
                          Get.offAll(LoginScreen());
                          Get.snackbar(
                            "Successfuly",
                            "You have successfully logged out",
                            backgroundColor: BackgroundColor.colorWhite,
                            colorText: FontColor.colorLightBlue,
                            duration: const Duration(seconds: 2),
                          );
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: _lstScreens[controller.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.onTabTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
