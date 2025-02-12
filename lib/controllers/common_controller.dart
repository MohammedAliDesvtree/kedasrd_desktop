import 'package:get/get.dart';

class CommonController extends GetxController {
  RxBool isLocationAllow = false.obs;

  void locationAllowed() {
    isLocationAllow.value = !isLocationAllow.value;
  }
}
