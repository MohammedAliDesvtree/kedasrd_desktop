import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/utils/themes.dart';

import 'package:kedasrd_windows/widgets/custom_dialog.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';
import 'package:kedasrd_windows/widgets/custom_alert_dialog.dart';
import 'package:kedasrd_windows/widgets/custom_items_dialog.dart';

class Constants {
  static bool isWindows = Platform.isWindows;
  static bool isMacOS = Platform.isMacOS;
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;

  static String onlineStoreURL =
      "https://portal.kedasrd.com/online-store/210#/online-product";

  static double headerHeight = isIOS ? 52.0 : 64.0;

  // static showSnackBar(context, msg) {
  //   var snackBar = SnackBar(content: Text(msg));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  static Widget scrollbarView({required Widget child, double? paddingRight}) {
    // Create a single ScrollController to share
    final ScrollController controller = ScrollController();

    // Ensure the SingleChildScrollView inside the child uses the same controller
    if (child is SingleChildScrollView) {
      child = SingleChildScrollView(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.only(
              right: paddingRight ?? 24.0), // Add padding for scrollbar
          child: child.child,
        ),
      );
    }

    return ScrollbarTheme(
        data: ScrollbarThemeData(
            thickness: WidgetStateProperty.all(8.0),
            thumbVisibility: WidgetStateProperty.all(true),
            thumbColor:
                WidgetStateProperty.all(Themes.kGreyColor.withOpacity(0.1))),
        child: Scrollbar(controller: controller, child: child));
  }

  static Widget divider(context, gap) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: 0.5,
      width: size.width,
      color: Themes.kGreyColor,
      margin: EdgeInsets.symmetric(vertical: gap),
    );
  }

  static dynamic openDialog({
    required BuildContext context,
    required String title,
    btnText1,
    String? screenName,
    btnText2,
    btnText3,
    double? height,
    Widget? child,
    ScrollPhysics? scroll,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
        screenName: screenName,
        title: title,
        btnText1: btnText1,
        btnText2: btnText2,
        height: height,
        scroll: scroll,
        child: child,
      ),
    );
  }

  static dynamic openWideDialog({
    required BuildContext context,
    required String title,
    hintText,
    btnText1,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomItemsDialog(
        title: title,
        hintText: hintText,
        btnText1: btnText1,
      ),
    );
  }

  static dynamic openAlertDialog({
    required BuildContext context,
    required String title,
    msg,
    toastMsg,
    Function? positiveAction,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomAlertDialog(
        title: title == "" ? 'Are you sure?' : title,
        msg: msg,
        positiveAction: () {
          if (positiveAction != null) {
            positiveAction();
          }
          CustomSnackBar.showTopRightSnackBar(context, toastMsg);
          Get.back();
        },
      ),
    );
  }

  static dynamic openPopupMenu(
    BuildContext context,
    TapDownDetails details,
    dynamic data,
    String title,
    Size size,
  ) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(details.globalPosition, details.globalPosition),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position, // Position the menu
      constraints: const BoxConstraints(
        // minWidth: 200, // Minimum width
        maxWidth: 500, // Maximum width
        // minHeight: 500, // Minimum height
        maxHeight: 500, // Maximum height
      ),
      items: List.generate(data.length, (index) {
        String itemTitle = data[index];
        return PopupMenuItem(
          value: index + 1,
          child: Text(itemTitle),
        );
      }),
    ).then((value) {
      if (value != null) {
        // Subtract 1 to convert back to 0-based index
        String selectedItem = data[value - 1];

        if (selectedItem.contains("Whatsapp")) {
          CustomSnackBar.showTopRightSnackBar(context, "Sent to Whatsapp!");
        } else if (selectedItem.contains("Email")) {
          CustomSnackBar.showTopRightSnackBar(context, "Sent to Email!");
        } else if (selectedItem.contains("Print")) {
          CustomSnackBar.showTopRightSnackBar(context, "Pre-Bill Printing...!");
        } else if (selectedItem.contains("Cart")) {
          Constants.openAlertDialog(
            context: context,
            title: "",
            msg: "Are you sure you want to clear the cart?",
            toastMsg: 'Cart Cleared!',
          );
        } else if (selectedItem.contains("Extra")) {
          Constants.openWideDialog(
            context: context,
            title: "Nachitos Ricos",
            hintText: "Item",
            btnText1: "Add Extra Items",
          );
        } else if (selectedItem.contains("Notes")) {
          Constants.openDialog(
            context: context,
            title: "Add Notes",
            btnText1: "Add",
            child:
                const CustomTextInput(hintText: "Add Notes", isNumber: false),
            height: size.height / 2.5,
          );
        } else if (selectedItem.contains("Kitchen")) {
          CustomSnackBar.showTopRightSnackBar(
              context, "Order Sent to Kitchen!");
        } else if (selectedItem.contains("Bar")) {
          CustomSnackBar.showTopRightSnackBar(context, "Order Sent to Bar!");
        } else if (selectedItem.contains("Remove")) {
          Constants.openWideDialog(
            context: context,
            title: "Remove Item",
            hintText: "Item",
            btnText1: "Add Formula Items",
          );
        }
      }
    });
  }

  static openAuthCodeDialog(BuildContext context, Size size, String title) {
    return openDialog(
      context: context,
      screenName: title,
      title: "Please enter your auth code",
      btnText1: "Submit",
      child: const CustomTextInput(hintText: "Enter Code here", isNumber: true),
      height: size.height / 2.5,
    );
  }

  static openCloseShiftDialog(BuildContext context, Size size, String title) {
    return openDialog(
      context: context,
      title: title,
      btnText1: "Submit",
      btnText2: "Close and Print",
      height: size.height / 2.5,
      child: closeShift(context),
    );
  }

  static Widget customView(BuildContext context, Size size, Widget child) {
    return Container(
      width:
          ResponsiveHelper.isTablet(context) ? size.width / 2 : size.width / 4,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Themes.kGreyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}

Widget closeShift(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 132.0,
        margin: const EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Themes.kGreyColor)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                closeShiftItems(context, "Start Date", "bold"),
                closeShiftItems(context, "12/24/2024 12:15 AM", "normal"),
              ],
            ),
            Constants.divider(context, 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                closeShiftItems(context, "Initial Base", "bold"),
                closeShiftItems(context, "DOP \$0.00", "normal"),
              ],
            ),
            Constants.divider(context, 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                closeShiftItems(context, "Total", "bold"),
                closeShiftItems(context, "DOP \$0.00", "bold"),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 16.0),
      const CustomTextInput(
        hintText: "Observations",
        isNumber: false,
      ),
    ],
  );
}

Widget closeShiftItems(BuildContext context, String title, String type) {
  return Text(
    title,
    style: TextStyle(
      fontSize: ResponsiveHelper.getFontSize(context, 16.0),
      fontWeight: type == "bold" ? FontWeight.bold : FontWeight.normal,
      color: Themes.kBlackColor,
    ),
  );
}

class CustomSnackBar {
  static void showTopRightSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 76.0, // Adjust position based on the status bar
        right: 24.0, // Adjust distance from the right edge
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Themes.kRedColor,
                borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              message,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                fontWeight: FontWeight.bold,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the snackbar after a duration
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
