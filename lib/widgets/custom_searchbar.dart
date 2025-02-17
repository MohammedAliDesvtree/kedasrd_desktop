import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';
import 'package:kedasrd_windows/utils/themes.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  const CustomSearchBar({super.key, required this.hintText});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: ResponsiveHelper.getDropdownWidth(context),
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(48.0),
          border: Border.all(width: 0.6, color: Themes.kGreyColor)),
      child: TextFormField(
        // controller: controller.searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16.5),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 14.0, color: Themes.kGreyColor),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              Images.search,
              height: 24.0,
              color: Themes.kGreyColor[500],
            ),
          ),
        ),
        onChanged: (query) {
          // controller.filterSearch(query);
        },
      ),
    );
  }
}
