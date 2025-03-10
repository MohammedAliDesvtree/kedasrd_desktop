import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:window_manager/window_manager.dart';

import 'package:kedasrd_windows/utils/themes.dart';
import 'package:kedasrd_windows/utils/constants.dart';
import 'package:kedasrd_windows/utils/load_images.dart';

import 'package:kedasrd_windows/views/landing_view.dart';
import 'package:kedasrd_windows/views/auth/sign_in_view.dart';

import 'package:kedasrd_windows/controllers/cart_controller.dart';
import 'package:kedasrd_windows/controllers/common_controller.dart';
import 'package:kedasrd_windows/controllers/tables_controller.dart';
import 'package:kedasrd_windows/controllers/drawer_controller.dart';
import 'package:kedasrd_windows/controllers/kitchen_controller.dart';
import 'package:kedasrd_windows/controllers/auth/auth_controller.dart';
import 'package:kedasrd_windows/controllers/auth/sign_in_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Constants.isWindows || Constants.isMacOS) {
    setWindowSizeLimits();
  }

  await preLoadAllImages();
  await GetStorage.init();

  // Initialize AuthController first
  Get.put(AuthController(), permanent: true);

  Get.put(SignInController());
  Get.put(CommonController());
  Get.put(DrawerMenuController());
  Get.put(TablesController());
  Get.put(CartController());
  Get.put(KitchenController());

  runApp(const MyApp());
}

void setWindowSizeLimits() async {
  await windowManager.ensureInitialized();
  // final size = await windowManager.getSize();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    // Minimum size that works well for tablets
    size: Size(1280, 680),
    minimumSize: Size(800, 600),
    // Allow window to be maximized
    // maximumSize: Size.infinite,
    // MacOS
    // size: Size(1920, 990),
    // minimumSize: Size(1920, 990),
    // maximumSize: Size.infinite,
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
    // await windowManager.setSize(size);
    await windowManager.focus();
    // Center window
    await windowManager.center();
    // Maximize window
    await windowManager.maximize();
    // Allow resizing for better responsiveness
    await windowManager.setResizable(true);
    await windowManager.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final initialRoute =
        authController.checkLoginStatus() ? "/landing" : "/signin";

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kedasrd',
      theme: ThemeData(
        fontFamily: "Outfit",
        colorScheme: ColorScheme.fromSeed(seedColor: Themes.kPrimaryColor),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/signin', page: () => const SignInView()),
        // Landing
        GetPage(name: '/landing', page: () => const LandingView()),
      ],
    );
  }
}
