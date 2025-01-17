import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
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
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width / 5.8,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Themes.kWhiteColor,
          borderRadius: BorderRadius.circular(48.0),
          border: Border.all(width: 0.6, color: Themes.kGreyColor)),
      child: TextFormField(
        // controller: controller.searchController,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          // contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Themes.kGreyColor),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
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
