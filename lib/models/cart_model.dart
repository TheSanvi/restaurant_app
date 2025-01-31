import 'package:flutter/foundation.dart';
import 'menu_item.dart';

class CartModel extends ChangeNotifier {
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice => _items.fold(0, (total, current) => total + current.price);

  void addToCart(MenuItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(MenuItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
