import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/wrap_list.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WrapList(
      data: DummyData.dashboardList,
      onItemTap: (title) =>
          controller.onMenuInnerItemTapped(context, size, title),
    );
  }
}
