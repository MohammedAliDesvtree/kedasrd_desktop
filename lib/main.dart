import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/load_images.dart';

import 'package:kedasrd_windows/views/landing_view.dart';
import 'package:kedasrd_windows/views/online_order/online_order_view.dart';

import 'package:kedasrd_windows/controllers/cart_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/drawer_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await preLoadAllImages();

  Get.put(DrawerMenuController());
  Get.put(TablesController());
  Get.put(CartController());

  if (Constants.isWindows || Constants.isMacOS) {
    setWindowSizeLimits();
  }

  runApp(const MyApp());
}

void setWindowSizeLimits() async {
  await windowManager.ensureInitialized();
  // final size = await windowManager.getSize();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
    // MacOS
    size: Size(1920, 990),
    minimumSize: Size(1920, 990),
    maximumSize: Size.infinite,
    // Windows
    // size: Size(1920, 990),
    // minimumSize: Size(1920, 990),
    // maximumSize: Size.infinite,
    // Dynamic
    // size: Size(1372, 732),
    // minimumSize: Size(1372, 732),
    // maximumSize: Size(1372, 732),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setResizable(false);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kedasrd',
      theme: ThemeData(
        fontFamily: "Outfit",
        colorScheme: ColorScheme.fromSeed(seedColor: Themes.kPrimaryColor),
        useMaterial3: true,
      ),
      initialRoute: '/landing',
      getPages: [
        // Landing
        GetPage(name: '/landing', page: () => const LandingView()),
        GetPage(name: '/online_order', page: () => const OnlineOrderView()),
      ],
    );
  }
}
