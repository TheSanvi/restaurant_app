import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/menu_page.dart';
 // Replace with the correct import path

class ScannerPage extends StatelessWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 400,
        height: 500,
        padding: const EdgeInsets.all(24),
        child: Column(
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
                const SizedBox(width: 40), // For alignment
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
              onPressed: () {
                // Navigate to the MenuPage after payment
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: const Text(
                'Payment Completed',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            const Spacer(),

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
    );
  }
}
