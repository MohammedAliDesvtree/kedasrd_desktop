import 'package:flutter/material.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.customView(
          context,
          size,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(context, "Key", "Address"),
              const SizedBox(height: 6.0),
              customText(context, "Value",
                  "Calle Padre Bonilla, No. 32 Sector Los Trinitarios, Municipio Santo Domingo Este,Provincia Santo Domingo"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            "Opening hours",
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(context, 24.0),
              fontWeight: FontWeight.w800,
              color: Themes.kPrimaryColor,
            ),
          ),
        ),
        Constants.customView(
          context,
          size,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Hours"),
                  customText(context, "Value", "Open at - Close at"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Mon"),
                  customText(context, "Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Tue"),
                  customText(context, "Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Wed"),
                  customText(context, "Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Thu"),
                  customText(context, "Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Fri"),
                  customText(context, "Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(context, "Keys", "Sat"),
                  customText(context, "Value", "00:00 - 23:59"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget customText(BuildContext context, String type, String txt) {
    return Text(
      type == "Keys"
          ? txt
          : type == "Key"
              ? "$txt :"
              : txt,
      style: TextStyle(
        fontSize: ResponsiveHelper.getFontSize(
            context,
            txt == "Address"
                ? 24.0
                : (type == "Key" || type == "Keys")
                    ? 18.0
                    : 16.0),
        fontWeight: (type == "Key" || type == "Keys")
            ? FontWeight.w800
            : FontWeight.w500,
        color: (type == "Key" || type == "Keys")
            ? Themes.kPrimaryColor
            : Themes.kBlackColor,
      ),
    );
  }
}
