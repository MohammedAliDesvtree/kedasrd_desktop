import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';

import 'package:kedasrd_windows/controllers/tables_controller.dart';

class CustomTabsList extends StatefulWidget {
  final dynamic data;
  final String type;
  const CustomTabsList({
    super.key,
    this.data,
    required this.type,
  });

  @override
  State<CustomTabsList> createState() => _CustomTabsListState();
}

class _CustomTabsListState extends State<CustomTabsList> {
  final TablesController controller = Get.find<TablesController>();

  @override
  void initState() {
    super.initState();
    if (widget.type == "Tables") {
      controller.selectedTabIndex.value = 0;
    } else if (widget.type == "Super Market") {
      controller.selectedTabIndex.value = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Row(
      children: List.generate(
        widget.data.length,
        (index) {
          var data = widget.data[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Material(
              color: Themes.kTransparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(48.0),
                onTap: () {
                  if (widget.type == "Tables") {
                    controller.selectTab(index);
                  } else if (widget.type.contains("Super Market")) {
                    controller.onTabTapped(data["title"], size, context);
                  }
                },
                child: widget.type == "Tables"
                    ? Obx(
                        () {
                          final isSelected = widget.type == "Tables" &&
                              controller.selectedTabIndex.value == index;

                          return Ink(
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? Themes.kPrimaryColor // Selected color
                                    : Themes.kWhiteColor, // Unselected color
                                border: Border.all(
                                    width: 0.5, color: Themes.kPrimaryColor),
                                borderRadius: BorderRadius.circular(48.0)),
                            child: Container(
                              height: 42.0,
                              width: 136.0,
                              alignment: Alignment.center,
                              child: Text(
                                data["title"],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Themes.kWhiteColor
                                      : Themes.kGreyColor,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Ink(
                        decoration: BoxDecoration(
                            color: data["color"] ?? Themes.kPrimaryColor,
                            border: Border.all(
                                width: 0.5,
                                color: data["color"] ?? Themes.kPrimaryColor),
                            borderRadius: BorderRadius.circular(48.0)),
                        child: Container(
                          height: 42.0,
                          width: 136.0,
                          alignment: Alignment.center,
                          child: Text(
                            data["title"],
                            style: const TextStyle(
                              fontSize: 15.0,
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
    );
  }
}
