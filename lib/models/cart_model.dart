import 'package:flutter/foundation.dart';
import 'menu_item.dart';

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get subtotal => _items.fold(0, (total, item) => total + item.totalPrice);

  double get tax => subtotal * 0.05; // 5% GST

  double get total => double.parse((subtotal + tax).toStringAsFixed(3)); 

  void addToCart(MenuItem item, Map<String, dynamic> customizations, int quantity) {
    final existingItemIndex = _items.indexWhere((cartItem) =>
    cartItem.item == item && mapEquals(cartItem.customizations, customizations));

    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity += quantity;
    } else {
      _items.add(CartItem(item: item, customizations: customizations, quantity: quantity));
    }

    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeItem(CartItem item) {
    removeFromCart(item);
  }

  void increaseQuantity(CartItem item) {
    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(CartItem item) {
    final index = _items.indexOf(item);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index); // Remove item if quantity reaches 0
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

class CartItem {
  final MenuItem item;
  final Map<String, dynamic> customizations;
  int quantity; // Make quantity mutable

  CartItem({
    required this.item,
    required this.customizations,
    required this.quantity,
  });

  double get totalPrice => item.price * quantity;

  String get customizationString {
    List<String> customizationList = [];
    customizations.forEach((key, value) {
      if (value != null && value != false) {
        customizationList.add('$key: $value');
      }
    });
    return customizationList.join(', ');
  }
}
