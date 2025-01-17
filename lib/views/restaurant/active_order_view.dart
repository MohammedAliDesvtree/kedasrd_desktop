import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/wrap_list.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class ActiveOrderView extends StatefulWidget {
  const ActiveOrderView({super.key});

  @override
  State<ActiveOrderView> createState() => _ActiveOrderViewState();
}

class _ActiveOrderViewState extends State<ActiveOrderView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    return WrapList(
      data: DummyData.activeOrderList,
      onItemTap: (title) => controller.onActiveOrderItemTapped(title),
    );
  }
}
