import 'package:flutter/foundation.dart';
import 'menu_item.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get subtotal => _items.fold(0, (total, item) => total + (item.price * item.quantity));

  double get tax => subtotal * 0.18; // 18% GST

  double get total => subtotal + tax;

  void addToCart(MenuItem item, Map<String, dynamic> customizations, int quantity) {
    final cartItem = CartItem(
      item: item,
      customizations: customizations,
      quantity: quantity,
    );
    _items.add(cartItem);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class CartItem {
  final MenuItem item;
  final Map<String, dynamic> customizations;
  final int quantity;

  CartItem({
    required this.item,
    required this.customizations,
    required this.quantity,
  });

  double get price => item.price * quantity;
}