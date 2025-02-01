import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../widgets/menu_grid.dart';

class OrderMorePage extends StatelessWidget {
  const OrderMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order More')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'To repeat/new item click the button below',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return cart.items.isEmpty
                  ? Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.shopping_bag_outlined, size: 48, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No item in your Cart'),
                  ],
                ),
              )
                  : Expanded(child: MenuGrid());
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement parcel item logic
                    },
                    child: const Text('Parcel Item'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Add New Item/Repeat'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement proceed to pay logic
                    },
                    child: const Text('Proceed to Pay'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

