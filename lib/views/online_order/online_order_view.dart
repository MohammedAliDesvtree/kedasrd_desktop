import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';

import 'package:kedasrd_windows/widgets/custom_icon_button.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class OnlineOrderView extends StatefulWidget {
  const OnlineOrderView({super.key});

  @override
  State<OnlineOrderView> createState() => _OnlineOrderViewState();
}

class _OnlineOrderViewState extends State<OnlineOrderView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Image.asset(
          Images.onlineOrderSc,
          height: size.height,
          width: size.width,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 48.0,
          left: 48.0,
          child: CustomIconButton(
            icon: Images.home,
            size: 48.0,
            iconPadding: 14.0,
            onTap: () => {
              Get.offNamedUntil('/landing', (route) => false),
              controller.onMenuMainItemTapped("POS"),
            },
          ),
        ),
      ],
    );
  }
}
