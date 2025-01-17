import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:kedasrd_windows/utils/themes.dart';

class CustomDropdowns extends StatelessWidget {
  final bool? isMultiSelect;
  final dynamic listData;
  final String hintText;
  final double? borderRadius;
  final bool? isOutlined;
  final Function? onListChanged;
  final Function? onChanged;
  const CustomDropdowns({
    super.key,
    this.isMultiSelect,
    this.listData,
    required this.hintText,
    this.borderRadius,
    this.isOutlined,
    this.onListChanged,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _buildDropdown();
  }

  Widget _buildDropdown() {
    if (isMultiSelect == true) {
      // initialItems: listData.take(1).toList(),
      return CustomDropdown<String>.multiSelectSearch(
        closedHeaderPadding: EdgeInsets.symmetric(
            horizontal: isOutlined == true ? 14.0 : 0.0, vertical: 16.0),
        decoration: isOutlined == true
            ? dropdownDecoration()
            : lineDropdownDecoration(),
        hintText: hintText,
        items: listData,
        onListChanged: (value) {
          if (onListChanged != null) {
            onListChanged!(value);
          }
        },
      );
    } else {
      // initialItem: listData[0],
      return CustomDropdown<String>.search(
        closedHeaderPadding: EdgeInsets.symmetric(
            horizontal: isOutlined == true ? 16.0 : 0.0, vertical: 12.0),
        decoration: isOutlined == true
            ? dropdownDecoration()
            : lineDropdownDecoration(),
        hintText: hintText,
        items: listData,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
      );
    }
  }

  CustomDropdownDecoration dropdownDecoration() {
    return CustomDropdownDecoration(
        closedFillColor: Themes.kWhiteColor,
        closedBorder: Border.all(width: 0.6, color: Themes.kGreyColor),
        closedBorderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        hintStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Themes.kGreyColor[400]),
        expandedSuffixIcon:
            const Icon(Icons.arrow_drop_up, color: Themes.kPrimaryColor),
        closedSuffixIcon:
            Icon(Icons.arrow_drop_down, color: Themes.kGreyColor[400]),
        listItemStyle: textStyle(FontWeight.w500),
        headerStyle: textStyle(FontWeight.w600),
        noResultFoundStyle: textStyle(FontWeight.bold),
        listItemDecoration:
            const ListItemDecoration(selectedIconColor: Themes.kPrimaryColor),
        searchFieldDecoration: const SearchFieldDecoration(
          textStyle: TextStyle(color: Themes.kPrimaryColor),
          hintStyle: TextStyle(color: Themes.kGreyColor),
        ));
  }

  CustomDropdownDecoration lineDropdownDecoration() {
    return CustomDropdownDecoration(
        closedFillColor: Themes.kWhiteColor,
        closedBorder: Border(
            bottom: BorderSide(color: Themes.kBlackColor.withOpacity(0.5))),
        closedBorderRadius: BorderRadius.circular(0.0),
        hintStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Themes.kGreyColor[500]),
        expandedSuffixIcon:
            const Icon(Icons.keyboard_arrow_up, color: Themes.kPrimaryColor),
        closedSuffixIcon:
            const Icon(Icons.keyboard_arrow_down, color: Themes.kPrimaryColor),
        listItemStyle: textStyle(FontWeight.w500),
        headerStyle: textStyle(FontWeight.w500),
        noResultFoundStyle: textStyle(FontWeight.bold),
        listItemDecoration:
            const ListItemDecoration(selectedIconColor: Themes.kPrimaryColor),
        searchFieldDecoration: SearchFieldDecoration(
          textStyle: const TextStyle(color: Themes.kBlackColor),
          hintStyle: TextStyle(color: Themes.kGreyColor[500]),
        ));
  }

  TextStyle textStyle(fonWeight) {
    return TextStyle(
        fontSize: 14.0, fontWeight: fonWeight, color: Themes.kBlackColor);
  }
}
