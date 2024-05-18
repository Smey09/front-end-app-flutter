import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:we_post_app/screens/auth/login_screen.dart';

class MainController extends GetxController {
  final storage = GetStorage();
  var currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    isAuthenticated();
    super.onReady();
  }

  void isAuthenticated() {
    final token = storage.read('token');
    print("token $token");
    if (token == null) {
      Get.to(() => LoginScreen());
    }
  }

  void onTabTapped(int index) {
    currentIndex = index;
    update(); // refresh the UI
  }
}
