import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';
import 'package:kedasrd_windows/utils/themes.dart';

import 'package:kedasrd_windows/controllers/auth/sign_in_controller.dart';

class CustomTextInput extends StatefulWidget {
  final String hintText;
  final bool isNumber, isSecure;
  final bool? isEmail;
  final TextEditingController? controller;
  const CustomTextInput({
    super.key,
    required this.hintText,
    required this.isNumber,
    this.isSecure = false,
    this.isEmail,
    this.controller,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  final SignInController signInController = Get.find<SignInController>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      readOnly: widget.hintText.contains("Expire") ? true : false,
      controller: widget.controller,
      obscureText: widget.isSecure,
      keyboardType: widget.isNumber
          ? TextInputType.number
          : (widget.isEmail != null && widget.isEmail == true)
              ? TextInputType.emailAddress
              : TextInputType.text,
      initialValue: widget.controller == null
          ? (widget.hintText == "Amount" ? "\$120.87" : "")
          : null,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Themes.kDarkColor.withOpacity(0.5))),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: ResponsiveHelper.getFontSize(context, 14.0),
          fontWeight: FontWeight.w500,
          color: Themes.kGreyColor[500],
        ),
        suffixIcon: widget.hintText == "Password"
            ? Container(
                height: 24.0,
                width: 24.0,
                alignment: Alignment.center,
                child: Obx(
                  () => GestureDetector(
                    onTap: () => signInController.togglePassword(),
                    child: Image.asset(
                      signInController.isPasswordShow.value
                          ? Images.passHide
                          : Images.passShow,
                      height: 24.0,
                      width: 24.0,
                    ),
                  ),
                ),
              )
            : null,
      ),
      onTap: () {
        if (widget.hintText.contains("Expire")) {
          openDatePicker(context);
        }
      },
    );
  }

  openDatePicker(context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      // var formattedDate = DateFormat("d MMM y").format(picked).toString();
      // if (type == "Date") {
      //   dateController.text = "$picked";
      //   formattedDateController.text = formattedDate;
      // } else {
      //   reminderController.text = "$picked";
      //   formattedReminderController.text = formattedDate;
      // }
    }
  }
}
