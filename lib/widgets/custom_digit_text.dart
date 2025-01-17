import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kedasrd_windows/controllers/cart_controller.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';

class CustomDigitText extends StatefulWidget {
  final String title, amount;
  const CustomDigitText({super.key, required this.title, required this.amount});

  @override
  State<CustomDigitText> createState() => _CustomDigitTextState();
}

class _CustomDigitTextState extends State<CustomDigitText> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Themes.kPrimaryColor,
          ),
        ),
        widget.title.contains("%") || widget.title == "Price"
            ? inputView()
            : widget.title.contains("Qty")
                ? qtyView()
                : Text(
                    widget.amount,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                      color: Themes.kDarkColor,
                    ),
                  ),
      ],
    );
  }

  Widget inputView() {
    return Container(
      height: 28.0,
      width: widget.title == "Price" ? 74.0 : 36.0,
      // padding: const EdgeInsets.only(bottom: 3.5),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(6.5),
          border: Border.all(width: 0.5, color: Themes.kGreyColor)),
      child: TextFormField(
        cursorHeight: 14.0,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 14.0, color: Themes.kBlackColor),
        // controller: controller.qtyController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          border: InputBorder.none,
          hintText: widget.title == "Price" ? "\$500.00" : "0",
          hintStyle: TextStyle(
            fontSize: 14.0,
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

  Widget qtyView() {
    return Container(
      height: 28.0,
      width: 78.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(5.5),
          border: Border.all(width: 0.5, color: Themes.kGreyColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          qtyButton(Images.less, "Decrease", 0),
          const Text(
            "2",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Themes.kDarkColor,
            ),
          ),
          qtyButton(Images.add, "Increase", 0),
        ],
      ),
    );
  }

  Widget qtyButton(String image, String type, int index) {
    return GestureDetector(
      onTap: () {
        if (type == "Decrease") {
        } else {}
      },
      child: Image.asset(
        image,
        height: 11.0,
        width: 11.0,
        color: Themes.kPrimaryColor,
      ),
    );
  }
}
