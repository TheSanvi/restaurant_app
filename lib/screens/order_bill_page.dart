import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'payment_method_page.dart';

class OrderBillPage extends StatelessWidget {
  const OrderBillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'ID-219',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE135),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'T2',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'November 07, 2024',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '11:20 am',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Invoice Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invoice #219',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Bill Summary',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Order Items
                    Consumer<CartModel>(
                      builder: (context, cart, child) {
                        if (cart.items.isEmpty) {
                          return Center(
                            child: Text(
                              'No items in cart',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return Column(
                          children: [
                            ...cart.items.map((item) => Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[200]!,
                                  ),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.item.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '×${item.quantity}',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                        if (item.customizationString.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              item.customizationString,
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${item.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )).toList(),

                            const SizedBox(height: 24),

                            // Bill Details
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  _buildBillRow('Item Total', cart.subtotal),
                                  const SizedBox(height: 8),
                                  _buildBillRow(
                                    'GST and Restaurant charges',
                                    cart.tax,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Divider(),
                                  ),
                                  _buildBillRow(
                                    'Grand Total',
                                    cart.total,
                                    isTotal: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Confirm Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                              opacity: animation,
                              child: const PaymentMethodPage(),
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE135),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey[600],
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}