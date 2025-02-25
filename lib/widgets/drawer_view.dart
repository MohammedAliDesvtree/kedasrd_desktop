// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import 'package:kedasrd_windows/utils/images.dart';
// import 'package:kedasrd_windows/utils/themes.dart';
// import 'package:kedasrd_windows/utils/constants.dart';
// import 'package:kedasrd_windows/utils/dummy_data.dart';
// import 'package:kedasrd_windows/utils/responsive_helper.dart';

// import 'package:kedasrd_windows/controllers/drawer_controller.dart';
// import 'package:kedasrd_windows/controllers/tables_controller.dart';
// import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

// class DrawerView extends StatefulWidget {
//   const DrawerView({
//     super.key,
//   });

//   @override
//   State<DrawerView> createState() => _DrawerViewState();
// }

// class _DrawerViewState extends State<DrawerView> {
//   final DrawerMenuController controller = Get.find<DrawerMenuController>();
//   final TablesController tablesController = Get.find<TablesController>();
//   final AuthController authController = Get.find<AuthController>();

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Obx(
//       () => Container(
//         width: !controller.isHideDrawerMenu.value
//             ? 74.0
//             : ResponsiveHelper.getDrawerWidth(context),
//         color: Themes.kWhiteColor,
//         child: Column(
//           children: [
//             // const SizedBox(height: 12.0),
//             Expanded(
//               child: Constants.scrollbarView(
//                 paddingRight: 0.0,
//                 child: SingleChildScrollView(
//                   child: innerListView(context, size),
//                 ),
//                 // child: SingleChildScrollView(
//                 //   child: Column(
//                 //     children: List.generate(
//                 //       DummyData.homeDrawerItems.length,
//                 //       (index) {
//                 //         var data = DummyData.homeDrawerItems[index];
//                 //         return Padding(
//                 //           padding: const EdgeInsets.only(bottom: 0.0),
//                 //           child: Obx(
//                 //             () => Column(
//                 //               children: [
//                 //                 // Row(
//                 //                 //   children: [
//                 //                 //     Container(
//                 //                 //       height: 50.0,
//                 //                 //       width: 9.0,
//                 //                 //       decoration: BoxDecoration(
//                 //                 //         color: controller.isMainSelected(index)
//                 //                 //             ? Themes.kPrimaryColor
//                 //                 //             : Themes.kWhiteColor,
//                 //                 //         borderRadius: const BorderRadius.only(
//                 //                 //           topRight: Radius.circular(6.0),
//                 //                 //           bottomRight: Radius.circular(6.0),
//                 //                 //         ),
//                 //                 //       ),
//                 //                 //     ),
//                 //                 //     const SizedBox(width: 16.0),
//                 //                 //     Expanded(
//                 //                 //       child: MouseRegion(
//                 //                 //         cursor: SystemMouseCursors
//                 //                 //             .click, // Changes cursor to hand
//                 //                 //         child: GestureDetector(
//                 //                 //           onTap: () =>
//                 //                 //               controller.onMenuMainItemTapped(
//                 //                 //                   data["title"]),
//                 //                 //           child: Container(
//                 //                 //             height: 50.0,
//                 //                 //             width: size.width,
//                 //                 //             padding: const EdgeInsets.only(
//                 //                 //                 left: 16.0, right: 16.0),
//                 //                 //             decoration: BoxDecoration(
//                 //                 //               color: controller
//                 //                 //                       .isMainSelected(index)
//                 //                 //                   ? Themes.kPrimaryColor
//                 //                 //                   : Themes.kWhiteColor,
//                 //                 //               borderRadius:
//                 //                 //                   BorderRadius.circular(6.0),
//                 //                 //             ),
//                 //                 //             child: Row(
//                 //                 //               mainAxisAlignment:
//                 //                 //                   MainAxisAlignment
//                 //                 //                       .spaceBetween,
//                 //                 //               children: [
//                 //                 //                 Row(
//                 //                 //                   children: [
//                 //                 //                     Image.asset(
//                 //                 //                       data["icon"],
//                 //                 //                       height: 18.0,
//                 //                 //                       color: Themes.kWhiteColor,
//                 //                 //                     ),
//                 //                 //                     // if (ResponsiveHelper
//                 //                 //                     //     .isDesktop(context))
//                 //                 //                     if (controller
//                 //                 //                         .isHideDrawerMenu.value)
//                 //                 //                       Row(
//                 //                 //                         children: [
//                 //                 //                           const SizedBox(
//                 //                 //                               width: 8.0),
//                 //                 //                           Text(
//                 //                 //                             data["title"],
//                 //                 //                             style: TextStyle(
//                 //                 //                               fontSize:
//                 //                 //                                   ResponsiveHelper
//                 //                 //                                       .getFontSize(
//                 //                 //                                           context,
//                 //                 //                                           14.0),
//                 //                 //                               fontWeight:
//                 //                 //                                   FontWeight
//                 //                 //                                       .w700,
//                 //                 //                               color: controller
//                 //                 //                                       .isMainSelected(
//                 //                 //                                           index)
//                 //                 //                                   ? Themes
//                 //                 //                                       .kWhiteColor
//                 //                 //                                   : Themes
//                 //                 //                                       .kDarkColor,
//                 //                 //                             ),
//                 //                 //                           ),
//                 //                 //                         ],
//                 //                 //                       ),
//                 //                 //                   ],
//                 //                 //                 ),
//                 //                 //                 index != 0
//                 //                 //                     ? const SizedBox.shrink()
//                 //                 //                     : Icon(
//                 //                 //                         controller
//                 //                 //                                 .isMainSelected(
//                 //                 //                                     index)
//                 //                 //                             ? Icons
//                 //                 //                                 .keyboard_arrow_down
//                 //                 //                             : Icons
//                 //                 //                                 .keyboard_arrow_right,
//                 //                 //                         size: 24.0,
//                 //                 //                         color: controller
//                 //                 //                                 .isMainSelected(
//                 //                 //                                     index)
//                 //                 //                             ? Themes.kWhiteColor
//                 //                 //                             : Themes.kDarkColor,
//                 //                 //                       ),
//                 //                 //               ],
//                 //                 //             ),
//                 //                 //           ),
//                 //                 //         ),
//                 //                 //       ),
//                 //                 //     ),
//                 //                 //     const SizedBox(width: 24.0),
//                 //                 //   ],
//                 //                 // ),
//                 //                 index != 0
//                 //                     ? const SizedBox.shrink()
//                 //                     : controller.isMainSelected(index)
//                 //                         ? innerListView(context, size)
//                 //                         : const SizedBox.shrink(),
//                 //               ],
//                 //             ),
//                 //           ),
//                 //         );
//                 //       },
//                 //     ),
//                 //   ),
//                 // ),
//               ),
//             ),
//             logoutItem(
//               "Setting",
//               Images.setting,
//               size,
//             ),
//             logoutItem(
//               "Logout",
//               Images.logout,
//               size,
//             ),
//             const SizedBox(height: 24.0)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget innerListView(BuildContext context, Size size) {
//     return Container(
//       margin: const EdgeInsets.only(left: 24.0, top: 16.0),
//       child: Column(
//         children: List.generate(
//           DummyData.dashboardList.length,
//           (innerIndex) {
//             var data = DummyData.dashboardList[innerIndex];

//             return Column(
//               children: [
//                 // Main menu item
//                 innerItemView(data, innerIndex, context, size),

//                 // Show inner items based on selection
//                 if (controller.shouldShowInnerItems(data["title"]))
//                   innerMenuInnerItems(data["title"], context, size),
//               ],
//               // ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget innerItemView(data, int innerIndex, BuildContext context, size) {
//     bool isMainItem = DummyData.dashboardList.contains(data);
//     bool isExpanded = controller.shouldShowInnerItems(data["title"]);

//     return MouseRegion(
//       cursor: SystemMouseCursors.click, // Changes cursor to hand
//       child: GestureDetector(
//         onTap: () => controller.onMenuInnerItemTapped(
//             context, size, data["title"], authController, tablesController),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Image.asset(
//                     data["icon"],
//                     height: 20.0,
//                     color: controller.isInnerSelected(innerIndex)
//                         ? Themes.kPrimaryColor
//                         : Themes.kDarkColor,
//                   ),
//                   // if (ResponsiveHelper.isDesktop(context))
//                   if (controller.isHideDrawerMenu.value)
//                     Row(
//                       children: [
//                         const SizedBox(width: 14.0),
//                         Text(
//                           data["title"],
//                           style: TextStyle(
//                             fontSize:
//                                 ResponsiveHelper.getFontSize(context, 14.0),
//                             fontWeight: controller.isInnerSelected(innerIndex)
//                                 ? FontWeight.w900
//                                 : FontWeight.w600,
//                             color: controller.isInnerSelected(innerIndex)
//                                 ? Themes.kPrimaryColor
//                                 : Themes.kDarkColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//               if (isMainItem) // Show arrow only for main items
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16.0),
//                   child: AnimatedRotation(
//                     duration: const Duration(milliseconds: 200),
//                     turns: isExpanded
//                         ? 0.5
//                         : 0.0, // Rotates 180 degrees when expanded
//                     child: const Icon(
//                       Icons.keyboard_arrow_down,
//                       color: Themes.kDarkColor,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget innerMenuInnerItems(
//       String parentTitle, BuildContext context, Size size) {
//     dynamic innerItems;
//     int startIndex;

//     switch (parentTitle) {
//       case "Regular":
//         innerItems = DummyData.posDrawerItems;
//         startIndex = 10; // Base index for regular items
//         break;
//       case "Restaurant":
//         innerItems = DummyData.restaurantDrawerItems;
//         startIndex = 20; // Base index for restaurant items
//         break;
//       case "Fast Food":
//         innerItems = DummyData.fastFoodDrawerItems;
//         startIndex = 30; // Base index for fast food items
//         break;
//       case "Super Market":
//         innerItems = DummyData.superMarketDrawerItems;
//         startIndex = 40; // Base index for supermarket items
//         break;
//       case "Online Store":
//         innerItems = DummyData.onlineStoreDrawerItems;
//         startIndex = 50; // Base index for online store items
//         break;
//       default:
//         return const SizedBox.shrink();
//     }

//     return Column(
//       children: List.generate(
//         innerItems.length,
//         (index) {
//           var innerData = innerItems[index];
//           int itemIndex = (startIndex + innerItems.indexOf(innerData)).toInt();
//           return Padding(
//             padding: const EdgeInsets.only(left: 0.0),
//             child: innerItemView(innerData, itemIndex, context, size),
//           );
//         },
//       ),
//     );
//   }

//   Widget logoutItem(String title, String icon, Size size) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click, // Changes cursor to hand
//       child: GestureDetector(
//         onTap: () {
//           if (title == "Logout") {
//             controller.onLogoutTapped(context, authController);
//           } else {
//             controller.onMenuTapped(
//                 context, size, title, authController, tablesController);
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0),
//           child: Row(
//             children: [
//               Image.asset(
//                 icon,
//                 height: 20.0,
//                 color: Themes.kDarkColor,
//               ),
//               if (controller.isHideDrawerMenu.value)
//                 Row(
//                   children: [
//                     const SizedBox(width: 14.0),
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: ResponsiveHelper.getFontSize(context, 14.0),
//                         fontWeight: FontWeight.w600,
//                         color: Themes.kDarkColor,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import 'package:kedasrd_windows/utils/images.dart';
// import 'package:kedasrd_windows/utils/themes.dart';
// import 'package:kedasrd_windows/utils/constants.dart';
// import 'package:kedasrd_windows/utils/dummy_data.dart';
// import 'package:kedasrd_windows/utils/responsive_helper.dart';

// import 'package:kedasrd_windows/controllers/drawer_controller.dart';
// import 'package:kedasrd_windows/controllers/tables_controller.dart';
// import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

// class DrawerView extends StatefulWidget {
//   const DrawerView({
//     super.key,
//   });

//   @override
//   State<DrawerView> createState() => _DrawerViewState();
// }

// class _DrawerViewState extends State<DrawerView> {
//   final DrawerMenuController controller = Get.find<DrawerMenuController>();
//   final TablesController tablesController = Get.find<TablesController>();
//   final AuthController authController = Get.find<AuthController>();

//   // Track hover states for each menu item
//   final Map<String, RxBool> _isHovering = {};

//   @override
//   void initState() {
//     super.initState();
//     // Initialize hover states for all menu items
//     for (var item in DummyData.dashboardList) {
//       _isHovering[item["title"]] = false.obs;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Obx(
//       () => Container(
//         width: !controller.isHideDrawerMenu.value
//             ? 74.0
//             : ResponsiveHelper.getDrawerWidth(context),
//         color: Themes.kWhiteColor,
//         child: Column(
//           children: [
//             Expanded(
//               child: Constants.scrollbarView(
//                 paddingRight: 0.0,
//                 child: SingleChildScrollView(
//                   child: mainMenuList(context, size),
//                 ),
//               ),
//             ),
//             logoutItem(
//               "Setting",
//               Images.setting,
//               size,
//             ),
//             logoutItem(
//               "Logout",
//               Images.logout,
//               size,
//             ),
//             const SizedBox(height: 24.0)
//           ],
//         ),
//       ),
//     );
//   }

//   Widget mainMenuList(BuildContext context, Size size) {
//     return Container(
//       margin: const EdgeInsets.only(left: 24.0, top: 16.0),
//       child: Column(
//         children: List.generate(
//           DummyData.dashboardList.length,
//           (index) {
//             var data = DummyData.dashboardList[index];
//             return buildHoverableMenuItem(data, index, context, size);
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildHoverableMenuItem(
//       data, int index, BuildContext context, Size size) {
//     String itemTitle = data["title"];

//     return MouseRegion(
//       onEnter: (_) => _isHovering[itemTitle]?.value = true,
//       onExit: (_) => _isHovering[itemTitle]?.value = false,
//       child: Obx(() {
//         bool isHovering = _isHovering[itemTitle]?.value ?? false;

//         return Stack(
//           clipBehavior: Clip.none, // Important to let the submenu overflow
//           children: [
//             // Main menu item
//             menuItem(data, index, context, size),

//             // Submenu on hover
//             if (isHovering && controller.isHideDrawerMenu.value)
//               Positioned(
//                 left: ResponsiveHelper.getDrawerWidth(context) -
//                     48, // Position at the edge of drawer
//                 top: 0,
//                 child: submenuOverlay(itemTitle, context, size),
//               ),
//           ],
//         );
//       }),
//     );
//   }

//   Widget menuItem(data, int index, BuildContext context, Size size) {
//     return GestureDetector(
//       onTap: () => controller.onMenuInnerItemTapped(
//           context, size, data["title"], authController, tablesController),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   data["icon"],
//                   height: 20.0,
//                   color: controller.isInnerSelected(index)
//                       ? Themes.kPrimaryColor
//                       : Themes.kDarkColor,
//                 ),
//                 if (controller.isHideDrawerMenu.value)
//                   Row(
//                     children: [
//                       const SizedBox(width: 14.0),
//                       Text(
//                         data["title"],
//                         style: TextStyle(
//                           fontSize: ResponsiveHelper.getFontSize(context, 14.0),
//                           fontWeight: controller.isInnerSelected(index)
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           color: controller.isInnerSelected(index)
//                               ? Themes.kPrimaryColor
//                               : Themes.kDarkColor,
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             if (controller.isHideDrawerMenu.value)
//               Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 14,
//                   color: Themes.kDarkColor.withOpacity(0.7),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget submenuOverlay(String parentTitle, BuildContext context, Size size) {
//     // Determine which submenu to show based on parent title
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

//     // Create a MouseRegion to keep submenu open when hovering over it
//     return MouseRegion(
//       onEnter: (_) => _isHovering[parentTitle]?.value = true,
//       onExit: (_) => _isHovering[parentTitle]?.value = false,
//       child: Material(
//         elevation: 6,
//         shadowColor: Colors.black.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(4),
//         child: Container(
//           width: 230,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Submenu header
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Themes.kPrimaryColor.withOpacity(0.05),
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

//               // Line separator
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: Colors.grey.withOpacity(0.15),
//               ),

//               // Submenu items
//               ...List.generate(
//                 submenuItems.length,
//                 (index) {
//                   var item = submenuItems[index];
//                   int itemIndex = startIndex + index;
//                   return buildSubmenuItem(item, itemIndex, context, size);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSubmenuItem(data, int index, BuildContext context, Size size) {
//     return GestureDetector(
//       onTap: () => controller.onMenuInnerItemTapped(
//           context, size, data["title"], authController, tablesController),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: controller.isInnerSelected(index)
//               ? Themes.kPrimaryColor.withOpacity(0.05)
//               : Colors.transparent,
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey.withOpacity(0.15),
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
//                   fontSize: ResponsiveHelper.getFontSize(context, 13.0),
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

//   Widget logoutItem(String title, String icon, Size size) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: () {
//           if (title == "Logout") {
//             controller.onLogoutTapped(context, authController);
//           } else {
//             controller.onMenuTapped(
//                 context, size, title, authController, tablesController);
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0),
//           child: Row(
//             children: [
//               Image.asset(
//                 icon,
//                 height: 20.0,
//                 color: Themes.kDarkColor,
//               ),
//               if (controller.isHideDrawerMenu.value)
//                 Row(
//                   children: [
//                     const SizedBox(width: 14.0),
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: ResponsiveHelper.getFontSize(context, 14.0),
//                         fontWeight: FontWeight.w600,
//                         color: Themes.kDarkColor,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import 'package:kedasrd_windows/utils/images.dart';
// import 'package:kedasrd_windows/utils/themes.dart';
// import 'package:kedasrd_windows/utils/constants.dart';
// import 'package:kedasrd_windows/utils/dummy_data.dart';
// import 'package:kedasrd_windows/utils/responsive_helper.dart';

// import 'package:kedasrd_windows/controllers/drawer_controller.dart';
// import 'package:kedasrd_windows/controllers/tables_controller.dart';
// import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

// class DrawerView extends StatefulWidget {
//   const DrawerView({
//     super.key,
//   });

//   @override
//   State<DrawerView> createState() => _DrawerViewState();
// }

// class _DrawerViewState extends State<DrawerView> {
//   final DrawerMenuController controller = Get.find<DrawerMenuController>();
//   final TablesController tablesController = Get.find<TablesController>();
//   final AuthController authController = Get.find<AuthController>();

//   // Track hover states for each menu item
//   final Map<String, RxBool> _isHovering = {};

//   @override
//   void initState() {
//     super.initState();
//     // Initialize hover states for all menu items
//     for (var item in DummyData.dashboardList) {
//       _isHovering[item["title"]] = false.obs;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // Main drawer content
//         Obx(
//           () => Container(
//             width: !controller.isHideDrawerMenu.value
//                 ? 74.0
//                 : ResponsiveHelper.getDrawerWidth(context),
//             color: Themes.kWhiteColor,
//             child: Column(
//               children: [
//                 Expanded(
//                   child: Constants.scrollbarView(
//                     paddingRight: 0.0,
//                     child: SingleChildScrollView(
//                       child: mainMenuList(context, size),
//                     ),
//                   ),
//                 ),
//                 logoutItem(
//                   "Setting",
//                   Images.setting,
//                   size,
//                 ),
//                 logoutItem(
//                   "Logout",
//                   Images.logout,
//                   size,
//                 ),
//                 const SizedBox(height: 24.0)
//               ],
//             ),
//           ),
//         ),

//         // Overlay submenus that appear on top of body content
//         ...DummyData.dashboardList.map((data) {
//           String itemTitle = data["title"];
//           return Obx(() {
//             bool isHovering = _isHovering[itemTitle]?.value ?? false;
//             if (!isHovering || !controller.isHideDrawerMenu.value)
//               return const SizedBox.shrink();

//             // Find the global position of the menu item to position the submenu properly
//             final RenderBox? renderBox =
//                 context.findRenderObject() as RenderBox?;
//             if (renderBox == null) return const SizedBox.shrink();

//             // Position the submenu at the right edge of the drawer
//             return Positioned(
//               left: ResponsiveHelper.getDrawerWidth(context) - 24,
//               // We'll use a fixed position for each menu item based on index
//               top: 16.0 + DummyData.dashboardList.indexOf(data) * 44.0,
//               child: submenuOverlay(itemTitle, context, size),
//             );
//           });
//         }).toList(),
//       ],
//     );
//   }

//   Widget mainMenuList(BuildContext context, Size size) {
//     return Container(
//       margin: const EdgeInsets.only(left: 24.0, top: 16.0),
//       child: Column(
//         children: List.generate(
//           DummyData.dashboardList.length,
//           (index) {
//             var data = DummyData.dashboardList[index];
//             return buildHoverableMenuItem(data, index, context, size);
//           },
//         ),
//       ),
//     );
//   }

//   Widget buildHoverableMenuItem(
//       data, int index, BuildContext context, Size size) {
//     String itemTitle = data["title"];

//     return MouseRegion(
//       onEnter: (_) => _isHovering[itemTitle]?.value = true,
//       onExit: (_) => _isHovering[itemTitle]?.value = false,
//       child: menuItem(data, index, context, size),
//     );
//   }

//   Widget menuItem(data, int index, BuildContext context, Size size) {
//     return GestureDetector(
//       onTap: () => controller.onMenuInnerItemTapped(
//           context, size, data["title"], authController, tablesController),
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   data["icon"],
//                   height: 20.0,
//                   color: controller.isInnerSelected(index)
//                       ? Themes.kPrimaryColor
//                       : Themes.kDarkColor,
//                 ),
//                 if (controller.isHideDrawerMenu.value)
//                   Row(
//                     children: [
//                       const SizedBox(width: 14.0),
//                       Text(
//                         data["title"],
//                         style: TextStyle(
//                           fontSize: ResponsiveHelper.getFontSize(context, 14.0),
//                           fontWeight: controller.isInnerSelected(index)
//                               ? FontWeight.w700
//                               : FontWeight.w600,
//                           color: controller.isInnerSelected(index)
//                               ? Themes.kPrimaryColor
//                               : Themes.kDarkColor,
//                         ),
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//             if (controller.isHideDrawerMenu.value)
//               Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 14,
//                   color: Themes.kDarkColor.withOpacity(0.7),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget submenuOverlay(String parentTitle, BuildContext context, Size size) {
//     // Determine which submenu to show based on parent title
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

//     // Create a MouseRegion to keep submenu open when hovering over it
//     return MouseRegion(
//       onEnter: (_) => _isHovering[parentTitle]?.value = true,
//       onExit: (_) => _isHovering[parentTitle]?.value = false,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height *
//               0.7, // Limit height to 70% of screen
//         ),
//         child: Material(
//           elevation: 20, // Increased elevation to appear above body content
//           shadowColor: Colors.black.withOpacity(0.5),
//           borderRadius: BorderRadius.circular(4),
//           child: Container(
//             width: 250,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(color: Colors.grey.withOpacity(0.2)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Submenu header
//                 Container(
//                   width: double.infinity,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   decoration: BoxDecoration(
//                     color: Themes.kPrimaryColor.withOpacity(0.1),
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(4),
//                       topRight: Radius.circular(4),
//                     ),
//                   ),
//                   child: Text(
//                     parentTitle,
//                     style: TextStyle(
//                       fontSize: ResponsiveHelper.getFontSize(context, 14),
//                       fontWeight: FontWeight.bold,
//                       color: Themes.kPrimaryColor,
//                     ),
//                   ),
//                 ),

//                 // Line separator
//                 Divider(
//                   height: 1,
//                   thickness: 1,
//                   color: Colors.grey.withOpacity(0.15),
//                 ),

//                 // Scrollable container for submenu items if there are many
//                 Flexible(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: List.generate(
//                         submenuItems.length,
//                         (index) {
//                           var item = submenuItems[index];
//                           int itemIndex = startIndex + index;
//                           return buildSubmenuItem(
//                               item, itemIndex, context, size);
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildSubmenuItem(data, int index, BuildContext context, Size size) {
//     return GestureDetector(
//       onTap: () => controller.onMenuInnerItemTapped(
//           context, size, data["title"], authController, tablesController),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: controller.isInnerSelected(index)
//               ? Themes.kPrimaryColor.withOpacity(0.05)
//               : Colors.transparent,
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey.withOpacity(0.15),
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
//                   fontSize: ResponsiveHelper.getFontSize(context, 13.0),
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

//   Widget logoutItem(String title, String icon, Size size) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       child: GestureDetector(
//         onTap: () {
//           if (title == "Logout") {
//             controller.onLogoutTapped(context, authController);
//           } else {
//             controller.onMenuTapped(
//                 context, size, title, authController, tablesController);
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0),
//           child: Row(
//             children: [
//               Image.asset(
//                 icon,
//                 height: 20.0,
//                 color: Themes.kDarkColor,
//               ),
//               if (controller.isHideDrawerMenu.value)
//                 Row(
//                   children: [
//                     const SizedBox(width: 14.0),
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: ResponsiveHelper.getFontSize(context, 14.0),
//                         fontWeight: FontWeight.w600,
//                         color: Themes.kDarkColor,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
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
import 'package:kedasrd_windows/utils/dummy_data.dart';
import 'package:kedasrd_windows/utils/responsive_helper.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';

class DrawerView extends StatefulWidget {
  final Function(String)? onMenuHover;

  const DrawerView({
    super.key,
    this.onMenuHover,
  });

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final DrawerMenuController controller = Get.find<DrawerMenuController>();
  final TablesController tablesController = Get.find<TablesController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Obx(
      () => Container(
        width: !controller.isHideDrawerMenu.value
            ? 74.0
            : ResponsiveHelper.getDrawerWidth(context),
        color: Themes.kWhiteColor,
        child: Column(
          children: [
            Expanded(
              child: Constants.scrollbarView(
                paddingRight: 0.0,
                child: SingleChildScrollView(
                  child: mainMenuList(context, size),
                ),
              ),
            ),
            logoutItem(
              "Setting",
              Images.setting,
              size,
            ),
            logoutItem(
              "Logout",
              Images.logout,
              size,
            ),
            const SizedBox(height: 24.0)
          ],
        ),
      ),
    );
  }

  Widget mainMenuList(BuildContext context, Size size) {
    return Container(
      margin: const EdgeInsets.only(left: 24.0, top: 16.0),
      child: Column(
        children: List.generate(
          DummyData.dashboardList.length,
          (index) {
            var data = DummyData.dashboardList[index];
            return menuItem(data, index, context, size);
          },
        ),
      ),
    );
  }

  Widget menuItem(data, int index, BuildContext context, Size size) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Changes cursor to hand
      onEnter: (_) {
        if (widget.onMenuHover != null) {
          widget.onMenuHover!(data["title"]);
        }
      },
      onExit: (_) {
        // We don't clear the hover here because we want the submenu to stay open
        // when the mouse moves to it. The clearing will be handled by the submenu's onExit.
      },
      child: GestureDetector(
        onTap: () => controller.onMenuInnerItemTapped(
            context, size, data["title"], authController, tablesController),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child:
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              Row(
            children: [
              Image.asset(
                data["icon"],
                height: 20.0,
                color: controller.isInnerSelected(index)
                    ? Themes.kPrimaryColor
                    : Themes.kDarkColor,
              ),
              if (controller.isHideDrawerMenu.value)
                Row(
                  children: [
                    const SizedBox(width: 14.0),
                    Text(
                      data["title"],
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                        fontWeight: controller.isInnerSelected(index)
                            ? FontWeight.w700
                            : FontWeight.w600,
                        color: controller.isInnerSelected(index)
                            ? Themes.kPrimaryColor
                            : Themes.kDarkColor,
                      ),
                    ),
                  ],
                ),
              //   ],
              // ),
              // if (controller.isHideDrawerMenu.value)
              //   Padding(
              //     padding: const EdgeInsets.only(right: 16.0),
              //     child: Icon(
              //       Icons.arrow_forward_ios,
              //       size: 14,
              //       color: Themes.kDarkColor.withOpacity(0.7),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutItem(String title, String icon, Size size) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (title == "Logout") {
            controller.onLogoutTapped(context, authController);
          } else {
            controller.onMenuTapped(
                context, size, title, authController, tablesController);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0),
          child: Row(
            children: [
              Image.asset(
                icon,
                height: 20.0,
                color: Themes.kDarkColor,
              ),
              if (controller.isHideDrawerMenu.value)
                Row(
                  children: [
                    const SizedBox(width: 14.0),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getFontSize(context, 14.0),
                        fontWeight: FontWeight.w600,
                        color: Themes.kDarkColor,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
