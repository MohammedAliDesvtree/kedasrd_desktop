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
    return Obx(
      () => Expanded(
        child: SingleChildScrollView(
          key: ValueKey(controller.selectedTabIndex.value),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Wrap(
            runSpacing: 16.0,
            spacing: 16.0,
            children: List.generate(tableLength, (index) {
              return customTables(index, controller.randomNumbers[index], size);
            }),
          ),
        ),
      ),
    );
  }

  Widget customTables(int index, int randomNumber, Size size) {
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
          height: 148.0,
          width: 148.0,
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
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 16.0,
                child: Image.asset(
                  Images.table,
                  height: 78.0,
                  width: 78.0,
                ),
              ),
              Positioned(
                bottom: 24.0,
                child: Text(
                  "Table ${index + 1}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Themes.kBlackColor,
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 28.0,
                  width: 40.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: randomNumber % 3 == 1
                          ? Themes.kGreenColor
                          : Themes.kRedColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10.0))),
                  child: Text(
                    "$randomNumber",
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Themes.kWhiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
