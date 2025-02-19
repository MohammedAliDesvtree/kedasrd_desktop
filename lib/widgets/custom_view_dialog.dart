import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';

import 'package:kedasrd_windows/widgets/custom_text_input.dart';

import 'package:kedasrd_windows/controllers/common_controller.dart';
import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class CustomViewDialog extends StatefulWidget {
  const CustomViewDialog({super.key});

  @override
  State<CustomViewDialog> createState() => _CustomViewDialogState();
}

class _CustomViewDialogState extends State<CustomViewDialog> {
  final CommonController commonController = Get.find<CommonController>();
  final DrawerMenuController drawerMenuController =
      Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Dialog(
      child: Container(
        height: size.height,
        width: ResponsiveHelper.isTablet(context)
            ? size.width / 1.8
            : size.width / 3.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Themes.kBlackColor.withOpacity(0.20),
              blurRadius: 8.0,
              spreadRadius: -3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, bottom: 24.0, left: 24.0, right: 16.0),
          child: Constants.scrollbarView(
            paddingRight: 4.0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 24.0),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(Images.kedasLogo, height: 96.0),
                        // const SizedBox(height: 16.0),
                        Obx(
                          () => commonController.isEntryLog.value
                              ? inputSection()
                              : uploadPhotoSection(size),
                        ),
                        const SizedBox(height: 44.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton("Cancel", context, size),
                            customButton("Submit", context, size),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        children: [
          Text(
            "Employee Entry Log",
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 24.0),
              fontWeight: FontWeight.w600,
              color: Themes.kDarkColor,
            ),
          ),
          const SizedBox(height: 28.0),
          Material(
            color: Themes.kTransparent,
            child: MouseRegion(
              cursor: SystemMouseCursors.click, // Changes cursor to hand
              child: InkWell(
                borderRadius: BorderRadius.circular(92.0),
                child: Ink(
                  height: 108.0,
                  width: 108.0,
                  decoration: BoxDecoration(
                    color: Themes.kGreyColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(92.0),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            "Upload your picture",
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 14.0),
              fontWeight: FontWeight.w600,
              color: Themes.kBlackColor.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 28.0),
          const CustomTextInput(
            hintText: "Employees code to log entry",
            isNumber: true,
          ),
          const SizedBox(height: 24.0),
          const CustomTextInput(
            hintText: "Enter your initial balance",
            isNumber: true,
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Obx(
                () => MouseRegion(
                  cursor: SystemMouseCursors.click, // Changes cursor to hand
                  child: GestureDetector(
                    onTap: () => commonController.locationAllowed(),
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Themes.kBlackColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: commonController.isLocationAllow.value
                          ? const Icon(Icons.check, size: 16.0)
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
              Text(
                "Allow Location",
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                  fontWeight: FontWeight.w400,
                  color: Themes.kBlackColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget uploadPhotoSection(Size size) {
    return Column(
      children: [
        Text(
          "Take Your Picture to Finish",
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 24.0),
            fontWeight: FontWeight.w600,
            color: Themes.kDarkColor,
          ),
        ),
        const SizedBox(height: 28.0),
        uploadPhotoView(size, context),
        // const SizedBox(height: 148.0),
      ],
    );
  }

  Widget uploadPhotoView(Size size, BuildContext context) {
    return DottedBorder(
      color: Themes.kGreyColor,
      strokeWidth: 1,
      dashPattern: const [3],
      radius: const Radius.circular(4.0),
      child: Container(
        height: 224.0,
        width: size.width - 64,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
            color: Themes.kGreyColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.cloudUpload,
              height: 64.0,
              width: 64.0,
            ),
            const SizedBox(height: 4.0),
            Text(
              "Upload Photo",
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 26.0),
                fontWeight: FontWeight.w400,
                color: Themes.kDarkColor,
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              color: Themes.kTransparent,
              child: MouseRegion(
                cursor: SystemMouseCursors.click, // Changes cursor to hand
                child: InkWell(
                  borderRadius: BorderRadius.circular(2.5),
                  onTap: () => CustomSnackBar.showTopRightSnackBar(
                      context, "Picture Selected"),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Themes.kPrimaryColor,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                    child: Container(
                      height: 38.0,
                      width: 142.0,
                      alignment: Alignment.center,
                      child: Text(
                        "Select File...",
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                          fontWeight: FontWeight.w600,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(String title, BuildContext context, Size size) {
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: () {
            if (title == "Submit") {
              commonController.updateView(drawerMenuController);
            } else {
              commonController.isEntryLog.value = true;
              Get.back();
            }
          },
          child: Ink(
            decoration: BoxDecoration(
                color: title == "Cancel"
                    ? Themes.kGreyColor
                    : Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(6.0)),
            child: Container(
              height: 52.0,
              width: size.width / 8,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                  fontWeight: FontWeight.w600,
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
