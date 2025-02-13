import 'package:get/get.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class CommonController extends GetxController {
  RxBool isLocationAllow = false.obs;
  RxBool isEntryLog = true.obs;

  void locationAllowed() {
    isLocationAllow.value = !isLocationAllow.value;
  }

  void updateView(dynamic drawerMenuController) {
    if (isEntryLog.value) {
      isEntryLog.value = false;
    } else {
      isEntryLog.value = true;
      Get.back();
      drawerMenuController.navigateTo(Screen.restaurant, "Restaurant");
    }
  }
}
