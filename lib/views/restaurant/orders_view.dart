import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final AuthController authController = Get.find<AuthController>();
  final TablesController tablesController = Get.find<TablesController>();
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling to avoid conflicts
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Ensuring 4 items per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 3.0, // Adjust this ratio if needed
      ),
      itemCount: DummyData.ordersItems.length,
      itemBuilder: (context, index) {
        var data = DummyData.ordersItems[index];
        return Material(
          color: Themes.kTransparent,
          child: MouseRegion(
            cursor: SystemMouseCursors.click, // Changes cursor to hand
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () => controller.onMenuTapped(
                context,
                size,
                data["title"],
                authController,
                tablesController,
              ),
              child: Ink(
                decoration: BoxDecoration(
                    color: Themes.kPrimaryColor,
                    borderRadius: BorderRadius.circular(8.0)),
                child: Container(
                  height: 161.0,
                  width: ResponsiveHelper.isDesktop(context)
                      ? size.width / 3.9
                      : size.width / 4.0,
                  alignment: Alignment.center,
                  child: Text(
                    data["title"],
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 20.0),
                      fontWeight: FontWeight.bold,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
