import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymint/Models/product_model.dart';

class CartItem {
  final Products product;
  RxInt quantity;

  CartItem({required this.product, required this.quantity});
  // CartItem({required this.product, required int initialQuantity})
  // : quantity = initialQuantity.obs;
}

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  void addToCart(Products product) {
    var existingItem = cartItems.firstWhere(
      (item) => item.product.id == product.id,
      //orElse: () => CartItem(product: product, initialQuantity: 0),
      orElse: () => CartItem(product: product, quantity: 0.obs),
    );

    existingItem.quantity++;
    Get.snackbar("Items Added Successfully", "${product.name}",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.green,
        backgroundColor: Colors.green.shade50,
        duration: Duration(seconds: 1));

    if (!cartItems.contains(existingItem)) {
      cartItems.add(existingItem);
      //print("object");
      // Get.snackbar("Items Added Successfully", "${product.name}",
      //     snackPosition: SnackPosition.BOTTOM,
      //     colorText: Colors.green,
      //     backgroundColor: Colors.green.shade50);
    }
  }

  void removeFromCart(CartItem item) {
    item.quantity--;

    if (item.quantity <= 0) {
      cartItems.remove(item);
    }
  }

  // double get totalPrice {
  //   return cartItems.fold(
  //       0, (sum, item) => sum + item.quantity * double.parse(item.product.sp));
  // }
  double get totalPrice {
  double sum = cartItems.fold(0, (sum, item) => sum + item.quantity * double.parse(item.product.sp));
  return double.parse(sum.toStringAsFixed(2));
}

}
