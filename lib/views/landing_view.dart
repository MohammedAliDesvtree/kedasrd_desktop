import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';

import 'package:kedasrd_windows/widgets/body_view.dart';
import 'package:kedasrd_windows/widgets/drawer_view.dart';
import 'package:kedasrd_windows/widgets/header_view.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        backgroundColor: Themes.kLightColor,
        body: Column(
          children: [
            const HeaderView(),
            Expanded(
              child: Row(
                children: [
                  const DrawerView(),
                  Expanded(
                    child: Container(
                      height: size.height,
                      width: size.width,
                      color: Themes.kLightColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyView(
                            title: controller.screenTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
