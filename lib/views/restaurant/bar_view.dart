import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';

class BarView extends StatelessWidget {
  const BarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No result found!",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          color: Themes.kDarkColor,
        ),
      ),
    );
  }
}
