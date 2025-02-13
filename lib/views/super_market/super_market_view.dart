import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/custom_qty_view.dart';
import 'package:kedasrd_windows/widgets/custom_tabs_list.dart';
import 'package:kedasrd_windows/widgets/custom_digit_text.dart';
import 'package:kedasrd_windows/widgets/custom_icon_button.dart';

import 'package:kedasrd_windows/controllers/common_controller.dart';

class SuperMarketView extends StatefulWidget {
  const SuperMarketView({super.key});

  @override
  State<SuperMarketView> createState() => _SuperMarketViewState();
}

class _SuperMarketViewState extends State<SuperMarketView> {
  final CommonController commonController = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 14.0, horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headerText("Barcode", size),
                    const SizedBox(width: 8.0),
                    headerText("Item Description", size),
                    const SizedBox(width: 8.0),
                    headerText("Price", size),
                    const SizedBox(width: 8.0),
                    headerText("Qty", size),
                    const SizedBox(width: 8.0),
                    headerText("Taxes", size),
                    const SizedBox(width: 8.0),
                    headerText("Disc %", size),
                    const SizedBox(width: 8.0),
                    headerText("Total", size),
                    const SizedBox(width: 8.0),
                    headerText("", size),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      3,
                      (index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14.0, horizontal: 14.0),
                          margin: const EdgeInsets.only(bottom: 14.0),
                          decoration: BoxDecoration(
                            color: Themes.kWhiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Themes.kBlackColor.withOpacity(0.05),
                                blurRadius: 8.0,
                                spreadRadius: -3,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              headerText("6479374", size),
                              const SizedBox(width: 8.0),
                              headerText("Nachitos Ricos", size),
                              const SizedBox(width: 8.0),
                              headerText("\$250", size),
                              const SizedBox(width: 8.0),
                              Container(
                                width: size.width / 8.9,
                                alignment: Alignment.centerLeft,
                                child: Obx(
                                  () => CustomQtyView(
                                    screenName: "SuperMarket",
                                    initialValue: commonController.qtyValues[
                                        index], // Use index to get specific quantity
                                    onDecrease: () => commonController
                                        .updateQuantity(index, false),
                                    onIncrease: () => commonController
                                        .updateQuantity(index, true),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              headerText("\$38", size),
                              const SizedBox(width: 8.0),
                              inputView(size),
                              const SizedBox(width: 8.0),
                              headerText("\$538.00", size),
                              const SizedBox(width: 8.0),
                              actionButton(context, size, index),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Themes.kBlackColor.withOpacity(0.05),
                blurRadius: 8.0,
                spreadRadius: -3,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const CustomDigitText(
                            title: "Subtotal", amount: "\$211.86"),
                        Constants.divider(context, 8.0),
                        const CustomDigitText(title: "Tax", amount: "\$38.14"),
                        Constants.divider(context, 8.0),
                        const CustomDigitText(
                            title: "Discount", amount: "\$0.00"),
                        Constants.divider(context, 8.0),
                        const CustomDigitText(
                            title: "Other Discount", amount: "\$0.00"),
                        Constants.divider(context, 8.0),
                        const CustomDigitText(
                            title: "Tips Tax", amount: "\$0.00"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 100.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomDigitText(title: "No. Items", amount: "03"),
                        Constants.divider(context, 8.0),
                        const SizedBox(height: 8.0),
                        const Text(
                          "Payments",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w600,
                            color: Themes.kPrimaryColor,
                          ),
                        ),
                        const Text(
                          "\$250.00",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                            color: Themes.kDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              CustomTabsList(
                  data: DummyData.superMarketCartDeskItems,
                  type: "Super Market Cart"),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        CustomTabsList(
            data: DummyData.superMarketButtonItems, type: "Super Market"),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget headerText(String title, Size size) {
    return SizedBox(
      width: title == "" ? 30.0 : size.width / 8.9,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Themes.kPrimaryColor,
        ),
      ),
    );
  }

  Widget inputView(Size size) {
    return Container(
      width: size.width / 8.9,
      alignment: Alignment.centerLeft,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          height: 28.0,
          width: 36.0,
          decoration: BoxDecoration(
              color: Themes.kWhiteColor,
              borderRadius: BorderRadius.circular(6.5),
              border: Border.all(width: 0.5, color: Themes.kGreyColor)),
          child: TextFormField(
            cursorHeight: 14.0,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(fontSize: 14.0, color: Themes.kBlackColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
              border: InputBorder.none,
              hintText: "0",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: Themes.kGreyColor[500],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget actionButton(BuildContext context, Size size, int index) {
    return Container(
      width: 30.0,
      alignment: Alignment.centerRight,
      child: CustomIconButton(
        icon: Images.bin,
        size: 30.0,
        onTap: () => CustomSnackBar.showTopRightSnackBar(
            context, "Item ${index + 1} removed!"),
      ),
    );
  }
}
