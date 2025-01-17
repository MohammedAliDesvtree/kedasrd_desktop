import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Wrap(
      runSpacing: 16.0,
      spacing: 16.0,
      children: List.generate(
        DummyData.ordersItems.length,
        (index) {
          var data = DummyData.ordersItems[index];
          return Material(
            color: Themes.kTransparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () =>
                  controller.onMenuTapped(context, size, data["title"]),
              child: Ink(
                decoration: BoxDecoration(
                    color: Themes.kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  height: 161.0,
                  width: size.width / 3.6,
                  alignment: Alignment.center,
                  child: Text(
                    data["title"],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
