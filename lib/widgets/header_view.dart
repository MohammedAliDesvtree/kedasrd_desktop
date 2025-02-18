import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      height: 58.0,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      color: Themes.kWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // const Icon(
          //   Icons.menu,
          //   size: 22.0,
          //   color: Themes.kDarkColor,
          // ),
          const SizedBox(width: 22.0),
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTapDown: (details) => Constants.openPopupMenu(
                      context,
                      details,
                      DummyData.notificationItems,
                      "Notifications",
                      size,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      size: 24.0,
                      color: Themes.kPrimaryColor,
                    ),
                  ),
                  Positioned(
                    top: -2.0,
                    right: -2.0,
                    child: Container(
                      height: 14.0,
                      width: 14.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Themes.kRedColor,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: Text(
                        "6",
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getFontSize(context, 8.0),
                          fontWeight: FontWeight.bold,
                          color: Themes.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16.0),
              Container(
                height: 38.0,
                width: 38.0,
                decoration: BoxDecoration(
                  color: Themes.kGreyColor[300],
                  borderRadius: BorderRadius.circular(44.0),
                ),
                child: const Icon(
                  Icons.person,
                  size: 22.0,
                  color: Themes.kGreyColor,
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Moni Roy",
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 12.0),
                      fontWeight: FontWeight.w700,
                      color: Themes.kBlackColor,
                    ),
                  ),
                  Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getFontSize(context, 10.0),
                      fontWeight: FontWeight.w600,
                      color: Themes.kDarkGreyColor,
                    ),
                  ),
                ],
              ),
              // const SizedBox(width: 24.0),
              // Container(
              //   height: 20.0,
              //   width: 20.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20.0),
              //     border: Border.all(
              //       width: 0.5,
              //       color: Themes.kDarkGreyColor,
              //     ),
              //   ),
              //   child: const Icon(
              //     Icons.keyboard_arrow_down_sharp,
              //     size: 12.0,
              //     color: Themes.kDarkGreyColor,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
