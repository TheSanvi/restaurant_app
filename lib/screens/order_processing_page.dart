import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'order_more_page.dart';

class OrderProcessingPage extends StatefulWidget {
  const OrderProcessingPage({Key? key}) : super(key: key);

  @override
  State<OrderProcessingPage> createState() => _OrderProcessingPageState();
}

class _OrderProcessingPageState extends State<OrderProcessingPage>
    with TickerProviderStateMixin {
  late AnimationController _bowlController;
  late AnimationController _chopsticksController;

  @override
  void initState() {
    super.initState();

    // Bowl rotation animation
    _bowlController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Chopsticks animation
    _chopsticksController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    // Navigate to OrderMorePage after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FadeTransition(
                  opacity: animation,
                  child: const OrderMorePage(),
                ),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _bowlController.dispose();
    _chopsticksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFFFFE135),
      elevation: 0,
      child: Container(
        width: 400,
        height: 300,
        padding: const EdgeInsets.all(24),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Animated Bowl
            AnimatedBuilder(
              animation: _bowlController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _bowlController.value * 2 * math.pi,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Bowl
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        // Chopsticks
                        AnimatedBuilder(
                          animation: _chopsticksController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _chopsticksController.value * 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                    angle: -math.pi / 6,
                                    child: Container(
                                      width: 4,
                                      height: 60,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Transform.rotate(
                                    angle: math.pi / 6,
                                    child: Container(
                                      width: 4,
                                      height: 60,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}