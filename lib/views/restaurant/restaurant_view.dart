import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/wrap_list.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({super.key});

  @override
  State<RestaurantView> createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    return WrapList(
      data: DummyData.restaurantList,
      onItemTap: (title) => controller.onRestaurantItemTapped(title),
    );
  }
}
