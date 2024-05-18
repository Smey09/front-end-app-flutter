import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_post_app/theme/theme_colors.dart';

import '../../controllers/auth/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "smey@gmail.com");
  final nameController = TextEditingController(text: "Smey Flutter");
  final passwordController = TextEditingController(text: "123");

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(RegisterController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: GetBuilder<RegisterController>(builder: (_) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  BackgroundColor.colorWhite,
                  BackgroundColor.mySecondThemeColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        _controller.image != null
                            ? CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(_controller.image!),
                              )
                            : const CircleAvatar(
                                radius: 70,
                                child: Text("No Image"),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(1),
                            child: IconButton(
                              onPressed: () {
                                _controller.pickImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                size: 30,
                                color: IconColor.colorLightBlue,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: IconColor.colorLightBlue,
                        ),
                        label: Text("Email"),
                      ),
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!GetUtils.isEmail(email)) {
                          return "Email is not valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: IconColor.colorLightBlue,
                        ),
                        label: Text("Name"),
                      ),
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: IconColor.colorLightBlue,
                        ),
                        label: Text("Password"),
                      ),
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _controller.register(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            child: const Text("Register"),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
