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
              height: 74.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: const BoxDecoration(
                  color: Themes.kHeaderLightColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 22.0),
                      fontWeight: FontWeight.w500,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                  closeButton(),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            // Scrollable Content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomSearchBar(hintText: "Search $hintText"),
                    if (title.contains("Orders") ||
                        title == "Items" ||
                        title.contains("Draft"))
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
                  ],
                ),
                if (title.contains("Orders") ||
                    title == "Items" ||
                    title.contains("Draft"))
                  Row(
                    children: [
                      if (title.contains("Orders") || title.contains("Draft"))
                        Row(
                          children: [
                            const SizedBox(width: 16.0),
                            outlineButton(
                                Images.pdf, "Export PDF", size, context),
                            const SizedBox(width: 16.0),
                            outlineButton(
                                Images.excel, "Export Excel", size, context),
                            const SizedBox(width: 16.0),
                          ],
                        ),
                    ],
                  ),
                if (title.contains("Ricos") || title.contains("Remove"))
                  Row(
                    children: [
                      outlineButton(
                          "",
                          "Add ${title.contains("Ricos") ? "Extra" : "Formula"} Items",
                          size,
                          context),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                if (title.contains("Items"))
                  Row(
                    children: [
                      outlineButton("", "Add Products", size, context),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                if (title.contains("Customers"))
                  Row(
                    children: [
                      outlineButton("", "Add Customer", size, context),
                      const SizedBox(width: 16.0),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (title.contains("Ricos") || title.contains("Remove"))
              extraItemsView(size, context, title),
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
            if (!(title.contains("Ricos") || title.contains("Remove")))
              Container(
                height: 74.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: const BoxDecoration(
                    color: Themes.kWhiteColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton("Previous"),
                    Row(
                      children: [
                        headerText(context, "Value", "1", size),
                        headerText(context, "Value", "2", size),
                        headerText(context, "Value", "3", size),
                        headerText(context, "Value", "...", size),
                        headerText(context, "Value", "8", size),
                        headerText(context, "Value", "9", size),
                        headerText(context, "Value", "10", size),
                      ],
                    ),
                    customButton("Next"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget customButton(String title) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {},
          child: Ink(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.0,
                color: Themes.kBorderColor,
              ),
            ),
            child: Row(
              children: [
                if (title == "Previous")
                  Row(
                    children: [
                      Image.asset(
                        Images.backArrow,
                        height: 16.0,
                        width: 16.0,
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Themes.kDarkColor,
                  ),
                ),
                if (title == "Next")
                  Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Image.asset(
                        Images.rightArrow,
                        height: 16.0,
                        width: 16.0,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget extraItemsView(Size size, BuildContext context, String title) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: size.height,
              width: size.width, // Forces table to fit
              child: DataTable(
                  border:
                      TableBorder.all(width: 1.0, color: Themes.kBorderColor),
                  columnSpacing: 0,
                  columns: [
                    DataColumn(
                        label: headerText(
                            context, "Key", 'Item Description', size)),
                    DataColumn(label: headerText(context, "Key", 'Code', size)),
                    if (!title.contains("Remove"))
                      DataColumn(
                          label: headerText(context, "Key", 'Price', size)),
                    DataColumn(label: headerText(context, "Key", 'Cart', size)),
                  ],
                  rows: List.generate(0, (index) {
                    return DataRow(cells: [
                      const DataCell(Text("")),
                      const DataCell(Text("")),
                      if (!title.contains("Remove")) const DataCell(Text("")),
                      const DataCell(Text("")),
                    ]);
                  })),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "No result found!",
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 24.0),
                  fontWeight: FontWeight.w600,
                  color: Themes.kDarkColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 116.0),
        ],
      ),
    );
  }

  Widget draftsView(Size size, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height,
        width: size.width, // Forces table to fit
        child: DataTable(
          border: TableBorder.all(width: 1.0, color: Themes.kBorderColor),
          columnSpacing: 0,
          columns: [
            DataColumn(label: headerText(context, "Key", 'Customer', size)),
            DataColumn(label: headerText(context, "Key", 'Table', size)),
            DataColumn(label: headerText(context, "Key", 'Order No', size)),
            DataColumn(label: headerText(context, "Key", 'Total', size)),
            DataColumn(label: headerText(context, "Key", 'Status', size)),
            DataColumn(label: headerText(context, "Key", 'Date', size)),
            DataColumn(label: headerText(context, "Key", 'Time', size)),
            DataColumn(label: headerText(context, "Key", 'Action', size)),
          ],
          rows: List.generate(5, (index) {
            return DataRow(cells: [
              DataCell(headerText(context, "Value", 'Paloma Medrano', size)),
              DataCell(
                  headerText(context, "Value", 'Table 12 (chair 5)', size)),
              DataCell(headerText(context, "Value", '141214', size)),
              DataCell(headerText(context, "Value", '\$1501', size)),
              DataCell(headerText(context, "Value", 'Draft', size)),
              DataCell(headerText(context, "Value", '01/02/2025', size)),
              DataCell(headerText(context, "Value", '02:52 AM', size)),
              DataCell(actionButton(context, size, index)),
            ]);
          }),
        ),
      ),
    );
  }

  Widget itemsView(Size size, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height,
        width: size.width, // Forces table to fit
        child: DataTable(
          border: TableBorder.all(width: 1.0, color: Themes.kBorderColor),
          columnSpacing: 0,
          columns: [
            DataColumn(
                label: headerText(context, "Key", 'Item Description', size)),
            DataColumn(label: headerText(context, "Key", 'Code', size)),
            DataColumn(label: headerText(context, "Key", 'Price', size)),
            DataColumn(label: headerText(context, "Key", 'Status', size)),
            DataColumn(label: headerText(context, "Key", 'Stocks', size)),
          ],
          rows: List.generate(5, (index) {
            // Create all cells for this row

            final cells = [
              DataCell(headerText(context, "Value", 'Nachitos Ricos', size)),
              DataCell(headerText(context, "Value", '64913826', size)),
              DataCell(headerText(context, "Value", 'DOP \$512.16', size)),
              DataCell(headerText(context, "Value",
                  index % 3 != 1 ? "In Stock" : "Out Of Stock", size)),
              DataCell(headerText(context, "Value", '18', size)),
            ];

            // Apply tap behavior to each cell
            final tappableCells = cells
                .map((cell) => DataCell(
                      MouseRegion(
                        cursor:
                            SystemMouseCursors.click, // Changes cursor to hand
                        child: GestureDetector(
                          onTap: () => CustomSnackBar.showTopRightSnackBar(
                              context, "Nachitos Ricos added in cart!"),
                          child: SizedBox(
                            child: cell.child,
                          ),
                        ),
                      ),
                    ))
                .toList();

            return DataRow(cells: tappableCells);
          }),
        ),
      ),
    );
  }

  Widget customersView(Size size, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height,
        width: size.width, // Forces table to fit
        child: DataTable(
          border: TableBorder.all(width: 1.0, color: Themes.kBorderColor),
          columnSpacing: 0,
          columns: [
            DataColumn(label: headerText(context, "Key", 'Name', size)),
            DataColumn(label: headerText(context, "Key", 'Phone No.', size)),
            DataColumn(label: headerText(context, "Key", 'Mobile', size)),
            DataColumn(label: headerText(context, "Key", 'Email', size)),
            DataColumn(label: headerText(context, "Key", 'Tax ID', size)),
            DataColumn(label: headerText(context, "Key", 'Balance', size)),
          ],
          rows: List.generate(5, (index) {
            return DataRow(cells: [
              DataCell(headerText(context, "Value", 'Paloma Medrano', size)),
              DataCell(headerText(context, "Value", '0276744518', size)),
              DataCell(headerText(context, "Value", '9856320147', size)),
              DataCell(headerText(context, "Value", 'mesa10@kedas.com', size)),
              DataCell(headerText(context, "Value", '131174884', size)),
              DataCell(headerText(context, "Value", '0.00', size)),
            ]);
          }),
        ),
      ),
    );
  }

  Widget ordersView(Size size, BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: size.height,
        width: size.width, // Forces table to fit
        child: DataTable(
          border: TableBorder.all(width: 1.0, color: Themes.kBorderColor),
          columnSpacing: 0,
          columns: [
            DataColumn(label: headerText(context, "Key", 'Customer', size)),
            DataColumn(label: headerText(context, "Key", 'Invoice No.', size)),
            DataColumn(label: headerText(context, "Key", 'Total', size)),
            DataColumn(label: headerText(context, "Key", 'Status', size)),
            DataColumn(label: headerText(context, "Key", 'NCF', size)),
            DataColumn(label: headerText(context, "Key", 'Date', size)),
            DataColumn(label: headerText(context, "Key", 'Time', size)),
            DataColumn(label: headerText(context, "Key", 'Action', size)),
          ],
          rows: List.generate(5, (index) {
            return DataRow(cells: [
              DataCell(headerText(context, "Value", 'Paloma Medrano', size)),
              DataCell(headerText(context, "Value", 'SC009238110', size)),
              DataCell(headerText(context, "Value", '\$512.16', size)),
              DataCell(headerText(
                  context,
                  "Value",
                  index % 2 != 1
                      ? "Paid"
                      : index % 3 != 1
                          ? "Draft"
                          : "Deleted",
                  size)),
              DataCell(headerText(context, "Value", 'B0100000147', size)),
              DataCell(headerText(context, "Value", '01/02/2025', size)),
              DataCell(headerText(context, "Value", '02:52 AM', size)),
              DataCell(actionButton(context, size, index)),
            ]);
          }),
        ),
      ),
    );
  }

  Widget closeButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: 54.0,
          width: 54.0,
          padding: const EdgeInsets.all(21.0),
          color: Themes.kTransparent,
          child: Image.asset(
            Images.close,
            color: Themes.kPrimaryColor,
          ),
        ),
      ),
    );
  }

  Widget submitButton(String title, Size size, context) {
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
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
      ),
    );
  }

  Widget outlineButton(String icon, String title, Size size, context) {
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {},
          child: Ink(
            decoration: BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.6, color: Themes.kGreyColor)),
            child: Container(
              height: 52.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != "")
                    Row(
                      children: [
                        Image.asset(
                          icon,
                          height: 24.0,
                          width: 24.0,
                        ),
                        const SizedBox(width: 8.0),
                      ],
                    ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                      fontWeight: FontWeight.bold,
                      color: Themes.kWhiteColor,
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

  Widget headerText(
      BuildContext context, String type, String title, Size size) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: title == "Paid" || title == "In Stock"
              ? Themes.kGreenColor
              : title == "Draft" || title.contains("Out")
                  ? Themes.kOrangeColor
                  : title.contains("Deleted")
                      ? Themes.kRedColor
                      : Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(
              context, type == "Key" ? 16.0 : 14.0),
          fontWeight: FontWeight.w600,
          color: type == "Key"
              ? Themes.kPrimaryColor
              : title == "Paid" ||
                      title == "In Stock" ||
                      title == "Draft" ||
                      title.contains("Out") ||
                      title == "Deleted"
                  ? Themes.kWhiteColor
                  : Themes.kDarkColor,
        ),
        // ),
      ),
    );
  }

  Widget addToCartButton(BuildContext context, Size size, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      child: Align(
        alignment: Alignment.center,
        child: Material(
          color: Themes.kTransparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100.0),
            onTap: () => CustomSnackBar.showTopRightSnackBar(
                context, "Nachitos Ricos added in cart!"),
            child: Ink(
              width: 124.0,
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                  color: Themes.kPrimaryColor,
                  borderRadius: BorderRadius.circular(100.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.add,
                    height: 10.0,
                    width: 10.0,
                    fit: BoxFit.contain,
                    color: Themes.kWhiteColor,
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    "Add to cart",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
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

  Widget actionButton(BuildContext context, Size size, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTapDown: (details) => Constants.openPopupMenu(
            context,
            details,
            DummyData.actionItems,
            "Items",
            size,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Image.asset(
              Images.more,
              height: 16.0,
              color: Themes.kGreyColor,
            ),
          ),
        ),
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
