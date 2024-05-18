// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:get/get.dart';
import 'package:we_post_app/controllers/auth/login_controller.dart';
import 'package:we_post_app/screens/auth/register_screen.dart';
import 'package:we_post_app/theme/theme_colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "Ching168@gmail.com");
  final passwordController = TextEditingController(text: "123");

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: BackgroundColor.colorWhite,
        body: Container(
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
                  Image.asset(
                    "assets/images/Media-Logo.png",
                    width: 150,
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
                    controller: passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        color: IconColor.colorLightBlue,
                      ),
                      label: Text("Password"),
                    ),
                    validator: (password) {
                      if (password!.isEmpty) {
                        return "Please enter your password";
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
                            backgroundColor: ButtonColor.buttonStyle1,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final email = emailController.text;
                              final password = passwordController.text;
                              controller.login(
                                  email: email, password: password);
                            }
                          },
                          child: const Text("Login"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Press forget password");
                      Get.snackbar(
                        "Forget Password",
                        "Please reset your password",
                        backgroundColor: BackgroundColor.colorYellow,
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: const Text(
                      "forgot password?",
                      style: TextStyle(
                        color: IconColor.colorLightBlue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 92, 187)),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "--- Or ---",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: FontColor.colorBlack,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            print("Press to login with email...");
                            IconSnackBar.show(
                              context,
                              snackBarType: SnackBarType.alert,
                              snackBarStyle: const SnackBarStyle(
                                maxLines: 1,
                              ),
                              label: 'Press to login with email...',
                            );
                          },
                          icon: const Icon(
                            Icons.mail,
                            color: IconColor.colorBlack,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("Press to login with facebook...");
                            IconSnackBar.show(
                              context,
                              snackBarType: SnackBarType.alert,
                              snackBarStyle: const SnackBarStyle(
                                maxLines: 1,
                              ),
                              label: 'Press to login with facebook...',
                            );
                          },
                          icon: const Icon(
                            Icons.facebook,
                            color: IconColor.colorBlack,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("Press to login with tiktok...");
                            IconSnackBar.show(
                              context,
                              snackBarType: SnackBarType.alert,
                              snackBarStyle: const SnackBarStyle(
                                maxLines: 1,
                              ),
                              label: 'Press to login with tiktok...',
                            );
                          },
                          icon: const Icon(
                            Icons.tiktok,
                            color: IconColor.colorBlack,
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print("Press to login with telegram...");
                            // Get.snackbar(
                            //   "Telegram",
                            //   "Login with telegram...",
                            //   backgroundColor: BackgroundColor.colorYellow,
                            //   duration: const Duration(seconds: 2),
                            // );
                            IconSnackBar.show(
                              context,
                              snackBarType: SnackBarType.alert,
                              snackBarStyle: const SnackBarStyle(
                                maxLines: 1,
                              ),
                              label: 'Press to login with telegram...',
                            );
                          },
                          icon: const Icon(
                            Icons.telegram,
                            color: IconColor.colorBlack,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
