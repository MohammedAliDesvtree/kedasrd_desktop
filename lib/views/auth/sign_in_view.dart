import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/widgets/custom_text_input.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';
import 'package:kedasrd_windows/controllers/auth/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController controller = Get.put(SignInController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Themes.kWhiteColor,
      body: SafeArea(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            height: ResponsiveHelper.getLoginContainerHeight(context),
            width: ResponsiveHelper.getLoginContainerWidth(context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Themes.kWhiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Themes.kBlackColor.withOpacity(0.20),
                  blurRadius: 8.0,
                  spreadRadius: -3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(
                  ResponsiveHelper.isDesktop(context) ? 48.0 : 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.kedasLogo,
                            height: ResponsiveHelper.isDesktop(context)
                                ? 96.0
                                : 72.0,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            "Log into your KEDAS Account",
                            style: TextStyle(
                              fontSize:
                                  ResponsiveHelper.getFontSize(context, 25.0),
                              fontWeight: FontWeight.w500,
                              color: Themes.kBlackColor,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Hello, Welcome Back !!",
                            style: TextStyle(
                              fontSize:
                                  ResponsiveHelper.getFontSize(context, 16.0),
                              fontWeight: FontWeight.w400,
                              color: Themes.kGreyColor,
                            ),
                          ),
                          const SizedBox(height: 28.0),
                        ],
                      ),
                    ),
                    CustomTextInput(
                      hintText: "Email Address",
                      isNumber: false,
                      isEmail: true,
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 24.0),
                    Obx(
                      () => CustomTextInput(
                        hintText: "Password",
                        isNumber: false,
                        controller: controller.passwordController,
                        isSecure: controller.isPasswordShow.value,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    forgotPasswordButton(),
                    const SizedBox(height: 84.0),
                    submitButton(context, size, "Sign In"),
                    const SizedBox(height: 28.0),
                    signUpButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget forgotPasswordButton() {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Forgot Password ?",
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 16.0),
            fontWeight: FontWeight.w400,
            color: Themes.kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 18.0),
            fontWeight: FontWeight.w400,
            color: Themes.kGreyColor,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 18.0),
              fontWeight: FontWeight.w400,
              color: Themes.kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget submitButton(BuildContext context, Size size, String title) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () => controller.handleLogin(context, authController),
        child: Ink(
          decoration: BoxDecoration(
              color: Themes.kPrimaryColor,
              borderRadius: BorderRadius.circular(6.0)),
          child: Container(
            height: 52.0,
            width: size.width,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                fontWeight: FontWeight.w500,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
