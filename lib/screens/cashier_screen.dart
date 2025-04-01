import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'menu_page.dart';

class CashierScreen extends StatelessWidget {
  const CashierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MenuPage()),
            );
          },
        ),
        title: const Text("Cashier"),
        backgroundColor: Colors.yellow[700],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Prevents overflow issues
            padding: const EdgeInsets.all(16), // Adds spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Go to Cashier",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Lottie.asset(
                    'assests/Animation - 1743487521536.json', // Ensure the file is in assets
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 30), // Space between animation and button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MenuPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.yellow[700], // Text color for the button
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Back to Menu Page',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
