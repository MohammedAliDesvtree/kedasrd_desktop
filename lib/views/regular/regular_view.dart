import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/widgets/custom_dropdowns.dart';
import 'package:kedasrd_windows/widgets/custom_qty_view.dart';
import 'package:kedasrd_windows/widgets/custom_searchbar.dart';
import 'package:kedasrd_windows/widgets/custom_pay_button.dart';
import 'package:kedasrd_windows/widgets/custom_digit_text.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';
import 'package:kedasrd_windows/widgets/custom_icon_button.dart';
import 'package:kedasrd_windows/widgets/custom_close_icon_button.dart';

import 'package:kedasrd_windows/controllers/cart_controller.dart';
import 'package:kedasrd_windows/controllers/common_controller.dart';
import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/regular_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class RegularView extends StatefulWidget {
  final String? title;
  const RegularView({super.key, this.title});

  @override
  State<RegularView> createState() => _RegularViewState();
}

class _RegularViewState extends State<RegularView> {
  final RegularController controller = Get.put(RegularController());
  final AuthController authController = Get.find<AuthController>();
  final CartController cartController = Get.find<CartController>();
  final TablesController tableController = Get.find<TablesController>();
  final CommonController commonController = Get.find<CommonController>();
  final DrawerMenuController drawerMenuController =
      Get.find<DrawerMenuController>();

  @override
  void initState() {
    super.initState();
    controller.isSearchVisible.value = false;
    commonController.isPaymentMenuVisible.value = false;
  }

  @override
  void didUpdateWidget(RegularView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset payment menu visibility when widget title changes
    if (oldWidget.title != widget.title) {
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Obx(
              () => commonController.isPaymentMenuVisible.value &&
                      widget.title!.contains("Food")
                  ? paymentMenu(size)
                  : updatedProductList(size),
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Container(
          width: ResponsiveHelper.isDesktop(context)
              ? 342.0
              : ResponsiveHelper.isTablet(context)
                  ? 264.0
                  : size.width * 0.9,
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
          child: cartView(size),
        ),
      ],
    );
  }

  Widget updatedProductList(Size size) {
    return Constants.scrollbarView(
      paddingRight: 0.0,
      child: SingleChildScrollView(
        child: GridView.builder(
          padding: const EdgeInsets.only(right: 18.0),
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(), // Disable scrolling to avoid conflicts
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, // Ensuring 4 items per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent:
                drawerMenuController.isHideDrawerMenu.value ? 150.0 : 136.0,
          ),
          itemCount: DummyData.productList.length,
          itemBuilder: (context, index) {
            var data = DummyData.productList[index];
            return Stack(
              children: [
                Material(
                  color: Themes.kTransparent,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click, // Changes cursor to hand
                    child: InkWell(
                      hoverColor: Themes.kWhiteColor,
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: index % 2.5 == 2
                          ? null
                          : () {
                              if (widget.title!.contains("Store")) {
                                Constants.openDialog(
                                  context: context,
                                  title: "",
                                  btnText1: "Add Product",
                                  child: productDetails(data),
                                  height: size.height / 1.2,
                                );
                              } else if (widget.title!.contains("Food")) {
                                CustomSnackBar.showTopRightSnackBar(
                                    context, '${data["title"]} added in cart!');
                              } else {
                                cartController.addToCart(data);
                                CustomSnackBar.showTopRightSnackBar(
                                    context, '${data["title"]} added in cart!');
                              }
                            },
                      child: Obx(
                        () => Ink(
                          height: drawerMenuController.isHideDrawerMenu.value
                              ? 150.0
                              : 136.0,
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
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  data["image"],
                                  height: drawerMenuController
                                          .isHideDrawerMenu.value
                                      ? 150.0
                                      : 136.0,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                height:
                                    drawerMenuController.isHideDrawerMenu.value
                                        ? 84.0
                                        : 68.0,
                                padding: const EdgeInsets.only(
                                    top: 4.0,
                                    bottom: 4.0,
                                    left: 12.0,
                                    right: 12.0),
                                color: Themes.kWhiteColor.withOpacity(0.6),
                                // alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data["title"],
                                      maxLines: drawerMenuController
                                              .isHideDrawerMenu.value
                                          ? 3
                                          : 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.getFontSize(
                                            context, 12.0),
                                        fontWeight: FontWeight.w700,
                                        color: Themes.kBlackColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "DOP \$${data["price"]}",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveHelper.getFontSize(
                                                    context, 14.0),
                                            fontWeight: FontWeight.w700,
                                            color: Themes.kPrimaryColor,
                                          ),
                                        ),
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
                ),
                if (index % 2.5 == 2)
                  Obx(
                    () => Container(
                      height: drawerMenuController.isHideDrawerMenu.value
                          ? 150.0
                          : 136.0,
                      padding: const EdgeInsets.only(top: 28.0),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Themes.kBlackColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        "Out Of Stock",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget cartView(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => controller.isSearchVisible.value
                    ? const Expanded(
                        child: CustomSearchBar(hintText: "Search Customer"))
                    : customerDetails(size),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: outlineButton(Images.add, "Add Customer", size, context),
          ),
          const SizedBox(height: 8.0),
          if (widget.title!.contains("Food")) dineInSection(size),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Constants.scrollbarView(
                      paddingRight: 16.0,
                      child: SingleChildScrollView(
                        child: widget.title!.contains("Food") ||
                                widget.title!.contains("Store")
                            ? fastFoodCartItemsSection(size)
                            : cartItemsSection(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14.0),
                  totalView(),
                  const SizedBox(height: 10.0),
                  Obx(() {
                    if (commonController.isDigitsViewVisible.value) {
                      return Column(
                        children: [
                          digitsView(),
                          const SizedBox(height: 16.0),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  widget.title!.contains("Store")
                      ? bottomButton(size)
                      : Row(
                          children: [
                            Expanded(
                              child: widget.title == "Regular"
                                  ? Obx(
                                      () => CustomPayButton(
                                        amount: cartController.total.value
                                            .toStringAsFixed(2),
                                        onTap: () =>
                                            CustomSnackBar.showTopRightSnackBar(
                                                context, 'Payment Successful!'),
                                      ),
                                    )
                                  : CustomPayButton(
                                      amount: "1024.34",
                                      onTap: () => commonController
                                          .isPaymentMenuVisible.value = true,
                                    ),
                            ),
                            const SizedBox(width: 12.0),
                            CustomCloseIconButton(
                              iconColor: Themes.kRedColor,
                              size: 42.0,
                              radius: 6.0,
                              padding: 0.0,
                              iconPadding: 14.0,
                              onTap: () => Constants.openAlertDialog(
                                context: context,
                                title: "",
                                msg: "This order will be cancelled.",
                                toastMsg: 'Order Cancelled!',
                                positiveAction: () {
                                  cartController.clearCart();
                                },
                              ),
                            )
                          ],
                        ),
                  if (widget.title!.contains("Food"))
                    Column(
                      children: [
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customButton("Save Item", size),
                            const SizedBox(width: 8.0),
                            customButton("Send Order To Kitchen", size),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          )
        ],
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
          onTap: () => Constants.openDialog(
            context: context,
            title: "Add Customer",
            btnText1: "Proceed",
            child: inputSection(),
          ),
          child: Ink(
            decoration: BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.6, color: Themes.kGreyColor)),
            child: Container(
              height: 48.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != "")
                    Row(
                      children: [
                        Image.asset(
                          icon,
                          height: 16.0,
                          width: 16.0,
                          color: Themes.kWhiteColor,
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

  Widget dineInSection(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dine In | User : Paloma Medrano",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 14.0),
              fontWeight: FontWeight.w400,
              color: Themes.kBlackColor,
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click, // Changes cursor to hand
            child: GestureDetector(
              onTapDown: (details) => Constants.openPopupMenu(
                context,
                details,
                DummyData.cartOptionsItems,
                "Regular - User",
                size,
              ),
              child: Image.asset(
                Images.more,
                height: 14.0,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customerDetails(Size size) {
    return Expanded(
      child: Container(
        height: 72.0,
        // width: size.width / 6.8,
        padding: const EdgeInsets.only(left: 12.0),
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Themes.kHeaderLightColor,
          border: Border.all(
              width: 1.0, color: Themes.kBlackColor.withOpacity(0.10)),
          borderRadius: BorderRadius.circular(10.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Themes.kBlackColor.withOpacity(0.20),
          //     blurRadius: 8.0,
          //     spreadRadius: -3,
          //     offset: const Offset(0, 0),
          //   ),
          // ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Paloma Medrano",
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 15.0),
                    fontWeight: FontWeight.w600,
                    color: Themes.kDarkColor,
                  ),
                ),
                Text(
                  "ccmatua@kedasrd.com - 809-536-9566",
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 12.0),
                    fontWeight: FontWeight.w400,
                    color: Themes.kDarkColor,
                  ),
                ),
              ],
            ),
            CustomCloseIconButton(
              iconColor: Themes.kRedColor,
              onTap: () => controller.isSearchVisible.value = true,
            ),
          ],
        ),
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
              Row(
                children: [
                  Obx(
                    () => Text(
                      "${cartController.cartItems.length} Items",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Themes.kBlackColor,
                      ),
                    ),
                  ),
                ],
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

  Widget digitsView() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 0.0),
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
      child: widget.title == "Regular"
          ? Obx(
              () => Column(
                children: [
                  CustomDigitText(
                    title: "Subtotal",
                    amount:
                        "\$${cartController.subtotal.value.toStringAsFixed(2)}",
                  ),
                  Constants.divider(context, 4.0),
                  CustomDigitText(
                    title: "Taxes",
                    amount: "\$${cartController.tax.value.toStringAsFixed(2)}",
                  ),
                  Constants.divider(context, 4.0),
                  const CustomDigitText(title: "Disc %", amount: "0"),
                  Constants.divider(context, 4.0),
                  CustomDigitText(
                    title: "Total",
                    amount:
                        "\$${cartController.total.value.toStringAsFixed(2)}",
                  ),
                ],
              ),
            )
          : Column(
              children: [
                const CustomDigitText(title: "Subtotal", amount: "\$847.46"),
                Constants.divider(context, 4.0),
                const CustomDigitText(title: "Taxes", amount: "\$152.54"),
                Constants.divider(context, 4.0),
                const CustomDigitText(title: "Disc %", amount: "0"),
                Constants.divider(context, 4.0),
                const CustomDigitText(title: "Total", amount: "\$1,024.32"),
              ],
            ),
    );
  }

  Widget fastFoodCartItemsSection(Size size) {
    return Column(
      children: List.generate(
        DummyData.productList.take(4).length,
        (index) {
          var data = DummyData.productList[index];
          return Container(
            // height: 184,
            margin: const EdgeInsets.only(bottom: 8.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: Themes.kHeaderLightColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                    width: 1.0, color: Themes.kBlackColor.withOpacity(0.10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor:
                            SystemMouseCursors.click, // Changes cursor to hand
                        child: GestureDetector(
                          onTap: () => controller.toggleItemExpansion(index),
                          child: Text(
                            data["title"],
                            style: TextStyle(
                              fontSize:
                                  ResponsiveHelper.getFontSize(context, 13.0),
                              fontWeight: FontWeight.w500,
                              color: Themes.kDarkColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    MouseRegion(
                      cursor:
                          SystemMouseCursors.click, // Changes cursor to hand
                      child: GestureDetector(
                        onTapDown: (details) => Constants.openPopupMenu(
                          context,
                          details,
                          DummyData.cartSingleItems,
                          "Regular - Item",
                          size,
                        ),
                        child: Image.asset(
                          Images.more,
                          height: 13.0,
                          color: Themes.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => controller.expandedIndex.value != index
                      ? Column(
                          children: [
                            const SizedBox(height: 6.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => CustomQtyView(
                                    screenName: "",
                                    initialValue: commonController.qtyValues[
                                        0], // Use index to get specific quantity
                                    onDecrease: () => commonController
                                        .updateQuantity(0, false),
                                    onIncrease: () => commonController
                                        .updateQuantity(0, true),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.getFontSize(
                                            context, 14.0),
                                        fontWeight: FontWeight.w400,
                                        color: Themes.kPrimaryColor,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      "\$500.00",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.getFontSize(
                                            context, 14.0),
                                        fontWeight: FontWeight.w900,
                                        color: Themes.kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.expandedIndex.value == index
                      ? Column(
                          children: [
                            const SizedBox(height: 6.0),
                            const CustomDigitText(title: "Qty", amount: "0"),
                            const SizedBox(height: 6.0),
                            const CustomDigitText(title: "Price", amount: "0"),
                            const SizedBox(height: 6.0),
                            const CustomDigitText(title: "Disc %", amount: "0"),
                            Constants.divider(context, 6.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontSize: ResponsiveHelper.getFontSize(
                                        context, 14.0),
                                    fontWeight: FontWeight.w400,
                                    color: Themes.kPrimaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "\$500.00",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: ResponsiveHelper.getFontSize(
                                            context, 14.0),
                                        fontWeight: FontWeight.w900,
                                        color: Themes.kPrimaryColor,
                                      ),
                                    ),
                                    Obx(
                                      () => controller.expandedIndex.value ==
                                              index
                                          ? Row(
                                              children: [
                                                const SizedBox(width: 10.0),
                                                MouseRegion(
                                                  cursor: SystemMouseCursors
                                                      .click, // Changes cursor to hand
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (authController
                                                          .isAdmin) {
                                                        CustomSnackBar
                                                            .showTopRightSnackBar(
                                                                context,
                                                                '${data["title"]} Removed!');
                                                      } else {
                                                        Constants
                                                            .openAuthCodeDialog(
                                                                context,
                                                                size,
                                                                "Cart");
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      Images.delete,
                                                      height: 15.0,
                                                      width: 15.0,
                                                      color:
                                                          Themes.kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget cartItemsSection() {
    return Obx(
      () => Column(
        children: List.generate(
          cartController.cartItems.length,
          (index) {
            var data = cartController.cartItems[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                  color: Themes.kHeaderLightColor,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      width: 1.0, color: Themes.kBlackColor.withOpacity(0.10))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 13.0),
                          fontWeight: FontWeight.w500,
                          color: Themes.kDarkColor,
                        ),
                      ),
                      MouseRegion(
                        cursor:
                            SystemMouseCursors.click, // Changes cursor to hand
                        child: GestureDetector(
                          onTap: () {
                            cartController.removeFromCart(data.id);
                            CustomSnackBar.showTopRightSnackBar(
                                context, '${data.title} Removed!');
                          },
                          child: Image.asset(
                            Images.delete,
                            height: 15.0,
                            width: 15.0,
                            color: Themes.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => CustomQtyView(
                          screenName: "POS Cart",
                          initialValue: data.quantity.value,
                          onDecrease: () =>
                              cartController.updateQuantity(data.id, false),
                          onIncrease: () =>
                              cartController.updateQuantity(data.id, true),
                        ),
                      ),
                      Obx(
                        () => Text(
                          "DOP \$${data.itemTotal.value.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize:
                                ResponsiveHelper.getFontSize(context, 13.0),
                            fontWeight: FontWeight.w500,
                            color: Themes.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget customButton(String title, Size size) {
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
        child: InkWell(
          onTap: () {
            if (title.contains("Save")) {
              CustomSnackBar.showTopRightSnackBar(
                  context, 'Save Order Successfully!');
            } else {
              if (authController.isAdmin) {
                CustomSnackBar.showTopRightSnackBar(
                    context, 'Order Sent to Kitchen!');
              } else {
                Constants.openAuthCodeDialog(context, size, "FastFood");
              }
            }
          },
          child: Ink(
            decoration: BoxDecoration(
                color: title.contains("Kitchen")
                    ? Themes.kPrimaryColor
                    : Themes.kPrimaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(3.0)),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Image.asset(
                    title.contains("Kitchen")
                        ? Images.purchaseOrder
                        : Images.save,
                    height: 14.0,
                    width: 14.0,
                    color: Themes.kWhiteColor,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 13.0),
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
            paddingRight: 0.0,
            child: SingleChildScrollView(
              child: GridView.builder(
                padding: const EdgeInsets.only(right: 18.0),
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling to avoid conflicts
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Ensuring 4 items per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  mainAxisExtent: 174.0,
                ),
                itemCount: DummyData.superMarketCartDeskItems.length,
                itemBuilder: (context, index) {
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
                            alignment: Alignment.center,
                            child: Text(
                              data["title"],
                              style: TextStyle(
                                fontSize:
                                    ResponsiveHelper.getFontSize(context, 20.0),
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
      ],
    );
  }

  Widget bottomButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        submitButton(size, "Discard Order"),
        submitButton(size, "Confirm Order"),
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
            if (title.contains("Confirm")) {
              Constants.openDialog(
                context: context,
                title: "New Customer",
                btnText1: "Continue Shopping",
                btnText2: "Submit Order",
                child: customerInputSection(),
                height: size.height / 1.3,
              );
            } else {
              Constants.openAlertDialog(
                context: context,
                title: "Discard Order",
                msg: "Are you sure you want to cancel your cart ?",
                toastMsg: 'Order Discarded!',
              );
            }
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(6.0)),
            child: Container(
              height: 42.0,
              // width: 500 / 2.3,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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

  Widget customerInputSection() {
    return const Column(
      children: [
        CustomTextInput(hintText: "Name", isNumber: false),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Phone Number", isNumber: true),
        SizedBox(height: 16.0),
        CustomTextInput(
            hintText: "Email Address", isNumber: false, isEmail: true),
        SizedBox(height: 16.0),
        CustomTextInput(hintText: "Address", isNumber: false),
      ],
    );
  }

  Widget productDetails(dynamic data) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                data["image"],
                height: 108,
                width: 132,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                    fontWeight: FontWeight.w700,
                    color: Themes.kDarkColor,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "DOP \$${data["price"]}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                    fontWeight: FontWeight.w700,
                    color: Themes.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Text(
          "Lorem ipsum dolor sit amet consectetur. Gravida vulputate senectus cras id vel. Vulputate tortor turpis fames ut pulvinar sed sagittis. Velit convallis commodo pretium amet suscipit pretium orci.",
          style: TextStyle(
            fontSize: ResponsiveHelper.getFontSize(context, 14.0),
            color: Themes.kBlackColor,
          ),
        ),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            isMultiSelect: true,
            listData: DummyData.extraItems,
            hintText: "Extra Items"),
        const SizedBox(height: 16.0),
        CustomDropdowns(
            isMultiSelect: true,
            listData: DummyData.formulaItems,
            hintText: "Formula Items"),
      ],
    );
  }
}
