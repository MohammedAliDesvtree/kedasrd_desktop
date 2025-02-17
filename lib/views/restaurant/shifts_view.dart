import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class ShiftsView extends StatefulWidget {
  const ShiftsView({super.key});

  @override
  State<ShiftsView> createState() => _ShiftsViewState();
}

class _ShiftsViewState extends State<ShiftsView> {
  final AuthController authController = Get.find<AuthController>();
  final TablesController tablesController = Get.find<TablesController>();
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  void initState() {
    super.initState();
    controller.selectedIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 250.0,
          color: Themes.kWhiteColor,
          child: shiftsListView(context, size),
        ),
        const SizedBox(width: 24.0),
        Expanded(
          child: SizedBox(
            width: size.width,
            child: Column(
              children: [
                Obx(() => shiftsDetailsHeaderView(
                    context, size, controller.selectedIndex.value)),
                const SizedBox(height: 16.0),
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 16.0),
                    color: Themes.kWhiteColor,
                    child: shiftsDetailsView(context, size)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget shiftsListView(BuildContext context, Size size) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(controller.totalItemCounts,
            (index) => shiftItem(context, size, index)),
      ),
    );
  }

  Widget shiftItem(BuildContext context, Size size, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => controller.selectedIndex.value = index,
          child: Obx(
            () => Container(
              color: controller.selectedIndex.value == index
                  ? Themes.kPrimaryColor.withOpacity(0.2)
                  : Themes.kWhiteColor,
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemBullet(
                      index == 0 ? "Shifts In Progress" : "Closure No $index",
                      16.0,
                      FontWeight.w600,
                      Themes.kPrimaryColor),
                  const SizedBox(height: 4.0),
                  itemBullet("02/11/2022 01:51 AM", 14.0, FontWeight.w500,
                      Themes.kDarkColor),
                ],
              ),
            ),
          ),
        ),
        if (controller.totalItemCounts - 1 != index)
          Constants.divider(context, 0.0),
      ],
    );
  }

  Widget itemBullet(
    String title,
    double fontSize,
    FontWeight fontWeight,
    Color color,
  ) {
    return Text(
      title,
      style: TextStyle(
        fontSize: ResponsiveHelper.getFontSize(context, fontSize),
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget shiftsDetailsHeaderView(BuildContext context, Size size, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              index == 0 ? "Shifts In Progress" : "Closure No $index",
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 18.0),
                fontWeight: FontWeight.w700,
                color: Themes.kDarkColor,
              ),
            ),
            index == 0
                ? const SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: Themes.kRedColor,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Text(
                      "Closed",
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                        fontWeight: FontWeight.w700,
                        color: Themes.kWhiteColor,
                      ),
                    ),
                  ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            customButton(context, size, "Print", Images.printer),
            if (index == 0) ...[
              Row(
                children: [
                  const SizedBox(width: 16.0),
                  customButton(
                      context, size, "Close Shift", Images.closeOutlined),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget shiftsDetailsView(BuildContext context, Size size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                itemBullet(
                    "Start Date", 16.0, FontWeight.w600, Themes.kPrimaryColor),
                const SizedBox(height: 4.0),
                itemBullet(
                    "02/11/2022", 14.0, FontWeight.w500, Themes.kDarkColor),
              ],
            ),
            Column(
              children: [
                itemBullet("Initial Base", 16.0, FontWeight.w600,
                    Themes.kPrimaryColor),
                const SizedBox(height: 4.0),
                itemBullet(
                    "DOP \$0.00", 14.0, FontWeight.w500, Themes.kDarkColor),
              ],
            ),
            Column(
              children: [
                itemBullet(
                    "Incomes", 16.0, FontWeight.w600, Themes.kPrimaryColor),
                const SizedBox(height: 4.0),
                itemBullet(
                    "DOP \$0.00", 14.0, FontWeight.w500, Themes.kDarkColor),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            itemBullet(
                "Initial Base", 16.0, FontWeight.w600, Themes.kPrimaryColor),
            itemBullet("DOP \$0.00", 14.0, FontWeight.w500, Themes.kBlackColor),
          ],
        ),
        Constants.divider(context, 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            itemBullet("Total", 16.0, FontWeight.w600, Themes.kPrimaryColor),
            itemBullet("DOP \$0.00", 14.0, FontWeight.w500, Themes.kBlackColor),
          ],
        ),
      ],
    );
  }

  Widget customButton(
      BuildContext context, Size size, String title, String icon) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () {
          if (title == "Print") {
            CustomSnackBar.showTopRightSnackBar(context, "Printing...");
          } else {
            controller.onMenuTapped(
                context, size, title, authController, tablesController);
          }
        },
        child: Ink(
          decoration: BoxDecoration(
              color: title == "Print" ? Themes.kPrimaryColor : Themes.kRedColor,
              borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Image.asset(
                  icon,
                  height: 18.0,
                  color: Themes.kWhiteColor,
                ),
                const SizedBox(width: 12.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                    fontWeight: FontWeight.w600,
                    color: Themes.kWhiteColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
