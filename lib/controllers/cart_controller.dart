import 'package:get/get.dart';

import 'package:kedasrd_windows/models/cart_item_model.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble total = 0.0.obs;
  RxDouble discountPercentage = 0.0.obs;

  void addToCart(Map<String, dynamic> product) {
    final existingItem =
        cartItems.firstWhereOrNull((item) => item.id == product['id']);

    if (existingItem != null) {
      existingItem.quantity++;
      existingItem.itemTotal.value =
          existingItem.price * existingItem.quantity.value;
    } else {
      cartItems.add(CartItem(
        id: product['id'],
        title: product['title'],
        image: product['image'],
        price: product['price'].toDouble(),
        initialQuantity: 1,
      ));
    }
    calculateTotals();
  }

  void removeFromCart(int id) {
    cartItems.removeWhere((item) => item.id == id);
    calculateTotals();
  }

  void updateQuantity(int id, bool increase) {
    final item = cartItems.firstWhere((item) => item.id == id);
    if (increase) {
      item.quantity++;
    } else if (item.quantity > 1) {
      item.quantity--;
    }
    item.itemTotal.value = item.price * item.quantity.value;
    calculateTotals();
  }

  void setDiscountPercentage(double percentage) {
    discountPercentage.value = percentage;
    calculateTotals();
  }

  void clearCart() {
    cartItems.clear();
    discountPercentage.value = 0;
    calculateTotals();
  }

  void calculateTotals() {
    subtotal.value =
        cartItems.fold(0, (sum, item) => sum + item.itemTotal.value);

    // Calculate discount
    discount.value = (subtotal.value * discountPercentage.value) / 100;

    // Calculate tax (assuming 15% tax rate)
    tax.value = (subtotal.value - discount.value) * 0.15;

    // Calculate total
    total.value = subtotal.value - discount.value + tax.value;
  }
}
