import 'package:get/get.dart';
import 'package:we_post_app/data/providers/api_provider.dart';

import '../../data/models/user_res_model.dart';

class ProfileController extends GetxController {
  final _api = Get.put(APIProvider());
  UserResModel? userData;
  bool isLoading = false;

  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }

  void getUserProfile() async {
    try {
      isLoading = true;
      update();
      final user = await _api.getUserProfile();
      userData = user;
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      print(e);
      Get.snackbar("Message",
          "Error occured while fetching user profile:${e.toString()}");
    }
  }
}
