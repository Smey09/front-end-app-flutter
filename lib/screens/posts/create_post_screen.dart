import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/posts/create_post_controller.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(CreatePostController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            IconButton(
              onPressed: () {
                _controller.createPost();
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<CreatePostController>(
            builder: (_) {
              return Column(
                children: [
                  TextField(
                    controller: _controller.caption,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: "Write something...",
                      label: Text("Caption"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _controller.photo == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _controller.pickImage,
                              child: Container(
                                height: 100,
                                width: 100,
                                color: Colors.grey.withOpacity(.5),
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Image.file(_controller.photo!),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    _controller.photo = null;
                                    _controller.update();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
