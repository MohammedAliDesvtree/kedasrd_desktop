import 'package:get/get.dart';

class CartItem {
  final int id;
  final String title;
  final String image;
  final double price;
  RxInt quantity;
  RxDouble itemTotal;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required int initialQuantity,
  })  : quantity = initialQuantity.obs,
        itemTotal = (price * initialQuantity).obs;
}
