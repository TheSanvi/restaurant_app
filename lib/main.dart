import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'screens/menu_page.dart';
import 'screens/customization_page.dart';
import 'screens/order_details_page.dart';
import 'screens/order_confirmed_page.dart';
import 'screens/order_processing_page.dart';
import 'screens/order_more_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.amber[50],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuPage(),
        '/customization': (context) => const CustomizationPage(),
        '/order-details': (context) => const OrderDetailsPage(),
        '/order-confirmed': (context) => const OrderConfirmedPage(),
        '/order-processing': (context) => const OrderProcessingPage(),
        '/order-more': (context) => const OrderMorePage(),
      },
    );
  }
}
