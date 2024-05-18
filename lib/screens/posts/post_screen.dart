import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:we_post_app/constant.dart';
import 'package:we_post_app/controllers/posts/post_controller.dart';

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

class PostScreen extends StatelessWidget {
  final GlobalKey _menuKey = GlobalKey();
  PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isButtonPressed = false;
    final button = PopupMenuButton(
        key: _menuKey,
        itemBuilder: (_) => const <PopupMenuItem<String>>[
              PopupMenuItem<String>(value: 'Doge', child: Text('Doge')),
              PopupMenuItem<String>(value: 'Lion', child: Text('Lion')),
            ],
        onSelected: (_) {});
    final controller = Get.put(PostController());
    return Scaffold(
      body: GetBuilder<PostController>(builder: (_) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final posts = controller.posts!.data;
        if (posts == null || posts.isEmpty) {
          return const Center(
            child: Text("No posts found"),
          );
        }
        return RefreshIndicator(
          onRefresh: () {
            controller.getAllPosts();
            return Future.value(true);
          },
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "$kBaseUrl${posts[index].user!.profilePic}"),
                          radius: 27,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${posts[index].user!.name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _getTimeDifferenceText(
                                  DateTime.parse(posts[index].createdAt!)),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        PopupMenuButton(
                          onSelected: (value) {
                            // your logic
                          },
                          itemBuilder: (BuildContext bc) {
                            return const [
                              PopupMenuItem(
                                child: Text("Edit"),
                                value: '/hello',
                              ),
                              PopupMenuItem(
                                child: Text("Delete"),
                                value: '/about',
                              ),
                            ];
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${posts[index].caption}",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // image of post section
                  posts[index].image == null
                      ? Container()
                      : Image.network("$kBaseUrl/posts/${posts[index].image}"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text("${posts[index].likesCount} likes"),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("${posts[index].commentsCount} comments"),
                      ],
                    ),
                  ),
                  const Divider(),
                  // show comment count
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // isButtonPressed = !isButtonPressed;
                            print("List of ${posts[index].likesCount} likes");
                            controller.likeDisLike(
                                id: posts[index].id!, index: index);
                          },
                          child: Container(
                            height: 30,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.blue.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  posts[index].liked!
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: posts[index].liked!
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Like",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.onComment(postId: posts[index].id!);
                          },
                          child: Container(
                            height: 30,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.blue.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${posts[index].commentsCount} comments",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Sharing....");
                            IconSnackBar.show(
                              context,
                              snackBarType: SnackBarType.success,
                              snackBarStyle: const SnackBarStyle(
                                maxLines: 1,
                              ),
                              label: 'Sharing....',
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 115,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1.0,
                                color: Colors.blue.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.reply_outlined,
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "Share",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
