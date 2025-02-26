import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/screens/menu_page.dart'; // Correct import path

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool isPaymentCompleted = false;

  void _showPaymentSuccessAnimation() {
    setState(() {
      isPaymentCompleted = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 400,
        height: isPaymentCompleted ? 350 : 500,
        padding: const EdgeInsets.all(24),
        child: isPaymentCompleted
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              decoration: BoxDecoration(
                color: Colors.yellow[700], // Yellow Background
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Lottie.asset(
                  'assests/Animation - 1740193194310.json',
                  width: 150,
                  repeat: false,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        )
            : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with back button
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Scan the code to pay',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 16),

              // QR Code area
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.qr_code,
                    size: 100,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Payment Instructions
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. Open your UPI app'),
                    Text('2. Scan the QR code'),
                    Text('3. Complete the payment'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Payment Completed Button
              ElevatedButton(
                onPressed: _showPaymentSuccessAnimation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 24),
                ),
                child: const Text(
                  'Payment Completed',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 16),

              // Expiry Timer
              Column(
                children: [
                  const Text(
                    'This page will automatically expire in 10 minutes',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: 0.5, // Dummy progress, should be updated dynamically
                    backgroundColor: Colors.grey[300],
                    color: Colors.yellow[700],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
