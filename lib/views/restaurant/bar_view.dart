import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

class BarView extends StatelessWidget {
  const BarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No result found!",
        style: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 24.0),
          fontWeight: FontWeight.w600,
          color: Themes.kDarkColor,
        ),
      ),
    );
  }
}
