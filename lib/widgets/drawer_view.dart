import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({
    super.key,
  });

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width / 8,
      color: Themes.kWhiteColor,
      child: Column(
        children: [
          SizedBox(
            height: 70.0,
            child: Image.asset(
              Images.kedasPos,
              height: 24.0,
              width: 145.0,
            ),
          ),
          const SizedBox(height: 12.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  DummyData.homeDrawerItems.length,
                  (index) {
                    var data = DummyData.homeDrawerItems[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50.0,
                                  width: 9.0,
                                  decoration: BoxDecoration(
                                    color: controller.isMainSelected(index)
                                        ? Themes.kPrimaryColor
                                        : Themes.kWhiteColor,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(6.0),
                                      bottomRight: Radius.circular(6.0),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24.0),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller
                                        .onMenuMainItemTapped(data["title"]),
                                    child: Container(
                                      height: 50.0,
                                      width: size.width,
                                      padding: const EdgeInsets.only(
                                          left: 44.0, right: 16.0),
                                      decoration: BoxDecoration(
                                        color: controller.isMainSelected(index)
                                            ? Themes.kPrimaryColor
                                            : Themes.kWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data["title"],
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: controller
                                                      .isMainSelected(index)
                                                  ? Themes.kWhiteColor
                                                  : Themes.kDarkColor,
                                            ),
                                          ),
                                          index != 0
                                              ? const SizedBox.shrink()
                                              : Icon(
                                                  controller
                                                          .isMainSelected(index)
                                                      ? Icons
                                                          .keyboard_arrow_down
                                                      : Icons
                                                          .keyboard_arrow_right,
                                                  size: 24.0,
                                                  color: controller
                                                          .isMainSelected(index)
                                                      ? Themes.kWhiteColor
                                                      : Themes.kDarkColor,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24.0),
                              ],
                            ),
                            index != 0
                                ? const SizedBox.shrink()
                                : controller.isMainSelected(index)
                                    ? innerListView(context, size)
                                    : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
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
          const SizedBox(height: 84.0)
        ],
      ),
    );
  }

  Widget innerListView(BuildContext context, Size size) {
    return Container(
      margin: const EdgeInsets.only(left: 44.0, top: 16.0),
      child: Column(
        children: List.generate(
          DummyData.dashboardList.length,
          (innerIndex) {
            var data = DummyData.dashboardList[innerIndex];

            return Column(
              children: [
                // Main menu item
                innerItemView(data, innerIndex, context, size),

                // Show inner items based on selection
                if (controller.shouldShowInnerItems(data["title"]))
                  innerMenuInnerItems(data["title"], context, size),
              ],
              // ),
            );
          },
        ),
      ),
    );
  }

  Widget innerItemView(data, int innerIndex, BuildContext context, size) {
    return GestureDetector(
      onTap: () => controller.onMenuInnerItemTapped(
          context, size, data["title"], authController),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Image.asset(
              data["icon"],
              height: 18.0,
              color: controller.isInnerSelected(innerIndex)
                  ? Themes.kPrimaryColor
                  : Themes.kDarkColor,
            ),
            const SizedBox(width: 14.0),
            Text(
              data["title"],
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: controller.isInnerSelected(innerIndex)
                    ? FontWeight.w900
                    : FontWeight.w600,
                color: controller.isInnerSelected(innerIndex)
                    ? Themes.kPrimaryColor
                    : Themes.kDarkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget innerMenuInnerItems(
      String parentTitle, BuildContext context, Size size) {
    dynamic innerItems;
    int startIndex;

    switch (parentTitle) {
      case "Regular":
        innerItems = DummyData.posDrawerItems;
        startIndex = 10; // Base index for regular items
        break;
      case "Restaurant":
        innerItems = DummyData.restaurantDrawerItems;
        startIndex = 20; // Base index for restaurant items
        break;
      case "Fast Food":
        innerItems = DummyData.fastFoodDrawerItems;
        startIndex = 30; // Base index for fast food items
        break;
      case "Super Market":
        innerItems = DummyData.superMarketDrawerItems;
        startIndex = 40; // Base index for supermarket items
        break;
      case "Online Store":
        innerItems = DummyData.onlineStoreDrawerItems;
        startIndex = 50; // Base index for online store items
        break;
      default:
        return const SizedBox.shrink();
    }

    return Column(
      children: List.generate(
        innerItems.length,
        (index) {
          var innerData = innerItems[index];
          int itemIndex = (startIndex + innerItems.indexOf(innerData)).toInt();
          return Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: innerItemView(innerData, itemIndex, context, size),
          );
        },
      ),
    );
  }

  Widget logoutItem(String title, String icon, Size size) {
    return GestureDetector(
      onTap: () {
        if (title == "Logout") {
          controller.onLogoutTapped(context, authController);
        } else {
          controller.onMenuTapped(context, size, title);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 44.0),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 18.0,
              color: Themes.kDarkColor,
            ),
            const SizedBox(width: 14.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Themes.kDarkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
