import 'package:flutter/material.dart';

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
          size,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText("Key", "Address"),
              const SizedBox(height: 6.0),
              customText("Value",
                  "Calle Padre Bonilla, No. 32 Sector Los Trinitarios, Municipio Santo Domingo Este,Provincia Santo Domingo"),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Text(
            "Opening hours",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              color: Themes.kPrimaryColor,
            ),
          ),
        ),
        Constants.customView(
          size,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Hours"),
                  customText("Value", "Open at - Close at"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Mon"),
                  customText("Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Tue"),
                  customText("Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Wed"),
                  customText("Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Thu"),
                  customText("Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Fri"),
                  customText("Value", "00:00 - 23:59"),
                ],
              ),
              const SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText("Keys", "Sat"),
                  customText("Value", "00:00 - 23:59"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget customText(String type, String txt) {
    return Text(
      type == "Keys"
          ? txt
          : type == "Key"
              ? "$txt :"
              : txt,
      style: TextStyle(
        fontSize: txt == "Address"
            ? 24.0
            : (type == "Key" || type == "Keys")
                ? 18.0
                : 16.0,
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
