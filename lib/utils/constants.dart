import 'package:get/get.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

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
      // if (value != null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Selected: Option $value')),
      //   );
      // }
    });
  }

  static openAuthCodeDialog(BuildContext context, Size size, String title) {
    return openDialog(
      context: context,
      screenName: title,
      title: "Please enter your auth code",
      btnText1: "Submit",
      child: const CustomTextInput(hintText: "Enter Code here", isNumber: true),
      height: size.height / 4,
    );
  }
}

class CustomSnackBar {
  static void showTopRightSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 94.0, // Adjust position based on the status bar
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
              style: const TextStyle(
                fontSize: 16.0,
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
