import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'order_processing_page.dart';

class OrderConfirmedPage extends StatefulWidget {
  const OrderConfirmedPage({Key? key}) : super(key: key);

  @override
  State<OrderConfirmedPage> createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage>
    with TickerProviderStateMixin {
  late AnimationController _notesController;
  late AnimationController _pencilController;
  late Animation<double> _pencilAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation for swaying notes
    _notesController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Animation for pencil drawing
    _pencilController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _pencilAnimation = Tween<double>(
      begin: -0.2,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pencilController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pencilController,
      curve: const Interval(0.5, 1.0),
    ));

    _pencilController.forward();

    // Navigate to OrderProcessingPage after animations complete
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FadeTransition(
                  opacity: animation,
                  child: const OrderProcessingPage(),
                ),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    _pencilController.dispose();
    super.dispose();
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
        height: 300,
        padding: const EdgeInsets.all(24),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // String Line
            Positioned(
              top: 40,
              left: -20,
              right: -20,
              child: Container(
                height: 2,
                color: Colors.brown[300],
              ),
            ),

            // Hanging Notes Animation
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      AnimatedBuilder(
                        animation: _notesController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: math.sin(_notesController.value * math.pi * 2 + i) * 0.05,
                            child: Container(
                              width: i == 1 ? 80 : 60,
                              height: i == 1 ? 100 : 80,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE135).withOpacity(0.9),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 4,
                                    color: Colors.black12,
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                  ),
                                  Container(
                                    width: 30,
                                    height: 4,
                                    color: Colors.black12,
                                    margin: const EdgeInsets.symmetric(vertical: 4),
                                  ),
                                  if (i == 1) ...[
                                    Container(
                                      width: 35,
                                      height: 4,
                                      color: Colors.black12,
                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),

            // Clips for String
            for (int i = 0; i < 3; i++)
              Positioned(
                top: 36,
                left: 120.0 + (i * 80),
                child: Container(
                  width: 16,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

            // Confirmation Text with Fade Animation
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Your Order is Confirmed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // Animated Pencil
            AnimatedBuilder(
              animation: _pencilAnimation,
              builder: (context, child) {
                return Positioned(
                  bottom: 40,
                  right: -50 + (_pencilAnimation.value * 150),
                  child: Transform.rotate(
                    angle: -math.pi / 4,
                    child: Container(
                      width: 120,
                      height: 20,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange[300]!,
                                    Colors.orange[400]!,
                                  ],
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink[100],
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 15,
                            decoration: const BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
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