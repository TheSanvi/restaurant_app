import 'package:flutter/foundation.dart';
import 'menu_item.dart';

class OrderModel extends ChangeNotifier {
  final List<OrderItem> _items;

  OrderModel({required List<OrderItem> items}) : _items = List<OrderItem>.from(items);

  List<OrderItem> get items => _items;

  double get subtotal => _items.fold(0, (total, item) => total + item.totalPrice);

  double get total => subtotal; // No tax, just subtotal

  void addItem(OrderItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(OrderItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearOrder() {
    _items.clear();
    notifyListeners();
  }
}

class OrderItem {
  final MenuItem item;
  final Map<String, dynamic> customizations;
  final int quantity;

  OrderItem({
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
