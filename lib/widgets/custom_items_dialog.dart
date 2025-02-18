import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/widgets/custom_dropdowns.dart';
import 'package:kedasrd_windows/widgets/custom_searchbar.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';
import 'package:kedasrd_windows/widgets/custom_add_button.dart';
import 'package:kedasrd_windows/widgets/custom_icon_button.dart';

class CustomItemsDialog extends StatelessWidget {
  final String title;
  final String? hintText, btnText1;
  const CustomItemsDialog({
    super.key,
    required this.title,
    this.hintText,
    this.btnText1,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Dialog(
      child: Container(
        height: size.height / 1.2,
        width:
            ResponsiveHelper.isTablet(context) ? size.width : size.width / 1.2,
        decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Fixed Header
            Container(
              height: 78.0,
              padding: const EdgeInsets.only(top: 0.0),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      title,
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
            Row(
              // mainAxisAlignment: title.contains("Orders")
              //     ? MainAxisAlignment.center
              //     : MainAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSearchBar(hintText: "Search $hintText"),
                if (title.contains("Orders") ||
                    title == "Items" ||
                    title.contains("Draft"))
                  Row(
                    children: [
                      SizedBox(
                        width: size.width / 5.8,
                        child: CustomDropdowns(
                          hintText: "Select Filter",
                          listData: title == "Items"
                              ? DummyData.filterItems
                              : DummyData.ordersFilters,
                          borderRadius: 100.0,
                          isOutlined: true,
                        ),
                      ),
                      if (title.contains("Orders") || title.contains("Draft"))
                        Row(
                          children: [
                            const SizedBox(width: 16.0),
                            outlineButton("Export PDF", size, context),
                            const SizedBox(width: 16.0),
                            outlineButton("Export Excel", size, context),
                            const SizedBox(width: 16.0),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
            if (title == "Items") itemsView(size, context),
            if (title == "Customers") customersView(size, context),
            if (title == "Orders" || title == "All Orders")
              ordersView(size, context),
            if (title.contains("Draft")) draftsView(size, context),
            // Fixed Footer
            Container(
              padding: EdgeInsets.only(
                left: 64.0,
                right: 64.0,
                bottom: btnText1 != null && btnText1!.isNotEmpty ? 28.0 : 0.0,
                top: 28.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (btnText1 != null && btnText1!.isNotEmpty)
                    submitButton(btnText1!, size, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget draftsView(Size size, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerText(context, "key", "Customer", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Table", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Order No.", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Total", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Status", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Date", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Time", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "", size),
              ],
            ),
          ),
          Constants.divider(context, 0.0),
          const SizedBox(height: 8.0),
          Expanded(
            child: Constants.scrollbarView(
              paddingRight: 0.0,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    24,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerText(
                                context, "value", "Paloma Medrano", size),
                            const SizedBox(width: 8.0),
                            headerText(
                                context, "value", "Table 12 (Chair 5)", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "141212", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "\$1605", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value",
                                title == "Draft" ? "Draft" : "Deleted", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "01/01/2025", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "02:52 AM", size),
                            const SizedBox(width: 8.0),
                            actionButton(context, size, index)
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
    );
  }

  Widget itemsView(Size size, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerText(context, "key", "Item Description", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Code", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Price", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Status", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Discount", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Cart", size),
              ],
            ),
          ),
          Constants.divider(context, 0.0),
          const SizedBox(height: 8.0),
          Expanded(
            child: Constants.scrollbarView(
              paddingRight: 0.0,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    24,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerText(
                                context, "value", "Nachitos Ricos", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "64913826", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "DOP \$512.16", size),
                            const SizedBox(width: 8.0),
                            headerText(
                                context,
                                "value",
                                index % 3 != 1 ? "In Stock" : "Out Of Stock",
                                size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "\$0.00", size),
                            const SizedBox(width: 8.0),
                            Container(
                              width: size.width / 1.8 / 8.2,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CustomAddButton(
                                    paddingVR: 4.0,
                                    isCircular: true,
                                    onTap: () {}),
                              ),
                            ),
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
    );
  }

  Widget customersView(Size size, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerText(context, "key", "Name", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Phone No.", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Mobile", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Email", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Tax ID", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Balance", size),
              ],
            ),
          ),
          Constants.divider(context, 0.0),
          const SizedBox(height: 8.0),
          Expanded(
            child: Constants.scrollbarView(
              paddingRight: 0.0,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    24,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerText(
                                context, "value", "Paloma Medrano", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "0276744518", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "9856320147", size),
                            const SizedBox(width: 8.0),
                            headerText(
                                context, "value", "mesa10@kedas.com", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "131174884", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "0.00", size),
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
    );
  }

  Widget ordersView(Size size, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerText(context, "key", "Customer", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Invoice No.", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Total", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Status", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "NCF", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Date", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "Time", size),
                const SizedBox(width: 8.0),
                headerText(context, "key", "", size),
              ],
            ),
          ),
          Constants.divider(context, 0.0),
          const SizedBox(height: 8.0),
          Expanded(
            child: Constants.scrollbarView(
              paddingRight: 0.0,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    24,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerText(
                                context, "value", "Paloma Medrano", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "SC009238110", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "\$512.16", size),
                            const SizedBox(width: 8.0),
                            headerText(
                                context,
                                "value",
                                index % 2 != 1
                                    ? "Paid"
                                    : index % 3 != 1
                                        ? "Draft"
                                        : "Deleted",
                                size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "B0100000147", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "01/01/2025", size),
                            const SizedBox(width: 8.0),
                            headerText(context, "value", "02:52 AM", size),
                            const SizedBox(width: 8.0),
                            actionButton(context, size, index)
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
          if (title.contains("Customer")) {
            Constants.openDialog(
              context: context,
              title: "Add Customer",
              btnText1: "Proceed",
              child: inputSection(),
            );
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            height: 52.0,
            width: ResponsiveHelper.isTablet(context)
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

  Widget outlineButton(String title, Size size, context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
              color: Themes.kWhiteColor,
              borderRadius: BorderRadius.circular(100.0),
              border: Border.all(width: 0.6, color: Themes.kGreyColor)),
          child: Container(
            height: 52.0,
            width: ResponsiveHelper.isTablet(context)
                ? size.width / 8.0
                : size.width / 10.0,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                fontWeight: FontWeight.bold,
                color: Themes.kDarkColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget headerText(
      BuildContext context, String type, String title, Size size) {
    return SizedBox(
      width: title == ""
          ? 30.0
          : title.contains("@") ||
                  title.contains("Email") ||
                  title.contains("Item") ||
                  title.contains("Ricos")
              ? size.width / 1.8 / 5.0
              : size.width / 1.8 / 8.2,
      child: Text(
        type == "key" ? title.toUpperCase() : title,
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 16.0),
          fontWeight: FontWeight.w600,
          color: title == "Paid" || title == "In Stock"
              ? Themes.kGreenColor
              : title == "Draft" || title.contains("Out")
                  ? Themes.kOrangeColor
                  : title == "Deleted"
                      ? Themes.kRedColor
                      : type == "key"
                          ? Themes.kPrimaryColor
                          : Themes.kBlackColor,
        ),
      ),
    );
  }

  Widget actionButton(BuildContext context, Size size, int index) {
    return Container(
      width: 24.0,
      alignment: Alignment.centerRight,
      child: CustomIconButton(
        icon: Images.options,
        size: 24.0,
        onTapDown: (details) => Constants.openPopupMenu(
            context, details, DummyData.actionItems, "Items"),
      ),
    );
  }

  Widget inputSection() {
    return const Column(
      children: [
        CustomTextInput(hintText: "Name", isNumber: false),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Tax ID", isNumber: true),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Phone Number", isNumber: true),
      ],
    );
  }
}
