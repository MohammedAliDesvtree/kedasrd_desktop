import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';

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
    return Wrap(
      runSpacing: 16.0,
      spacing: 16.0,
      children: List.generate(
        widget.data.length,
        (index) {
          var data = widget.data[index];
          return GestureDetector(
            onTap: () => widget.onItemTap(data["title"]),
            child: Container(
              height: 161.0,
              width: size.width / 3.6,
              // padding:
              //     const EdgeInsets.symmetric(horizontal: 16.0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Stack(
                  children: [
                    Image.asset(
                      data["image"],
                      // height: 161.0,
                      width: size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      // height: 161.0,
                      width: size.width,
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
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
