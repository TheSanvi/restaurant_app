import 'package:flutter/material.dart';

class OrderProcessingPage extends StatelessWidget {
  const OrderProcessingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber[50],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant,
                size: 64,
                color: Colors.amber[700],
              ),
              const SizedBox(height: 24),
              const Text(
                'Feel free to order more while your\nfood is being prepared!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/order-more');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: const Text('Order More'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}