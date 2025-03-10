import 'dart:math';
import 'package:get/get.dart';

class KitchenController extends GetxController {
  // List of orders, each order is a list of item strings
  var orders = RxList<List<String>>(List.generate(16, (_) => []));

  @override
  void onInit() {
    super.onInit();
    generateOrders();
  }

  void generateOrders() {
    final random = Random();
    // Generate 8 orders, each with a random number of items (1 to 5)
    orders.value = List.generate(
        16,
        (_) => List.generate(
            random.nextInt(4) + 1, (_) => "Item ${Random().nextInt(100)}"));
  }
}
