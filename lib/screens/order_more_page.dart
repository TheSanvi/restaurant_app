import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'order_bill_page.dart';

class OrderMorePage extends StatelessWidget {
  const OrderMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.only(bottom: 16), // Fix for bottom cutting issue
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            Expanded(
              child: cart.items.isEmpty
                  ? _buildEmptyCart()
                  : _buildCartList(cart),
            ),
            _buildBottomSection(context, cart),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'To repeat/new item click the button below',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.shopping_bag_outlined, size: 48, color: Colors.grey[600]),
          const SizedBox(height: 8),
          Text(
            'No item in your Cart',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(CartModel cart) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        final cartItem = cart.items[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ListTile(
            leading: Image.network(
              cartItem.item.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(cartItem.item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(
              'Qty: ${cartItem.quantity} | Price: ₹${cartItem.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSection(BuildContext context, CartModel cart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text(
                  '₹${cart.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE135),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Add New Item/Repeat', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(opacity: animation, child: const OrderBillPage()),
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE135),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Proceed to Pay', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
