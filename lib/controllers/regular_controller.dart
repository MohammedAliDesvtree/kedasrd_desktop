import 'package:get/get.dart';

class RegularController extends GetxController {
  RxBool isSearchVisible = false.obs;

  final RxInt expandedIndex = RxInt(-1);

  void toggleItemExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1;
    } else {
      expandedIndex.value = index;
    }
  }
}
