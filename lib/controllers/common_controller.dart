import 'package:get/get.dart';

import 'package:kedasrd_windows/controllers/drawer_controller.dart';

class CommonController extends GetxController {
  RxBool isLocationAllow = false.obs;
  RxBool isEntryLog = true.obs;
  // Instead of single RxInt
  RxList<int> qtyValues = <int>[].obs;

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

  // Initialize the list with default quantities (do this when you load your items)
  // For example, in your init method or when you get your data:
  void initQuantities(int itemCount) {
    qtyValues = List.generate(itemCount, (index) => 1).obs;
  }

  // Modified updateQuantity method
  void updateQuantity(int index, bool increase) {
    if (increase) {
      qtyValues[index]++;
    } else if (qtyValues[index] > 1) {
      qtyValues[index]--;
    }

    // Trigger update
    qtyValues.refresh();
  }

  // In your controller initialization or when data loads
  @override
  void onInit() {
    super.onInit();
    // Assuming you have a list of items with length itemCount
    initQuantities(12);
  }
}
