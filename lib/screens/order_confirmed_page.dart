import 'package:flutter/material.dart';
import 'order_processing_page.dart';

class OrderConfirmedPage extends StatefulWidget {
  const OrderConfirmedPage({Key? key}) : super(key: key);

  @override
  _OrderConfirmedPageState createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderProcessingPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/order_confirmed.png',
              height: 120,
            ),
            const SizedBox(height: 24),
            const Text(
              'Your Order is Confirmed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}