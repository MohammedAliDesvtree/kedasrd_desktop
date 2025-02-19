import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title, msg;
  final String? positiveBtn, negativeBtn;
  final dynamic positiveAction;
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.msg,
    this.positiveBtn,
    this.negativeBtn,
    required this.positiveAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 24.0),
          fontWeight: FontWeight.bold,
          color: Themes.kBlackColor,
        ),
      ),
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 16.0),
          fontWeight: FontWeight.w400,
          color: Themes.kBlackColor,
        ),
      ),
      actions: <Widget>[
        dialogButton(context, negativeBtn ?? "No"),
        dialogButton(context, positiveBtn ?? "Yes"),
      ],
    );
  }

  Widget dialogButton(BuildContext context, String title) {
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
        child: InkWell(
          borderRadius: BorderRadius.circular(40.0),
          onTap: () {
            if (title == "Yes" || title == positiveBtn) {
              positiveAction();
            } else {
              Get.back();
            }
          },
          child: Ink(
            decoration: BoxDecoration(
                color: (title == "Yes" || title == positiveBtn)
                    ? Themes.kPrimaryColor
                    : Themes.kPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(40.0)),
            child: Container(
              height: 40.0,
              width: 100.0,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                  fontWeight: FontWeight.bold,
                  color: Themes.kWhiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
