import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/custom_digit_text.dart';
import 'package:kedasrd_windows/widgets/custom_dropdowns.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';

class TablesController extends GetxController {
  RxList<int> randomNumbers = <int>[].obs;
  final RxInt selectedTabIndex = 0.obs;
  final int maxTabIndex = 5; // Based on the length of settingItems

  @override
  void onInit() {
    super.onInit();
    ever(selectedTabIndex, (value) {
      int tableLength = getTableLength(value);
      updateRandomNumbers(tableLength);
    });
    // Initialize with the first tab's table length
    int initialTableLength = getTableLength(selectedTabIndex.value);
    updateRandomNumbers(initialTableLength);
  }

  void updateRandomNumbers(int tableLength) {
    final random = Random();
    randomNumbers = List.generate(
      tableLength,
      (_) => random.nextInt(10) + 1,
    ).obs;
  }

  int getTableLength(int index) {
    switch (index) {
      case 0:
        return 7;
      case 1:
        return 2;
      case 2:
        return 1;
      case 3:
        return 1;
      default:
        return 1;
    }
  }

  void selectTab(int index) {
    // Ensure index is within bounds
    if (index >= 0 && index <= maxTabIndex) {
      selectedTabIndex.value = index;
    }
  }

  void resetTab() {
    // Reset to initial state (0 index)
    selectedTabIndex.value = 0;
  }

  void onTabTapped(String title, Size size, BuildContext context) {
    Get.back();
    switch (title) {
      case "Items":
        Constants.openWideDialog(
          context: context,
          title: title,
          hintText: "Article",
          btnText1: "Add Product",
        );
        break;
      case "Customers":
        Constants.openWideDialog(
          context: context,
          title: title,
          hintText: "Client",
          btnText1: "Add Customer",
        );
        break;
      case "Orders":
        Constants.openWideDialog(
          context: context,
          title: title,
          hintText: "Customer",
        );
        break;
      case "Save Order":
        CustomSnackBar.showTopRightSnackBar(
          context,
          'Save Order Successfully!',
        );
        break;
      case "Discard Order":
        Constants.openAlertDialog(
          context: context,
          title: "Discard Order",
          msg: "Are you sure you want to cancel your cart ?",
          toastMsg: 'Order Discarded!',
        );
        break;
      case "Discount":
        Constants.openDialog(
          context: context,
          title: "Add Discount",
          btnText1: "Cancel",
          btnText2: "Submit",
          child: const CustomTextInput(hintText: "Discount", isNumber: true),
          height: size.height / 2.5,
        );
        break;
      case "Cash":
        Constants.openDialog(
          context: context,
          title: "Payment Type : Cash",
          btnText1: "Complete Order",
          height: size.height / 1.5,
          child: cashView(),
        );
        break;
      case "Prepaid":
        CustomSnackBar.showTopRightSnackBar(
          context,
          'The selected customer has insufficient balance.',
        );
        break;
      case "Glovo" ||
            "Pedidos Ya" ||
            "Uber Eats" ||
            "Transfer" ||
            "Receivable" ||
            "Card" ||
            "Partial":
        Constants.openDialog(
          context: context,
          title: title,
          btnText1: "Proceed",
          height: size.height,
          scroll: const AlwaysScrollableScrollPhysics(),
          child: inputSection(title, context),
        );
        break;
    }
  }

  Widget cashView() {
    return Column(
      children: [
        const CustomTextInput(hintText: "Amount", isNumber: true),
        Column(
          children: [
            const SizedBox(height: 18.0),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(14.0),
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
              child: const Column(
                children: [
                  CustomDigitText(title: "Total", amount: "\$120.87"),
                  SizedBox(height: 2.0),
                  CustomDigitText(title: "Change", amount: "\$0.00"),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ],
    );
  }

  Widget inputSection(String title, BuildContext context) {
    return Column(
      children: [
        if (title != "Cash")
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(14.0),
            margin: const EdgeInsets.only(top: 4.0),
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
            child: Column(
              children: [
                if (title == "Cash" ||
                    title.contains("Card") ||
                    title.contains("Partial"))
                  Column(
                    children: [
                      titleView(context, title),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                CustomDigitText(
                    title: title.contains("Partial") ? "Amount Due" : "Total",
                    amount: "DOP \$120.87"),
                Constants.divider(context, 6.0),
                if (!title.contains("Card"))
                  Column(
                    children: [
                      CustomDigitText(
                          title: title.contains("Partial")
                              ? "Partial Total"
                              : "Payment",
                          amount: "DOP \$120.87"),
                      Constants.divider(context, 6.0),
                      const CustomDigitText(
                          title: "Balance", amount: "DOP \$0.00"),
                      Constants.divider(context, 6.0),
                    ],
                  ),
                const CustomDigitText(
                    title: "Client Balance", amount: "DOP \$0.00"),
              ],
            ),
          ),
        if (title.contains("Partial"))
          Column(
            children: [
              const SizedBox(height: 16.0),
              paymentsView(context),
              const SizedBox(height: 16.0),
              partialBoxView(context),
              const SizedBox(height: 16.0),
              partialBoxView(context),
            ],
          ),
        const SizedBox(height: 16.0),
        if (title.contains("Card"))
          Column(
            children: [
              const CustomTextInput(hintText: "Card Number", isNumber: true),
              const SizedBox(height: 16.0),
              const CustomTextInput(hintText: "Expiry Date", isNumber: false),
              const SizedBox(height: 16.0),
              CustomDropdowns(
                  listData: DummyData.cardItems, hintText: "Select Card Type"),
              const SizedBox(height: 16.0),
            ],
          ),
        if (title.contains("Cash"))
          const Column(
            children: [
              CustomTextInput(hintText: "Amount", isNumber: true),
              SizedBox(height: 16.0),
            ],
          ),
        CustomDropdowns(
            listData: DummyData.currencyItems, hintText: "Select Currency"),
        const SizedBox(height: 16.0),
        const CustomTextInput(hintText: "Exchange Rate", isNumber: true),
        const SizedBox(height: 16.0),
        CustomDropdowns(listData: DummyData.ncfItems, hintText: "Select NCF"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.agentsItems, hintText: "Select Agent"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            listData: DummyData.bankAccountItems,
            hintText: "Please Select Account"),
        const SizedBox(height: 16.0),
        CustomDropdowns(listData: DummyData.taxItems, hintText: "Select Tax"),
        const SizedBox(height: 16.0),
        CustomTextInput(
            hintText: title == "Receivable" ? "Expire Date" : "Reference",
            isNumber: false),
        if (title.contains("Partial"))
          const Column(
            children: [
              SizedBox(height: 16.0),
              CustomTextInput(hintText: "Expire Date", isNumber: false),
            ],
          ),
        if (title == "Cash")
          Column(
            children: [
              const SizedBox(height: 28.0),
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(14.0),
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
                child: const Column(
                  children: [
                    CustomDigitText(title: "Total", amount: "\$120.87"),
                    SizedBox(height: 6.0),
                    CustomDigitText(title: "Change", amount: "\$0.00"),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
      ],
    );
  }

  Widget paymentsView(BuildContext context) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.only(left: 16.0),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Themes.kPrimaryColor)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Payments",
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                fontWeight: FontWeight.bold,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
          Container(
            height: 48.0,
            padding: const EdgeInsets.all(18.0),
            color: Themes.kPrimaryColor,
            child: Image.asset(
              Images.less,
              color: Themes.kWhiteColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Text(
              "2",
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                fontWeight: FontWeight.bold,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
          Container(
            height: 48.0,
            padding: const EdgeInsets.all(18.0),
            color: Themes.kPrimaryColor,
            child: Image.asset(
              Images.add,
              color: Themes.kWhiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget partialBoxView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomDropdowns(
              listData: DummyData.typeItems, hintText: "Select Type"),
          const SizedBox(height: 14.0),
          CustomDropdowns(
              listData: DummyData.bankAccountItems,
              hintText: "Please Select Account"),
          const SizedBox(height: 14.0),
          Text(
            "\$60.435",
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 22.0),
              fontWeight: FontWeight.bold,
              color: Themes.kBlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleView(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Payment Type",
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 18.0),
            fontWeight: FontWeight.w600,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 18.0),
            fontWeight: FontWeight.w600,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }
}
