import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/custom_dropdowns.dart';
import 'package:kedasrd_windows/widgets/custom_searchbar.dart';
import 'package:kedasrd_windows/widgets/custom_pay_button.dart';
import 'package:kedasrd_windows/widgets/custom_add_button.dart';
import 'package:kedasrd_windows/widgets/custom_digit_text.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';
import 'package:kedasrd_windows/widgets/custom_icon_button.dart';
import 'package:kedasrd_windows/widgets/custom_close_icon_button.dart';

import 'package:kedasrd_windows/controllers/cart_controller.dart';
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
  final AuthController authController = Get.find<AuthController>();
  final RegularController controller = Get.put(RegularController());
  final CartController cartController = Get.find<CartController>();
  final TablesController tableController = Get.find<TablesController>();

  @override
  void initState() {
    super.initState();
    controller.isSearchVisible.value = false;
    controller.isPaymentMenuVisible.value = false;
  }

  @override
  void didUpdateWidget(RegularView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset payment menu visibility when widget title changes
    if (oldWidget.title != widget.title) {
      controller.isPaymentMenuVisible.value = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.isPaymentMenuVisible.value = false;
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
              () => controller.isPaymentMenuVisible.value &&
                      widget.title!.contains("Food")
                  ? paymentMenu(size)
                  : updatedProductList(size),
            ),
          ),
        ),
        const SizedBox(width: 24.0),
        Container(
          width: 500.0,
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
    return SingleChildScrollView(
      child: Wrap(
          runSpacing: 16.0,
          spacing: 16.0,
          children: List.generate(
            DummyData.productList.length,
            (index) {
              var data = DummyData.productList[index];
              return Material(
                color: Themes.kTransparent,
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
                              height: size.height / 1.6,
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
                  child: Ink(
                    height: 300.0,
                    width: size.width / 5.52,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                          child: Image.asset(
                            data["image"],
                            height: 200,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 16.0, right: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data["title"],
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Themes.kBlackColor,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "DOP \$${data["price"]}",
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Themes.kPrimaryColor,
                                    ),
                                  ),
                                  if (index % 2.5 == 2)
                                    const Text(
                                      "Out Of Stock",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        color: Themes.kRedColor,
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
              );
            },
          )),
    );
  }

  Widget productList(Size size) {
    return SingleChildScrollView(
      child: Obx(
        () => Wrap(
          runSpacing: 16.0,
          spacing: 16.0,
          children: List.generate(
            DummyData.productList.length,
            (index) {
              var data = DummyData.productList[index];
              return Stack(
                children: [
                  Container(
                    height: 145.0,
                    width: size.width / 3.52,
                    // 5.36,
                    // 3.52
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 140.0,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -64.0,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(68.0),
                                            bottomRight: Radius.circular(68.0)),
                                        child: Image.asset(
                                          data["image"],
                                          height: 146.0,
                                          width: 174.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    data["title"],
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w700,
                                      color: Themes.kBlackColor,
                                    ),
                                  ),
                                  Text(
                                    "DOP \$${data["price"]}",
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w700,
                                      color: Themes.kBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: CustomAddButton(
                              isCircular: false,
                              onTap: () {
                                cartController.addToCart(data);
                                CustomSnackBar.showTopRightSnackBar(
                                    context, '${data["title"]} added in cart!');
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (index % 2.5 == 2)
                    Container(
                      height: 145.0,
                      width: size.width / 3.52,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 144.0),
                      decoration: BoxDecoration(
                        color: Themes.kBlackColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        "Out\nOf\nStock",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget cartView(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => controller.isSearchVisible.value
                    ? const CustomSearchBar(hintText: "Search Customer")
                    : customerDetails(size),
              ),
              CustomAddButton(
                isCircular: true,
                onTap: () => Constants.openDialog(
                  context: context,
                  title: "Add Customer",
                  btnText1: "Proceed",
                  child: inputSection(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          if (widget.title!.contains("Food")) dineInSection(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: widget.title!.contains("Food") ||
                              widget.title!.contains("Store")
                          ? fastFoodCartItemsSection(size)
                          : cartItemsSection(),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  digitsView(),
                  const SizedBox(height: 24.0),
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
                                      onTap: () => controller
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
                        const SizedBox(height: 16.0),
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

  Widget dineInSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Dine In | User : Paloma Medrano",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Themes.kBlackColor,
            ),
          ),
          GestureDetector(
            onTapDown: (details) => Constants.openPopupMenu(
                context, details, DummyData.cartOptionsItems, "Regular - User"),
            child: Image.asset(
              Images.more,
              height: 14.0,
              color: Themes.kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget customerDetails(Size size) {
    return Container(
      height: 70.0,
      width: size.width / 5.8,
      padding: const EdgeInsets.only(left: 16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Themes.kWhiteColor,
        borderRadius: BorderRadius.circular(10.0),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Paloma Medrano",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Themes.kDarkColor,
                ),
              ),
              Text(
                "ccmatua@kedasrd.com - 809-536-9566",
                style: TextStyle(
                  fontSize: 14.0,
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
    );
  }

  Widget digitsView() {
    return widget.title == "Regular"
        ? Obx(
            () => Column(
              children: [
                CustomDigitText(
                  title: "Subtotal",
                  amount:
                      "\$${cartController.subtotal.value.toStringAsFixed(2)}",
                ),
                Constants.divider(context, 8.0),
                CustomDigitText(
                  title: "Taxes",
                  amount: "\$${cartController.tax.value.toStringAsFixed(2)}",
                ),
                Constants.divider(context, 8.0),
                const CustomDigitText(title: "Disc %", amount: "0"),
                Constants.divider(context, 8.0),
                CustomDigitText(
                  title: "Total",
                  amount: "\$${cartController.total.value.toStringAsFixed(2)}",
                ),
              ],
            ),
          )
        : Column(
            children: [
              const CustomDigitText(title: "Subtotal", amount: "\$847.46"),
              Constants.divider(context, 8.0),
              const CustomDigitText(title: "Taxes", amount: "\$152.54"),
              Constants.divider(context, 8.0),
              const CustomDigitText(title: "Disc %", amount: "0"),
              Constants.divider(context, 8.0),
              const CustomDigitText(title: "Total", amount: "\$1,024.32"),
            ],
          );
  }

  Widget fastFoodCartItemsSection(Size size) {
    return Column(
      children: List.generate(
        2,
        (index) {
          return Container(
            margin: const EdgeInsets.only(
                left: 2.0, right: 2.0, top: 2, bottom: 8.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (authController.isAdmin) {
                          CustomSnackBar.showTopRightSnackBar(
                              context, 'Item ${index + 1} Removed!');
                        } else {
                          Constants.openAuthCodeDialog(context, size, "Cart");
                        }
                      },
                      child: Image.asset(
                        Images.delete,
                        height: 16.0,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    GestureDetector(
                      onTapDown: (details) => Constants.openPopupMenu(context,
                          details, DummyData.cartSingleItems, "Regular - Item"),
                      child: Image.asset(
                        Images.more,
                        height: 14.0,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const CustomDigitText(title: "Items", amount: "Nachitos Ricos"),
                Constants.divider(context, 8.0),
                const CustomDigitText(title: "Qty", amount: "0"),
                Constants.divider(context, 8.0),
                const CustomDigitText(title: "Price", amount: "0"),
                Constants.divider(context, 8.0),
                const CustomDigitText(title: "Disc %", amount: "0"),
                Constants.divider(context, 8.0),
                const CustomDigitText(title: "Total", amount: "\$500.00"),
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
              margin: const EdgeInsets.only(
                  left: 2.0, right: 2.0, top: 2.0, bottom: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "Nachitos Ricos ${index + 1}",
                        data.title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Themes.kDarkColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartController.removeFromCart(data.id);
                          CustomSnackBar.showTopRightSnackBar(
                              context, '${data.title} Removed!');
                        },
                        child: Image.asset(
                          Images.bin,
                          height: 18.0,
                          width: 18.0,
                          color: Themes.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 86.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              icon: Images.less,
                              size: 26.0,
                              radius: 6.0,
                              onTap: () =>
                                  cartController.updateQuantity(data.id, false),
                            ),
                            // Obx(
                            //   () => AnimatedSwitcher(
                            //     duration:
                            //         const Duration(milliseconds: 300),
                            //     transitionBuilder: (Widget child,
                            //         Animation<double> animation) {
                            //       return SlideTransition(
                            //         position: Tween<Offset>(
                            //           begin: const Offset(
                            //               0, 0.5), // Start from below
                            //           end: Offset.zero,
                            //         ).animate(animation),
                            //         child: child,
                            //       );
                            //     },
                            // child:
                            Obx(
                              () => Text(
                                "${data.quantity.value}",
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: Themes.kBlackColor,
                                ),
                              ),
                            ),
                            // ),
                            CustomIconButton(
                              icon: Images.add,
                              size: 26.0,
                              radius: 6.0,
                              onTap: () =>
                                  cartController.updateQuantity(data.id, true),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Text(
                          "DOP \$${data.itemTotal.value.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 16.0,
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
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w500,
                    color: Themes.kWhiteColor,
                  ),
                ),
              ],
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
          onTap: () => controller.isPaymentMenuVisible.value = false,
        ),
        const SizedBox(height: 24.0),
        Wrap(
          runSpacing: 16.0,
          spacing: 16.0,
          children: List.generate(
            DummyData.superMarketCartDeskItems.length,
            (index) {
              var data = DummyData.superMarketCartDeskItems[index];
              return Material(
                color: Themes.kTransparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () =>
                      tableController.onTabTapped(data["title"], size, context),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Themes.kPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      height: 161.0,
                      width: size.width / 3.6 / 1.49,
                      alignment: Alignment.center,
                      child: Text(
                        data["title"],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
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
              height: size.height / 2.2,
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
            height: 52.0,
            width: 500 / 2.3,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Themes.kWhiteColor,
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
                width: 154,
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
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Themes.kDarkColor,
                  ),
                ),
                Text(
                  "DOP \$${data["price"]}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Themes.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        const Text(
          "Lorem ipsum dolor sit amet consectetur. Gravida vulputate senectus cras id vel. Vulputate tortor turpis fames ut pulvinar sed sagittis. Velit convallis commodo pretium amet suscipit pretium orci.",
          style: TextStyle(
            fontSize: 14.0,
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
