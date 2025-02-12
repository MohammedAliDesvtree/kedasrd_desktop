import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/wrap_list.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class NewOrderView extends StatefulWidget {
  const NewOrderView({super.key});

  @override
  State<NewOrderView> createState() => _NewOrderViewState();
}

class _NewOrderViewState extends State<NewOrderView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return WrapList(
      data: DummyData.newOrderList,
      onItemTap: (title) =>
          controller.onNewOrderItemTapped(title, context, size, authController),
    );
  }
}
