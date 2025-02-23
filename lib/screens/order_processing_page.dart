import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'order_more_page.dart';

class OrderProcessingPage extends StatefulWidget {
  const OrderProcessingPage({Key? key}) : super(key: key);

  @override
  State<OrderProcessingPage> createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade animation for text
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: const Interval(0.3, 1.0),
    ));

    // Start animations
    _fadeController.forward();

    // Navigate to OrderMorePage after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FadeTransition(
                  opacity: animation,
                  child: OrderMorePage(),
                ),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFFE135),
      elevation: 0,
      child: Container(
        width: 1000,
        height: 1000,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation with increased size
            SizedBox(
              width: 300,
              height: 250,
              child: Lottie.asset(
                'assests/Animation - 1740193965325.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            // Animated Text
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Column(
                children: [
                  Text(
                    'Processing Your Order',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please wait while we prepare your delicious meal!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
