import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/constants.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';

import 'package:kedasrd_windows/controllers/kitchen_controller.dart';

class KitchenView extends StatefulWidget {
  const KitchenView({super.key});

  @override
  State<KitchenView> createState() => _KitchenViewState();
}

class _KitchenViewState extends State<KitchenView> {
  final KitchenController controller = Get.put(KitchenController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 16.0,
        spacing: 16.0,
        children: List.generate(
          16,
          (index) => orderView(controller.orders[index], index, size),
        ),
      ),
    );
  }

  Widget orderView(List<String> items, int index, Size size) {
    return Column(
      children: [
        Container(
          width: size.width / 3.6,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 24.0,
                right: -6.0,
                child: GestureDetector(
                  onTap: () => CustomSnackBar.showTopRightSnackBar(
                      context, "Printing..."),
                  child: Image.asset(
                    Images.printer,
                    height: 22.0,
                    width: 22.0,
                    color: Themes.kPrimaryColor,
                  ),
                ),
              ),
              Positioned(
                top: -12.0,
                right: -12.0,
                child: Container(
                  height: 28.0,
                  width: 84.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Themes.kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    index % 2 != 0 ? "Table: ${index + 1}" : "Delivery",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  keyValuesBullet("Order Id : ", "139925"),
                  const SizedBox(height: 4.0),
                  keyValuesBullet("Customer : ", "Paloma Medrano"),
                  const SizedBox(height: 12.0),
                  Column(
                    children: List.generate(items.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: items.length - 1 == index ? 0.0 : 8.0),
                        child: singleOrderView(index),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget singleOrderView(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Themes.kPrimaryColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Qty : 2",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                  Text(
                    "20:55",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                "Chicharroncitos De Pollo",
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Themes.kWhiteColor,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -6.0,
            right: -6.0,
            child: Material(
              color: Themes.kTransparent,
              child: InkWell(
                onTap: () {
                  if (index % 2 != 0) {
                    CustomSnackBar.showTopRightSnackBar(
                        context, "Status Changed Successfully!");
                  }
                },
                borderRadius: BorderRadius.circular(100),
                child: Ink(
                  decoration: BoxDecoration(
                    color: index % 2 != 0
                        ? Themes.kRedColor
                        : index % 3 != 0
                            ? Themes.kGreenColor
                            : Themes.kOrangeColor,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Container(
                    height: 19.0,
                    width: 84.0,
                    alignment: Alignment.center,
                    child: Text(
                      index % 2 != 0
                          ? "Start"
                          : index % 3 != 0
                              ? "Done"
                              : "In Progress",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Themes.kWhiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget keyValuesBullet(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Themes.kPrimaryColor,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Themes.kBlackColor,
          ),
        ),
      ],
    );
  }
}