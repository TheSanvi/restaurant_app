import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/cashier_screen.dart';
import 'scanner_page.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 600,
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Choose your payment method',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24), // For alignment
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Methods
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildPaymentOption(
                    'FacePae (Coming Soon)',
                    'Pay with your Face',
                    value: 'facepae',
                    backgroundColor: Colors.black,
                    disableSelection: true, // Disabled selection
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    'UPI Scan Code',
                    'Pay using QR',
                    value: 'upi',
                    backgroundColor: const Color(0xFFFFE135),
                    icon: Icons.qr_code,
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentOption(
                    'Pay at Restaurant',
                    'Cash/Card',
                    value: 'cash',
                    backgroundColor: const Color(0xFFFFE135),
                    icon: Icons.payment,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: selectedMethod != null
                    ? () {
                  if (selectedMethod == 'upi') {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                              opacity: animation,
                              child: const ScannerPage(), // UPI ke liye ScannerPage
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  } else if (selectedMethod == 'cash') {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            FadeTransition(
                              opacity: animation,
                              child: const CashierScreen(), // Cash ke liye CashierScreen
                            ),
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                  }
                }
                    : null,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE135),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  disabledBackgroundColor: Colors.grey[300],
                ),
                child: const Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      String title,
      String subtitle, {
        required String value,
        required Color backgroundColor,
        IconData? icon,
        bool disableSelection = false,
      }) {
    final isSelected = selectedMethod == value;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? (disableSelection ? Colors.transparent : Colors.black)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disableSelection
              ? null
              : () {
            setState(() {
              selectedMethod = value;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: value == 'facepae'
                      ? const Image(image: AssetImage('assests/facepae.jpg'))
                      : Icon(
                    icon,
                    size: 28,
                    color: backgroundColor == Colors.black
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20, // Increased font size
                          fontWeight: FontWeight.bold,
                          color: backgroundColor == Colors.black
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16, // Increased font size
                          color: backgroundColor == Colors.black
                              ? Colors.white70
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!disableSelection)
                  Radio<String>(
                    value: value,
                    groupValue: selectedMethod,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMethod = newValue;
                      });
                    },
                    activeColor: Colors.black,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
