import 'package:flutter/material.dart';
import 'menu_page.dart';

class OrderProcessingPage extends StatelessWidget {
  const OrderProcessingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'Feel free to order more while\nyour food is being prepared!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuPage(),
                  ),
                      (route) => false,
                );
              },
              child: const Text('Order More'),
            ),
          ],
        ),
      ),
    );
  }
}