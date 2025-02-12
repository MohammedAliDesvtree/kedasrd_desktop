import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/constants.dart';

class SignInController extends GetxController {
  RxBool isPasswordShow = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin(context, dynamic authController) async {
    final success = await authController.login(
      emailController.text,
      passwordController.text,
    );
    if (success) {
      Get.offAllNamed("landing");
    } else {
      CustomSnackBar.showTopRightSnackBar(
        context,
        'Invalid credentials!',
      );
    }
  }

  void togglePassword() {
    isPasswordShow.value = !isPasswordShow.value;
  }
}
