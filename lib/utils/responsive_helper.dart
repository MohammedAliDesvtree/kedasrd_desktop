import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width >= 768 && size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double getLoginContainerWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 1200) return size.width / 3.0;
    if (size.width >= 800) return size.width / 2.0;
    return size.width * 0.9;
  }

  static double getLoginContainerHeight(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height * 0.8;
  }

  static double getDrawerWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 1200) return size.width / 5.8;
    if (size.width >= 800) return size.width / 5.8;
    return size.width / 4;
  }

  static double getDropdownWidth(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width >= 1400) return size.width / 5.8;
    if (size.width >= 1200) return size.width / 6.5;
    return size.width / 5.8;
  }

  static EdgeInsets getBodyPadding(BuildContext context) {
    if (isDesktop(context)) {
      return const EdgeInsets.only(
          top: 16.0, bottom: 4.0, left: 16.0, right: 16.0);
    }
    return const EdgeInsets.all(16.0);
  }

  static double getFontSize(BuildContext context, double desktopSize) {
    if (isDesktop(context)) return desktopSize;
    if (isTablet(context)) return desktopSize * 0.85;
    return desktopSize * 0.75;
  }
}
