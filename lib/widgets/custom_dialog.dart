import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';

import 'package:kedasrd_windows/widgets/custom_text_input.dart';
import 'package:kedasrd_windows/widgets/custom_view_dialog.dart';
import 'package:kedasrd_windows/widgets/custom_alert_dialog.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String? screenName, btnText1, btnText2;
  final Widget? child;
  final double? height;
  final ScrollPhysics? scroll;
  const CustomDialog({
    super.key,
    required this.title,
    this.screenName,
    this.btnText1,
    this.btnText2,
    this.child,
    this.height,
    this.scroll,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TablesController controller = Get.find<TablesController>();
  final DrawerMenuController drawerMenuController =
      Get.find<DrawerMenuController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Dialog(
      child: Container(
        height: widget.height ?? size.height / 1.6,
        width: ResponsiveHelper.isTablet(context)
            ? size.width / 1.6
            : size.width / 2.8,
        decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            // Fixed Header
            Container(
              height: 78.0,
              padding: const EdgeInsets.only(top: 0.0),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      widget.btnText2 == "Close and Print"
                          ? "Close Shift"
                          : widget.title,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 24.0),
                        fontWeight: FontWeight.bold,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                  ),
                  closeButton(),
                ],
              ),
            ),
            // Scrollable Content
            Expanded(
              child: Constants.scrollbarView(
                paddingRight: 0.0,
                child: SingleChildScrollView(
                  physics:
                      widget.scroll ?? const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: widget.child ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
            // Fixed Footer
            Container(
              padding: const EdgeInsets.only(
                left: 64.0,
                right: 64.0,
                bottom: 28.0,
                top: 28.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment:
                        widget.btnText2 != null && widget.btnText2!.isNotEmpty
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                    children: [
                      if (widget.btnText1 != null &&
                          widget.btnText1!.isNotEmpty)
                        submitButton(widget.btnText1!, size, context),
                      if (widget.btnText2 != null &&
                          widget.btnText2!.isNotEmpty)
                        submitButton(widget.btnText2!, size, context)
                    ],
                  ),
                  if (widget.title.contains("Cash") &&
                      widget.height != size.height)
                    Column(
                      children: [
                        const SizedBox(height: 16.0),
                        submitButton("More Options", size, context),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          onTap: () => Get.back(),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            topLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: Themes.kPrimaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
            ),
            child: Container(
              height: 54.0,
              width: 54.0,
              padding: const EdgeInsets.all(21.0),
              child: Image.asset(
                Images.close,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton(String title, Size size, context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () {
          Get.back();
          if (title == "Submit" && widget.title.contains("auth code")) {
            if (widget.screenName == "Home") {
              controlAlert(context);
            } else if (widget.screenName == "FastFood") {
              Constants.openDialog(
                context: context,
                title: "Kitchen Order",
                btnText1: "",
                scroll: const AlwaysScrollableScrollPhysics(),
                child: kitchenView(context, size),
                height: size.height,
              );
            } else if (widget.screenName == "New Order") {
              drawerMenuController.onMenuInnerItemTapped(
                  context, size, "Table", authController, controller);
            } else if (widget.screenName == "Cart") {
              CustomSnackBar.showTopRightSnackBar(context, 'Item Removed!');
            } else if (widget.screenName == "Drawer") {
              Constants.openCloseShiftDialog(context, size, title);
            }
          } else if (title.contains("Options")) {
            Constants.openDialog(
              context: context,
              title: "Cash",
              btnText1: "Proceed",
              height: size.height,
              scroll: const AlwaysScrollableScrollPhysics(),
              child: controller.inputSection("Cash", context),
            );
          } else if (widget.title.contains("Customer")) {
            if (title.contains("Shopping")) {
            } else {
              Constants.openDialog(
                context: context,
                title: "Payment Info",
                btnText1: "Pay",
                child: payInputSection(),
                height: size.height / 1.4,
              );
            }
          } else if (title.contains("Product")) {
            CustomSnackBar.showTopRightSnackBar(context, 'Item Added!');
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            height: 52.0,
            width: widget.btnText2 != null && widget.btnText2!.isNotEmpty
                ? ResponsiveHelper.isTablet(context)
                    ? size.width / 2 / 3
                    : size.width / 3 / 3
                : ResponsiveHelper.isTablet(context)
                    ? size.width / 2 / 2
                    : size.width / 3 / 3,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                fontWeight: FontWeight.bold,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget payInputSection() {
    return const Column(
      children: [
        CustomTextInput(hintText: "Name", isNumber: false),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Card Number", isNumber: true),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Expiry Date", isNumber: false),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "CVV", isNumber: true),
      ],
    );
  }

  dynamic controlAlert(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomAlertDialog(
        title: "Assistance Control Alert",
        msg:
            "You have to submit entry yet... Press Submit to\ncontinue or Cancel to go back to enter auth code.",
        positiveBtn: "Submit",
        negativeBtn: "Cancel",
        positiveAction: () => {
          Get.back(),
          openEntryLog(context),
        },
      ),
    );
  }
}

dynamic openEntryLog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const CustomViewDialog());
}

Widget kitchenView(BuildContext context, Size size) {
  return Column(
    children: [
      Constants.customView(
        context,
        size,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Printed by"),
                customText(context, "Value", "Elvis Rodriguez"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Date & Time"),
                customText(context, "Value", "28/01/2025, 05:25 PM"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Table No"),
                customText(context, "Value", "#4"),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14.0),
      Constants.customView(
        context,
        size,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Items"),
                customText(context, "Key", "QTY"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Value", "Margerita Pizza"),
                customText(context, "Value", "2"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Value", "Peri Peri French Fries"),
                customText(context, "Value", "1"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Value", "Coca Cola"),
                customText(context, "Value", "2"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Value", "Cheese Ball"),
                customText(context, "Value", "2"),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14.0),
      Constants.customView(
        context,
        size,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Sub Total"),
                customText(context, "Value", "\$847.46"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Tax"),
                customText(context, "Value", "\$152.00"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Tips"),
                customText(context, "Value", "\$24.00"),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Discount"),
                customText(context, "Value", "\$50.00"),
              ],
            ),
            Container(
              height: 1,
              width: size.width,
              color: Themes.kBlackColor,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Ex", "Total"),
                customText(context, "Ex", "\$700.00"),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 14.0),
      Constants.customView(
        context,
        size,
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText(context, "Key", "Payment mode"),
                customText(context, "Value", "Debit Card"),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customText(BuildContext context, String type, String txt) {
  return Text(
    ((type == "Key" && txt == "QTY") || txt.contains("\$"))
        ? txt
        : (type == "Key" || type == "Ex")
            ? "$txt :"
            : txt,
    style: TextStyle(
      fontSize: ResponsiveHelper.getFontSize(
          context,
          type == "Key"
              ? 15.0
              : type == "Ex"
                  ? 16.0
                  : 14.0),
      fontWeight: type == "Key"
          ? FontWeight.w600
          : type == "Ex"
              ? FontWeight.w800
              : FontWeight.w400,
      color: type == "Key" ? Themes.kPrimaryColor : Themes.kBlackColor,
    ),
  );
}
