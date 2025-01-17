import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/images.dart';

import 'package:kedasrd_windows/utils/themes.dart';

class CustomIconButton extends StatelessWidget {
  final String icon;
  final double? size, radius, paddingRight, iconPadding;
  final VoidCallback? onTap;
  final onTapDown;
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.onTapDown,
    this.size,
    this.radius,
    this.paddingRight,
    this.iconPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: paddingRight ?? 0.0),
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 44.0),
          onTap: onTap,
          onTapDown:
              icon != Images.options ? null : (details) => onTapDown(details),
          child: Ink(
            decoration: BoxDecoration(
                color: Themes.kPrimaryColor,
                borderRadius: BorderRadius.circular(radius ?? 44.0)),
            child: Container(
              height: size ?? 38.0,
              width: size ?? 38.0,
              padding: EdgeInsets.all(iconPadding ?? 8.0),
              child: Image.asset(
                icon,
                height: 32.0,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
