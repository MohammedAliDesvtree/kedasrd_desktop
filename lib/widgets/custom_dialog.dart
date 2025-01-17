// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import 'package:kedasrd_windows/utils/images.dart';
// import 'package:kedasrd_windows/utils/themes.dart';

// class CustomDialog extends StatelessWidget {
//   final String title;
//   final String? btnText1, btnText2;
//   final Widget? child;
//   final double? height;
//   const CustomDialog({
//     super.key,
//     required this.title,
//     this.btnText1,
//     this.btnText2,
//     this.child,
//     this.height,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Dialog(
//       child: Container(
//         height: height ?? size.height / 2.5,
//         width: size.width / 4,
//         decoration: BoxDecoration(
//             color: Themes.kWhiteColor,
//             borderRadius: BorderRadius.circular(8.0)),
//         child: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24.0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                   color: Themes.kPrimaryColor,
//                 ),
//               ),
//             ),
//             closeButton(),
//             Positioned(
//               top: 78.0,
//               // bottom: 0.0,
//               left: 64.0,
//               right: 64.0,
//               child: child ?? const SizedBox.shrink(),
//             ),
//             Positioned(
//               bottom: 28.0,
//               left: 64.0,
//               right: 64.0,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: btnText2 != null && btnText2!.isNotEmpty
//                         ? MainAxisAlignment.spaceBetween
//                         : MainAxisAlignment.center,
//                     children: [
//                       if (btnText1 != null && btnText1!.isNotEmpty)
//                         submitButton(btnText1!, size, context),
//                       if (btnText2 != null && btnText2!.isNotEmpty)
//                         submitButton(btnText2!, size, context)
//                     ],
//                   ),
//                   if (title.contains("Cash"))
//                     Column(
//                       children: [
//                         const SizedBox(height: 16.0),
//                         submitButton("More Options", size, context),
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget closeButton() {
//     return Positioned(
//       top: 0,
//       right: 0,
//       child: Material(
//         color: Themes.kTransparent,
//         child: InkWell(
//           onTap: () => Get.back(),
//           borderRadius: const BorderRadius.only(
//             topRight: Radius.circular(8.0),
//             bottomLeft: Radius.circular(8.0),
//             topLeft: Radius.circular(0.0),
//             bottomRight: Radius.circular(0.0),
//           ),
//           child: Ink(
//             decoration: BoxDecoration(
//               color: Themes.kPrimaryColor.withOpacity(0.1),
//               borderRadius: const BorderRadius.only(
//                 topRight: Radius.circular(8.0),
//                 bottomLeft: Radius.circular(8.0),
//                 topLeft: Radius.circular(0.0),
//                 bottomRight: Radius.circular(0.0),
//               ),
//             ),
//             child: Container(
//               height: 54.0,
//               width: 54.0,
//               padding: const EdgeInsets.all(21.0),
//               child: Image.asset(
//                 Images.close,
//                 color: Themes.kPrimaryColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget submitButton(String title, Size size, context) {
//     return Material(
//       color: Themes.kTransparent,
//       child: InkWell(
//         onTap: () {
//           if (title.contains("Options")) {}
//           Get.back();
//         },
//         child: Ink(
//           decoration: BoxDecoration(
//             color: Themes.kPrimaryColor,
//             borderRadius: BorderRadius.circular(6.0),
//           ),
//           child: Container(
//             height: 52.0,
//             width: btnText2 != null && btnText2!.isNotEmpty
//                 ? size.width / 3 / 4
//                 : size.width / 3 / 3,
//             alignment: Alignment.center,
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//                 color: Themes.kWhiteColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/images.dart';
import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';

import 'package:kedasrd_windows/controllers/tables_controller.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final String? btnText1, btnText2;
  final Widget? child;
  final double? height;
  final ScrollPhysics? scroll;
  const CustomDialog({
    super.key,
    required this.title,
    this.btnText1,
    this.btnText2,
    this.child,
    this.height,
    this.scroll,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TablesController controller = Get.find<TablesController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Dialog(
      child: Container(
        height: widget.height ?? size.height / 2.5,
        width: size.width / 4,
        decoration: BoxDecoration(
            color: Themes.kWhiteColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: [
            // Fixed Header
            Container(
              height: 78.0,
              padding: const EdgeInsets.only(top: 0.0),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Themes.kPrimaryColor,
                      ),
                    ),
                  ),
                  closeButton(),
                ],
              ),
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: widget.scroll ?? const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: widget.child ?? const SizedBox.shrink(),
                ),
              ),
            ),
            // Fixed Footer
            Container(
              padding: const EdgeInsets.only(
                left: 64.0,
                right: 64.0,
                bottom: 28.0,
                top: 28.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment:
                        widget.btnText2 != null && widget.btnText2!.isNotEmpty
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                    children: [
                      if (widget.btnText1 != null &&
                          widget.btnText1!.isNotEmpty)
                        submitButton(widget.btnText1!, size, context),
                      if (widget.btnText2 != null &&
                          widget.btnText2!.isNotEmpty)
                        submitButton(widget.btnText2!, size, context)
                    ],
                  ),
                  if (widget.title.contains("Cash") &&
                      widget.height != size.height)
                    Column(
                      children: [
                        const SizedBox(height: 16.0),
                        submitButton("More Options", size, context),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget closeButton() {
    return Positioned(
      top: 0,
      right: 0,
      child: Material(
        color: Themes.kTransparent,
        child: InkWell(
          onTap: () => Get.back(),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            topLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              color: Themes.kPrimaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                topLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
            ),
            child: Container(
              height: 54.0,
              width: 54.0,
              padding: const EdgeInsets.all(21.0),
              child: Image.asset(
                Images.close,
                color: Themes.kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton(String title, Size size, context) {
    return Material(
      color: Themes.kTransparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.0),
        onTap: () {
          Get.back();
          if (title.contains("Options")) {
            Constants.openDialog(
              context: context,
              title: "Cash",
              btnText1: "Proceed",
              height: size.height,
              scroll: const AlwaysScrollableScrollPhysics(),
              child: controller.inputSection("Cash", context),
            );
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Themes.kPrimaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            height: 52.0,
            width: widget.btnText2 != null && widget.btnText2!.isNotEmpty
                ? size.width / 3 / 4
                : size.width / 3 / 3,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Themes.kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
