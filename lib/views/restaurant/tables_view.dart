import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 3 tables per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  mainAxisExtent:
                      calculateMaxMainAxisExtent(), // Adjust height dynamically
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

  // Calculate the maximum needed mainAxisExtent for all tables
  double calculateMaxMainAxisExtent() {
    const double baseHeight = 0.0; // Base container height
    const double chairHeight = 54.0; // Height per chair
    const double padding = 48.0; // Additional padding

    // Find the maximum chair count
    int maxChairCount = controller.randomNumbers
        .reduce((max, value) => max > value ? max : value);

    return baseHeight + (chairHeight * (maxChairCount / 2).ceil()) + padding;
  }

  Widget customNewTables(int index, int randomNumber, Size size) {
    // Calculate table height based on number of chairs (switching width to height)
    const double chairHeight = 54.0; // height per chair
    final double tableHeight = (chairHeight * (randomNumber / 2).ceil());

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
          height: size.height / 4.0,
          width: 124.0,
          padding: const EdgeInsets.all(16.0),
          // color: Colors.amberAccent,
          child:
              // Table and chairs visualization
              Expanded(
            child: Column(
              children: [
                // Left side chairs
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left chairs column
                    Column(
                      children: List.generate(
                        (randomNumber / 2).ceil(),
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Transform.rotate(
                            angle: -1.5708, // -90 degrees in radians
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

                    const SizedBox(width: 8.0),

                    // Table
                    Container(
                      height: tableHeight,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[600],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(width: 8.0),

                    // Right chairs column
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        (randomNumber / 2).floor(),
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Transform.rotate(
                            angle: 1.5708, // 90 degrees in radians
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
