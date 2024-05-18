import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:we_post_app/controllers/profile/profile_controller.dart';
import '../../constant.dart';

String _getTimeDifferenceText(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);
  if (difference.inHours < 24) {
    // return DateFormat('jm').format(createdAt.toLocal());
    return "today ${DateFormat('jm').format(createdAt.toLocal())}";
  } else {
    return '${difference.inDays} days ago';
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (_) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = controller.userData!.user;
          return Center(
            child: Column(
              children: [
                user!.profilePic != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          "${kBaseUrl}${user.profilePic!}",
                        ),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyVW0tuAD1DW9CENQmqJK4WLQakyqaZUHmDx2ew9q5LA&s"),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${user.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text("${user.email}"),
                Text(
                  _getTimeDifferenceText(DateTime.parse(user.createdAt!)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
