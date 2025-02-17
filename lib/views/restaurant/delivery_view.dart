import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/widgets/custom_close_icon_button.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class DeliveryView extends StatefulWidget {
  const DeliveryView({super.key});

  @override
  State<DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<DeliveryView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();
  final TablesController tablesController = Get.find<TablesController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Wrap(
      runSpacing: 16.0,
      spacing: 16.0,
      children: List.generate(
        8,
        (index) => customButton(index, size),
      ),
    );
  }

  Widget customButton(int index, Size size) {
    return GestureDetector(
      onTap: () => controller.onMenuInnerItemTapped(
          context, size, "Fast Food", authController, tablesController),
      child: Container(
        height: 70.0,
        width: ResponsiveHelper.isTablet(context)
            ? size.width / 2.6
            : size.width / 3.9,
        padding: const EdgeInsets.only(left: 14.0),
        decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Themes.kBlackColor.withOpacity(0.20),
              blurRadius: 8.0,
              spreadRadius: -3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Order Id : ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                        fontWeight: FontWeight.w500,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                    Text(
                      "140844",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                        fontWeight: FontWeight.w500,
                        color: Themes.kBlackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3.0),
                Row(
                  children: [
                    Text(
                      "Customer : ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                        fontWeight: FontWeight.w500,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                    Text(
                      "Paloma Medrano",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                        fontWeight: FontWeight.w500,
                        color: Themes.kBlackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomCloseIconButton(
              onTap: () => Constants.openAlertDialog(
                context: context,
                title: "Delete Order",
                msg: "Are you sure you want to delete order ?",
                toastMsg: 'Order Deleted!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
