import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';

class CustomAddButton extends StatelessWidget {
  final bool isCircular;
  final Function onTap;
  final double? paddingVR;
  const CustomAddButton({
    super.key,
    required this.isCircular,
    required this.onTap,
    this.paddingVR,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: isCircular
            ? BorderRadius.circular(28.0)
            : const BorderRadius.only(
                topLeft: Radius.circular(13.0),
                bottomRight: Radius.circular(8.0),
              ),
        onTap: () => onTap(),
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: isCircular
                ? BorderRadius.circular(28.0)
                : const BorderRadius.only(
                    topLeft: Radius.circular(13.0),
                    bottomRight: Radius.circular(8.0),
                  ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: paddingVR ?? 10.0, horizontal: 16.0),
            child: Row(
              children: [
                Image.asset(
                  Images.add,
                  height: 10.0,
                  width: 10.0,
                  color: Themes.kWhiteColor,
                ),
                const SizedBox(width: 8.0),
                Text(
                  "Add".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: Themes.kWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
