import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class DrawerView extends StatefulWidget {
  final Function(String)? onMenuHover;

  const DrawerView({
    super.key,
    this.onMenuHover,
  });

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();
  final TablesController tablesController = Get.find<TablesController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Obx(
      () => Container(
        width: !controller.isHideDrawerMenu.value
            ? 74.0
            : ResponsiveHelper.getDrawerWidth(context),
        color: Themes.kWhiteColor,
        child: Column(
          children: [
            Expanded(
              child: Constants.scrollbarView(
                paddingRight: 0.0,
                child: SingleChildScrollView(
                  child: mainMenuList(context, size),
                ),
              ),
            ),
            logoutItem(
              "Setting",
              Images.setting,
              size,
            ),
            logoutItem(
              "Logout",
              Images.logout,
              size,
            ),
            const SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }

  Widget mainMenuList(BuildContext context, Size size) {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, top: 16.0),
      child: Column(
        children: List.generate(
          DummyData.dashboardList.length,
          (index) {
            var data = DummyData.dashboardList[index];
            return menuItem(data, index, context, size);
          },
        ),
      ),
    );
  }

  Widget menuItem(data, int index, BuildContext context, Size size) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      onEnter: (_) {
        if (widget.onMenuHover != null) {
          widget.onMenuHover!(data["title"]);
        }
      },
      onExit: (_) {
        // We don't clear the hover here because we want the submenu to stay open
        // when the mouse moves to it. The clearing will be handled by the submenu's onExit.
      },
      child: GestureDetector(
        onTap: () => controller.onMenuInnerItemTapped(
            context, size, data["title"], authController, tablesController),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Image.asset(
                data["icon"],
                height: 20.0,
                color: controller.isInnerSelected(index)
                    ? Themes.kPrimaryColor
                    : Themes.kDarkColor,
              ),
              if (controller.isHideDrawerMenu.value)
                Row(
                  children: [
                    const SizedBox(width: 14.0),
                    Text(
                      data["title"],
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                        fontWeight: controller.isInnerSelected(index)
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: controller.isInnerSelected(index)
                            ? Themes.kPrimaryColor
                            : Themes.kDarkColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutItem(String title, String icon, Size size) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (title == "Logout") {
            controller.onLogoutTapped(context, authController);
          } else {
            controller.onMenuTapped(
                context, size, title, authController, tablesController);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 20.0,
                color: Themes.kDarkColor,
              ),
              if (controller.isHideDrawerMenu.value)
                Row(
                  children: [
                    const SizedBox(width: 14.0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                        fontWeight: FontWeight.w600,
                        color: Themes.kDarkColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
