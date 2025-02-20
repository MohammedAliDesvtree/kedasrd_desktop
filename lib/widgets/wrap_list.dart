import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class WrapList extends StatefulWidget {
  final dynamic data;
  final Function(String) onItemTap;
  const WrapList({
    super.key,
    this.data,
    required this.onItemTap,
  });

  @override
  State<WrapList> createState() => _WrapListState();
}

class _WrapListState extends State<WrapList> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    // Calculate item width for 3 items per row with spacing
    // final itemWidth =
    //     (size.width - 64) / 3; // Account for padding and spacing between items

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling to avoid conflicts
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Ensuring 4 items per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        mainAxisExtent: 150.0,
      ),
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        var data = widget.data[index];
        return MouseRegion(
          cursor: SystemMouseCursors.click, // Changes cursor to hand
          child: GestureDetector(
            onTap: () => widget.onItemTap(data["title"]),
            child: Container(
              height: 140.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Stack(
                  children: [
                    Image.asset(
                      data["image"],
                      height: size.height,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Themes.kTransparent,
                              Themes.kBlackColor.withOpacity(0.9)
                            ],
                            stops: const [
                              0.5,
                              1.0
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 14.0,
                      bottom: 14.0,
                      child: Text(
                        "${data["title"]}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 18.0),
                          fontWeight: FontWeight.w500,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
