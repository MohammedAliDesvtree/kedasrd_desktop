import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/widgets/custom_qty_view.dart';
import 'package:kedasrd_windows/widgets/custom_tabs_list.dart';
import 'package:kedasrd_windows/widgets/custom_digit_text.dart';
import 'package:kedasrd_windows/widgets/custom_icon_button.dart';

import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/common_controller.dart';

class SuperMarketView extends StatefulWidget {
  const SuperMarketView({super.key});

  @override
  State<SuperMarketView> createState() => _SuperMarketViewState();
}

class _SuperMarketViewState extends State<SuperMarketView> {
  final CommonController commonController = Get.find<CommonController>();
  final TablesController tableController = Get.find<TablesController>();

  @override
  void initState() {
    super.initState();
    commonController.isPaymentMenuVisible.value = false;
  }

  @override
  void didUpdateWidget(SuperMarketView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset payment menu visibility when widget title changes
    if (oldWidget != widget) {
      commonController.isPaymentMenuVisible.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    commonController.isPaymentMenuVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Obx(
      () => commonController.isPaymentMenuVisible.value
          ? paymentMenu(size)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 24.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 14.0),
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
                        child: Constants.scrollbarView(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                8,
                                (index) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0, horizontal: 14.0),
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    decoration: BoxDecoration(
                                      color: Themes.kWhiteColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Themes.kBlackColor
                                              .withOpacity(0.05),
                                          blurRadius: 8.0,
                                          spreadRadius: -3,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        headerText("6479374", size),
                                        const SizedBox(width: 8.0),
                                        headerText("Nachitos Ricos", size),
                                        const SizedBox(width: 8.0),
                                        headerText("\$250", size),
                                        const SizedBox(width: 8.0),
                                        Container(
                                          width: size.width / 10.9,
                                          alignment: Alignment.centerLeft,
                                          child: Obx(
                                            () => CustomQtyView(
                                              screenName: "SuperMarket",
                                              initialValue: commonController
                                                      .qtyValues[
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
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: moreOptionsMenu(),
                ),
                totalView(),
                const SizedBox(height: 8.0),
                Obx(() {
                  if (commonController.isDigitsViewVisible.value) {
                    return Column(
                      children: [
                        digitsView(size, context),
                        const SizedBox(height: 8.0),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 8.0),
                CustomTabsList(
                    data: DummyData.superMarketButtonItems,
                    type: "Super Market"),
              ],
            ),
    );
  }

  Widget moreOptionsMenu() {
    return WidgetAnimator(
      atRestEffect: WidgetRestingEffects.bounce(),
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: () => commonController.isPaymentMenuVisible.value = true,
          child: Ink(
            decoration: BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(50.0)),
            child: const SizedBox(
              height: 50.0,
              width: 50.0,
              child: Icon(
                Icons.menu,
                size: 24.0,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget paymentMenu(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIconButton(
          icon: Images.leftArrow,
          onTap: () => commonController.isPaymentMenuVisible.value = false,
        ),
        const SizedBox(height: 16.0),
        Expanded(
          child: Constants.scrollbarView(
            paddingRight: 18.0,
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 16.0,
                spacing: 16.0,
                children: List.generate(
                  DummyData.superMarketCartDeskItems.length,
                  (index) {
                    var data = DummyData.superMarketCartDeskItems[index];
                    return Material(
                      color: Themes.kTransparent,
                      child: MouseRegion(
                        cursor:
                            SystemMouseCursors.click, // Changes cursor to hand
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8.0),
                          onTap: () => tableController.onTabTapped(
                              data["title"], size, context),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Themes.kPrimaryColor,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Container(
                              height: 150.0,
                              width: ResponsiveHelper.isDesktop(context)
                                  ? size.width / 8.50
                                  : ResponsiveHelper.isTablet(context)
                                      ? size.width / 3.5
                                      : size.width / 2.2,
                              alignment: Alignment.center,
                              child: Text(
                                data["title"],
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.getFontSize(
                                      context, 20.0),
                                  fontWeight: FontWeight.bold,
                                  color: Themes.kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget digitsView(Size size, BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
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
                    const CustomDigitText(title: "Discount", amount: "\$0.00"),
                    Constants.divider(context, 8.0),
                    const CustomDigitText(
                        title: "Other Discount", amount: "\$0.00"),
                    Constants.divider(context, 8.0),
                    const CustomDigitText(title: "Tips Tax", amount: "\$0.00"),
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
                    Text(
                      "Payments",
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 30.0),
                        fontWeight: FontWeight.w600,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                    Text(
                      "\$250.00",
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 30.0),
                        fontWeight: FontWeight.w700,
                        color: Themes.kDarkColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget totalView() {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      child: GestureDetector(
        onTap: () => commonController.isDigitsViewVisible.value =
            !commonController.isDigitsViewVisible.value,
        child: Container(
          height: 42.0,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(8.0),
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
              const Text(
                "4 Items",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Themes.kBlackColor,
                ),
              ),
              Image.asset(
                Images.downArrow,
                height: 14.0,
                width: 14.0,
                color: Themes.kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        submitButton(size, "More Functions"),
        const SizedBox(width: 8.0),
        submitButton(size, "Payment Options"),
      ],
    );
  }

  Widget submitButton(Size size, String title) {
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: () {
            if (title.contains("More")) {
              Constants.openDialog(
                context: context,
                title: title,
                child: moreOptions(),
                height: size.height / 2.0,
              );
            } else {
              Constants.openDialog(
                context: context,
                title: title,
                child: paymentOptions(),
                height: size.height / 2.0,
              );
            }
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(6.0)),
            child: Container(
              height: 42.0,
              width: 148.0,
              // padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                  fontWeight: FontWeight.w500,
                  color: Themes.kWhiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget moreOptions() {
    return CustomTabsList(
      data: DummyData.superMarketCartDeskItems,
      type: "Super Market Cart",
      width: 98.0,
    );
  }

  Widget paymentOptions() {
    return CustomTabsList(
      data: DummyData.superMarketButtonItems,
      type: "Super Market",
    );
  }

  Widget headerText(String title, Size size) {
    return SizedBox(
      width: title == "" ? 30.0 : size.width / 10.9,
      child: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 14.0),
          fontWeight: FontWeight.w600,
          color: Themes.kPrimaryColor,
        ),
      ),
    );
  }

  Widget inputView(Size size) {
    return Container(
      width: size.width / 10.9,
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
            style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                color: Themes.kBlackColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
              border: InputBorder.none,
              hintText: "0",
              hintStyle: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 14.0),
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
