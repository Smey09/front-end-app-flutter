import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:we_post_app/theme/theme_colors.dart';

import '../../constant.dart';
import '../../data/models/comment_res_model.dart';
import '../../data/models/post_res_model.dart';
import '../../data/providers/api_provider.dart';

class PostController extends GetxController {
  final _api = Get.put(APIProvider());
  PostResModel? posts;
  bool isLoading = false;
  final _commentController = TextEditingController();
  List<CommentResModel> comments = [];
  String _getTimeDifferenceText(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inHours < 24) {
      return DateFormat('jm').format(createdAt.toLocal());
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  refreshData() {
    getAllPosts();
  }

  void getAllPosts() async {
    try {
      isLoading = true;
      update();
      final posts = await _api.fetchPosts();
      this.posts = posts;
      print("posts $posts");
      isLoading = false;
      update(); // refresh the UI
    } catch (e) {
      isLoading = false;
      update();
      print(e);
      Get.snackbar(
          "Error", "Error occured while fetching posts:${e.toString()}");
    }
  }

  void likeDisLike({required int id, required int index}) async {
    try {
      final post = posts!.data![index];
      final status = await _api.likeDisLike(id: id);
      if (post.liked!) {
        post.liked = false;
        post.likesCount = post.likesCount! - 1;
      } else {
        post.liked = true;
        post.likesCount = post.likesCount! + 1;
      }
      update();
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Error occured while liking post:${e.toString()}");
    }
  }

  void getComment(int postId) async {
    final comments = await _api.getCommentByPost(postId: postId);
    this.comments = comments;
  }

  void onComment({required int postId}) async {
    getComment(postId);
    print("comments $comments");
    Get.bottomSheet(
      GetBuilder<PostController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Get.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
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
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final user = comments[index].user;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "${kBaseUrl}${user!.profilePic}"),
                                          ),
                                          const SizedBox(width: 5),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${user.name}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                              Text(
                                                _getTimeDifferenceText(
                                                    DateTime.parse(
                                                        comments[index]
                                                            .createdAt!)),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.more_vert),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("${comments[index].text}"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.file_open)),
                        Expanded(
                          child: TextField(
                            controller: _commentController,
                            decoration: const InputDecoration(
                              hintText: "Enter your comment",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              final comment = _commentController.text;
                              if (comment.isNotEmpty) {
                                onSendComment(postId: postId, text: comment);
                              } else {
                                Get.snackbar(
                                    "Message", "Comment cannot be empty");
                              }
                              update();
                            },
                            icon: const Icon(Icons.send))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void onSendComment({required int postId, required String text}) async {
    try {
      final response = await _api.createComment(postId: postId, text: text);
      Get.snackbar("Success", "Comment sent successfully");
      _commentController.clear();
      getComment(postId);
      update();
      print("response $response");
    } catch (e) {
      print(e);
      Get.snackbar(
          "Error", "Error occured while sending comment:${e.toString()}");
    }
  }
}
