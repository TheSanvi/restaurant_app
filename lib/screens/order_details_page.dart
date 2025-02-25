import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'order_confirmed_page.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            tween: Tween(begin: 1.0, end: 0.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 50 * value),
                child: child,
              );
            },
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Text(
                            'Order Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ID-219',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE135),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'T2',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Consumer<CartModel>(
                        builder: (context, cart, child) {
                          if (cart.items.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Your cart is empty',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              final item = cart.items[index];

                              return ListTile(
                                title: Text(item.item.name),
                                subtitle: Text(
                                  "${item.quantity}x ${item.customizationString}",
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        cart.decreaseQuantity(item);
                                      },
                                    ),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        cart.increaseQuantity(item);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        cart.removeItem(item);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Consumer<CartModel>(
                        builder: (context, cart, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '₹${cart.total.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: cart.items.isNotEmpty
                                    ? () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => const OrderConfirmedPage(),
                                  );
                                }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFE135),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Confirm Order',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
