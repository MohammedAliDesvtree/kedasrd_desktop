// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import 'package:kedasrd_windows/utils/themes.dart';

// import 'package:kedasrd_windows/widgets/body_view.dart';
// import 'package:kedasrd_windows/widgets/drawer_view.dart';
// import 'package:kedasrd_windows/widgets/header_view.dart';

// import 'package:kedasrd_windows/controllers/drawer_controller.dart';

// class LandingView extends StatefulWidget {
//   const LandingView({super.key});

//   @override
//   State<LandingView> createState() => _LandingViewState();
// }

// class _LandingViewState extends State<LandingView> {
//   final DrawerMenuController controller = Get.find<DrawerMenuController>();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return WillPopScope(
//       onWillPop: controller.onWillPop,
//       child: Scaffold(
//         backgroundColor: Themes.kLightColor,
//         body: Column(
//           children: [
//             const HeaderView(),
//             Expanded(
//               child: Row(
//                 children: [
//                   const DrawerView(),
//                   Expanded(
//                     child: Container(
//                       height: size.height,
//                       width: size.width,
//                       color: Themes.kLightColor,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           BodyView(
//                             title: controller.screenTitle,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import 'package:kedasrd_windows/utils/themes.dart';
// import 'package:kedasrd_windows/utils/dummy_data.dart';
// import 'package:kedasrd_windows/utils/responsive_helper.dart';

// import 'package:kedasrd_windows/widgets/body_view.dart';
// import 'package:kedasrd_windows/widgets/drawer_view.dart';
// import 'package:kedasrd_windows/widgets/header_view.dart';

// import 'package:kedasrd_windows/controllers/drawer_controller.dart';
// import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';
// import 'package:kedasrd_windows/controllers/tables_controller.dart';

// class LandingView extends StatefulWidget {
//   const LandingView({super.key});

//   @override
//   State<LandingView> createState() => _LandingViewState();
// }

// class _LandingViewState extends State<LandingView> {
//   final DrawerMenuController controller = Get.find<DrawerMenuController>();
//   final TablesController tablesController = Get.find<TablesController>();
//   final AuthController authController = Get.find<AuthController>();

//   // Observable to track which menu item is being hovered
//   final RxString hoveredMenuItem = "".obs;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return WillPopScope(
//       onWillPop: controller.onWillPop,
//       child: Scaffold(
//         backgroundColor: Themes.kLightColor,
//         body: Stack(
//           children: [
//             // Main content
//             Column(
//               children: [
//                 const HeaderView(),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       // Pass the hover callback to the drawer
//                       DrawerView(
//                         onMenuHover: (menuTitle) {
//                           hoveredMenuItem.value = menuTitle;
//                         },
//                       ),
//                       Expanded(
//                         child: Container(
//                           height: size.height,
//                           width: size.width,
//                           color: Themes.kLightColor,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               BodyView(
//                                 title: controller.screenTitle,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             // Submenu overlay
//             Obx(() => _buildSubmenuOverlay(context, size)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmenuOverlay(BuildContext context, Size size) {
//     String menuTitle = hoveredMenuItem.value;
//     if (menuTitle.isEmpty || !controller.isHideDrawerMenu.value) {
//       return const SizedBox.shrink();
//     }

//     // Determine the position of the submenu
//     // We'll use hardcoded values for minimal changes but this could be improved
//     double topOffset = 60.0; // Header height

//     // Find the index of the menu item to determine vertical position
//     int menuIndex = DummyData.dashboardList
//         .indexWhere((item) => item["title"] == menuTitle);

//     if (menuIndex == -1) return const SizedBox.shrink();

//     // Calculate top position based on menu index
//     double menuItemHeight = 44.0;
//     double menuTop = topOffset + (menuIndex * menuItemHeight) + 16.0;

//     return Positioned(
//       left: controller.isHideDrawerMenu.value
//           ? ResponsiveHelper.getDrawerWidth(context) - 24
//           : 50,
//       top: menuTop,
//       child: _buildSubmenu(menuTitle, context, size),
//     );
//   }

//   Widget _buildSubmenu(String parentTitle, BuildContext context, Size size) {
//     // Determine which submenu to show
//     dynamic submenuItems;
//     int startIndex;

//     switch (parentTitle) {
//       case "Regular":
//         submenuItems = DummyData.posDrawerItems;
//         startIndex = 10;
//         break;
//       case "Restaurant":
//         submenuItems = DummyData.restaurantDrawerItems;
//         startIndex = 20;
//         break;
//       case "Fast Food":
//         submenuItems = DummyData.fastFoodDrawerItems;
//         startIndex = 30;
//         break;
//       case "Super Market":
//         submenuItems = DummyData.superMarketDrawerItems;
//         startIndex = 40;
//         break;
//       case "Online Store":
//         submenuItems = DummyData.onlineStoreDrawerItems;
//         startIndex = 50;
//         break;
//       default:
//         submenuItems = [];
//         startIndex = 0;
//     }

//     if (submenuItems.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return MouseRegion(
//       onEnter: (_) => hoveredMenuItem.value = parentTitle,
//       onExit: (_) => hoveredMenuItem.value = "",
//       child: Material(
//         elevation: 16,
//         shadowColor: Colors.black.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(4),
//         child: Container(
//           width: 250,
//           constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.7,
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.grey.withOpacity(0.1)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Header
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 decoration: BoxDecoration(
//                   color: Themes.kPrimaryColor.withOpacity(0.1),
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(4),
//                     topRight: Radius.circular(4),
//                   ),
//                 ),
//                 child: Text(
//                   parentTitle,
//                   style: TextStyle(
//                     fontSize: ResponsiveHelper.getFontSize(context, 14),
//                     fontWeight: FontWeight.bold,
//                     color: Themes.kPrimaryColor,
//                   ),
//                 ),
//               ),

//               Divider(
//                   height: 1, thickness: 1, color: Colors.grey.withOpacity(0.1)),

//               // Submenu items in a scrollable container
//               Flexible(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: List.generate(
//                       submenuItems.length,
//                       (index) {
//                         var item = submenuItems[index];
//                         int itemIndex = startIndex + index;
//                         return _buildSubmenuItem(
//                             item, itemIndex, context, size);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmenuItem(data, int index, BuildContext context, Size size) {
//     return GestureDetector(
//       onTap: () => controller.onMenuInnerItemTapped(
//           context, size, data["title"], authController, tablesController),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: controller.isInnerSelected(index)
//               ? Themes.kPrimaryColor.withOpacity(0.1)
//               : Colors.transparent,
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey.withOpacity(0.1),
//               width: 1,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             Image.asset(
//               data["icon"],
//               height: 18,
//               color: controller.isInnerSelected(index)
//                   ? Themes.kPrimaryColor
//                   : Themes.kDarkColor,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 data["title"],
//                 style: TextStyle(
//                   fontSize: ResponsiveHelper.getFontSize(context, 13),
//                   fontWeight: controller.isInnerSelected(index)
//                       ? FontWeight.w600
//                       : FontWeight.w500,
//                   color: controller.isInnerSelected(index)
//                       ? Themes.kPrimaryColor
//                       : Themes.kDarkColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/widgets/body_view.dart';
import 'package:kedasrd_windows/widgets/drawer_view.dart';
import 'package:kedasrd_windows/widgets/header_view.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();
  final TablesController tablesController = Get.find<TablesController>();
  final AuthController authController = Get.find<AuthController>();

  // Observable to track which menu item is being hovered
  final RxString hoveredMenuItem = "".obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        backgroundColor: Themes.kLightColor,
        body: Stack(
          children: [
            // Main content
            Column(
              children: [
                const HeaderView(),
                Expanded(
                  child: Row(
                    children: [
                      // Pass the hover callback to the drawer
                      DrawerView(
                        onMenuHover: (menuTitle) {
                          hoveredMenuItem.value = menuTitle;
                        },
                      ),
                      Expanded(
                        child: Container(
                          height: size.height,
                          width: size.width,
                          color: Themes.kLightColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BodyView(
                                title: controller.screenTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Submenu overlay
            Obx(() => _buildSubmenuOverlay(context, size)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmenuOverlay(BuildContext context, Size size) {
    String menuTitle = hoveredMenuItem.value;
    if (menuTitle.isEmpty) {
      return const SizedBox.shrink();
    }

    // Determine the position of the submenu
    // We'll use hardcoded values for minimal changes but this could be improved
    double topOffset = 60.0; // Header height

    // Find the index of the menu item to determine vertical position
    int menuIndex = DummyData.dashboardList
        .indexWhere((item) => item["title"] == menuTitle);

    if (menuIndex == -1) return const SizedBox.shrink();

    // Calculate top position based on menu index
    double menuItemHeight = 44.0;
    double menuTop = topOffset + (menuIndex * menuItemHeight) + 16.0;

    // Always show regardless of drawer expanded/collapsed (fixing issue #2)
    double leftPosition = controller.isHideDrawerMenu.value
        ? ResponsiveHelper.getDrawerWidth(context) - 24
        : 74.0; // When collapsed, position right after the 74px drawer

    return Positioned(
      left: leftPosition,
      top: menuTop,
      child: _buildSubmenu(menuTitle, context, size),
    );
  }

  Widget _buildSubmenu(String parentTitle, BuildContext context, Size size) {
    // Determine which submenu to show
    dynamic submenuItems;
    int startIndex;

    switch (parentTitle) {
      case "Regular":
        submenuItems = DummyData.posDrawerItems;
        startIndex = 10;
        break;
      case "Restaurant":
        submenuItems = DummyData.restaurantDrawerItems;
        startIndex = 20;
        break;
      case "Fast Food":
        submenuItems = DummyData.fastFoodDrawerItems;
        startIndex = 30;
        break;
      case "Super Market":
        submenuItems = DummyData.superMarketDrawerItems;
        startIndex = 40;
        break;
      case "Online Store":
        submenuItems = DummyData.onlineStoreDrawerItems;
        startIndex = 50;
        break;
      default:
        submenuItems = [];
        startIndex = 0;
    }

    if (submenuItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return MouseRegion(
      onEnter: (_) => hoveredMenuItem.value = parentTitle,
      onExit: (_) => hoveredMenuItem.value = "",
      child: Material(
        elevation: 16,
        shadowColor: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 250,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // No header anymore as per requirement 1
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
              ),

              // Submenu items in a scrollable container
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      submenuItems.length,
                      (index) {
                        var item = submenuItems[index];
                        int itemIndex = startIndex + index;
                        return _buildSubmenuItem(
                            item, itemIndex, context, size);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmenuItem(data, int index, BuildContext context, Size size) {
    // Track hover state for each submenu item (addressing issue #3)
    final RxBool isHovering = false.obs;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      child: Obx(() => GestureDetector(
            onTap: () {
              // Handle the tap and close the overlay (addressing issue #4)
              controller.onMenuInnerItemTapped(context, size, data["title"],
                  authController, tablesController);
              hoveredMenuItem.value = ""; // Clear to close overlay
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isHovering.value
                    ? Themes.kPrimaryColor.withOpacity(0.1) // Hover effect
                    : controller.isInnerSelected(index)
                        ? Themes.kPrimaryColor.withOpacity(0.05)
                        : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    data["icon"],
                    height: 18,
                    color: controller.isInnerSelected(index) || isHovering.value
                        ? Themes.kPrimaryColor
                        : Themes.kDarkColor,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      data["title"],
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 13),
                        fontWeight: controller.isInnerSelected(index) ||
                                isHovering.value
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: controller.isInnerSelected(index) ||
                                isHovering.value
                            ? Themes.kPrimaryColor
                            : Themes.kDarkColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
