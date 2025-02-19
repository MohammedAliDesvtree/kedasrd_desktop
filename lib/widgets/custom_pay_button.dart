import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/utils/themes.dart';

class CustomPayButton extends StatelessWidget {
  final String amount;
  final Function onTap;
  const CustomPayButton({super.key, required this.amount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Material(
      color: Themes.kTransparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Changes cursor to hand
        child: InkWell(
          borderRadius: BorderRadius.circular(6.0),
          onTap: () => onTap(),
          child: Ink(
            decoration: BoxDecoration(
                color: const Color(0xFF539717),
                borderRadius: BorderRadius.circular(6.0)),
            child: Container(
              height: 42.0,
              width: size.width,
              alignment: Alignment.center,
              child: Text(
                "Pay \$$amount",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 16.0),
                  fontWeight: FontWeight.w600,
                  color: Themes.kWhiteColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
