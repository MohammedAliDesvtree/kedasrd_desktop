import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';

import 'package:kedasrd_windows/widgets/custom_tabs_list.dart';
import 'package:kedasrd_windows/widgets/custom_text_input.dart';

import 'package:kedasrd_windows/controllers/tables_controller.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  final TablesController controller = Get.put(TablesController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTabsList(data: DummyData.tableTabs, type: "Tables"),
        const SizedBox(height: 24.0),
        Obx(() {
          int tableLength = controller.selectedTabIndex.value == 0
              ? 7
              : controller.selectedTabIndex.value == 1
                  ? 2
                  : controller.selectedTabIndex.value == 2
                      ? 1
                      : controller.selectedTabIndex.value == 3
                          ? 1
                          : 1;
          return tablesView(tableLength, size);
        }),
      ],
    );
  }

  Widget customTabsList(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(DummyData.tableTabs.length, (index) {
        var data = DummyData.tableTabs[index];
        return Column(
          children: [
            Material(
              color: Themes.kTransparent,
              child: MouseRegion(
                cursor: SystemMouseCursors.click, // Changes cursor to hand
                child: InkWell(
                  borderRadius: BorderRadius.circular(52.0),
                  onTap: () => controller.selectTab(index),
                  child: Obx(
                    () {
                      return Ink(
                        child: Container(
                          height: 48.0,
                          width: 48.0,
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            data["icon"],
                            height: 24.0,
                            width: 24.0,
                            color: controller.selectedTabIndex.value == index
                                ? Themes.kPrimaryColor
                                : Themes.kGreyColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0.0),
            Obx(
              () => Text(
                data["title"],
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                  fontWeight: FontWeight.w500,
                  color: controller.selectedTabIndex.value == index
                      ? Themes.kPrimaryColor
                      : Themes.kGreyColor,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget tablesView(int tableLength, Size size) {
    return Expanded(
      child: Constants.scrollbarView(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Obx(
              () => GridView.builder(
                key: ValueKey(controller.selectedTabIndex.value),
                padding: const EdgeInsets.symmetric(
                    vertical: 32.0, horizontal: 16.0),
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling to avoid conflicts
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 tables per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 90.0,
                  mainAxisExtent: 180, // Adjust height dynamically
                ),
                itemCount: tableLength,
                itemBuilder: (context, index) => customNewTables(
                    index, controller.randomNumbers[index], size),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customNewTables(int index, int randomNumber, Size size) {
    // Calculate table width based on number of chairs
    const double chairWidth = 68.0; // width per chair
    final double tableWidth = (chairWidth * (randomNumber / 2).ceil());

    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      child: GestureDetector(
        onTap: () => Constants.openDialog(
          context: context,
          title: "Enter Code to Continue",
          btnText1: "Submit",
          child: const CustomTextInput(hintText: "Enter code", isNumber: true),
          height: size.height / 2.5,
        ),
        child: Container(
          height: 124.0, // Increased height to accommodate chairs
          width: size.width / 4.0,
          padding: const EdgeInsets.all(16.0),
          // decoration: BoxDecoration(
          //   color: Themes.kWhiteColor,
          //   borderRadius: BorderRadius.circular(10.0),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Themes.kBlackColor.withOpacity(0.20),
          //       blurRadius: 8.0,
          //       spreadRadius: -3,
          //       offset: const Offset(0, 0),
          //     ),
          //   ],
          // ),
          child: Column(
            children: [
              // Table info
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Table ${index + 1}",
              //       style: const TextStyle(
              //         fontSize: 16.0,
              //         fontWeight: FontWeight.w400,
              //         color: Themes.kDarkColor,
              //       ),
              //     ),
              //     Text(
              //       "Capacity - $randomNumber",
              //       style: const TextStyle(
              //         fontSize: 14.0,
              //         fontWeight: FontWeight.w400,
              //         color: Themes.kPrimaryColor,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 12),
              // Table and chairs visualization
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Table
                    Container(
                      height: 120,
                      width: tableWidth,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Top chairs
                    ...List.generate(
                      (randomNumber / 2).ceil(),
                      (i) => Positioned(
                        top: -48.0,
                        left: i * chairWidth,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            Images.newChair,
                            height: 41.0,
                            width: 48.0,
                            color: randomNumber % 3 == 1
                                ? Themes.kGreenColor
                                : Themes.kRedColor,
                          ),
                        ),
                      ),
                    ),
                    // Bottom chairs
                    ...List.generate(
                      (randomNumber / 2).floor(),
                      (i) => Positioned(
                        bottom: -48.0,
                        left: i * chairWidth,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Transform.rotate(
                            angle: 3.14159, // 180 degrees in radians(
                            child: Image.asset(
                              Images.newChair,
                              height: 41.0,
                              width: 48.0,
                              color: randomNumber % 3 == 1
                                  ? Themes.kGreenColor
                                  : Themes.kRedColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
