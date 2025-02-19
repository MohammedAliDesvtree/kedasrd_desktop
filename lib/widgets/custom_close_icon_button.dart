import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';

class CustomCloseIconButton extends StatelessWidget {
  final Color? iconColor;
  final double? size, radius, padding, iconPadding;
  final Function onTap;
  const CustomCloseIconButton({
    super.key,
    this.iconColor,
    this.size,
    this.radius,
    this.padding,
    this.iconPadding,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Themes.kTransparent,
          child: MouseRegion(
            cursor: SystemMouseCursors.click, // Changes cursor to hand
            child: InkWell(
              borderRadius: BorderRadius.circular(radius ?? 28.0),
              onTap: () => onTap(),
              child: Ink(
                decoration: BoxDecoration(
                    color: Themes.kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(radius ?? 28.0)),
                child: Container(
                  height: size ?? 24.0,
                  width: size ?? 24.0,
                  padding: EdgeInsets.all(iconPadding ?? 8.0),
                  child: Image.asset(Images.close,
                      color: iconColor ?? Themes.kPrimaryColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
