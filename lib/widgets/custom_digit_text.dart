import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/utils/themes.dart';

import 'package:kedasrd_windows/widgets/custom_qty_view.dart';

import 'package:kedasrd_windows/controllers/cart_controller.dart';
import 'package:kedasrd_windows/controllers/common_controller.dart';

class CustomDigitText extends StatefulWidget {
  final String title, amount;
  final String? screenName;
  const CustomDigitText({
    super.key,
    required this.title,
    required this.amount,
    this.screenName,
  });

  @override
  State<CustomDigitText> createState() => _CustomDigitTextState();
}

class _CustomDigitTextState extends State<CustomDigitText> {
  final CartController cartController = Get.find<CartController>();
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 14.0),
            fontWeight: FontWeight.w400,
            color: widget.title == "Total"
                ? Themes.kPrimaryColor
                : Themes.kBlackColor.withOpacity(0.60),
          ),
        ),
        SizedBox(width: widget.title == "" ? 0.0 : 8.0),
        widget.title.contains("%") || widget.title == "Price"
            ? inputView()
            : widget.title.contains("Qty")
                ? Obx(
                    () => CustomQtyView(
                      screenName:
                          widget.screenName != "" ? "FastFood" : "SuperMarket",
                      initialValue: commonController
                          .qtyValues[0], // Use index to get specific quantity
                      onDecrease: () =>
                          commonController.updateQuantity(0, false),
                      onIncrease: () =>
                          commonController.updateQuantity(0, true),
                    ),
                  )
                : Expanded(
                    child: Text(
                      widget.amount,
                      textAlign:
                          widget.title == "" ? TextAlign.left : TextAlign.right,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                        fontWeight: FontWeight.w900,
                        color: widget.title == "Total"
                            ? Themes.kPrimaryColor
                            : Themes.kDarkColor,
                      ),
                    ),
                  ),
      ],
    );
  }

  Widget inputView() {
    return Container(
      height: 24.0,
      width: widget.title == "Price" ? 74.0 : 36.0,
      // padding: const EdgeInsets.only(bottom: 3.5),
      decoration: BoxDecoration(
          color: widget.screenName != ""
              ? Themes.kHeaderLightColor
              : Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(6.5),
          border: Border.all(width: 0.5, color: Themes.kGreyColor)),
      child: TextFormField(
        cursorHeight: 14.0,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 14.0),
            color: Themes.kBlackColor),
        // controller: controller.qtyController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
          border: InputBorder.none,
          hintText: widget.title == "Price" ? "\$500.00" : "0",
          hintStyle: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 12.0),
            color: Themes.kGreyColor[500],
          ),
        ),
        onChanged: (value) {
          if (widget.title.contains("%")) {
            cartController.setDiscountPercentage(double.tryParse(value) ?? 0.0);
          }
        },
      ),
    );
  }
}
