import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CustomizationPage extends StatefulWidget {
  const CustomizationPage({Key? key}) : super(key: key);

  @override
  State<CustomizationPage> createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  String? selectedSize;
  String? selectedSpiceLevel;

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as MenuItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.amber[100],
      ),
      body: Container(
        color: Colors.amber[50],
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  if (item.customizationOptions?['size'] == true) ...[
                    const Text(
                      'Size',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RadioListTile(
                      title: const Text('Full'),
                      value: 'full',
                      groupValue: selectedSize,
                      onChanged: (value) => setState(() => selectedSize = value as String),
                    ),
                    RadioListTile(
                      title: const Text('Half'),
                      value: 'half',
                      groupValue: selectedSize,
                      onChanged: (value) => setState(() => selectedSize = value as String),
                    ),
                  ],
                  if (item.customizationOptions?['spiceLevel'] == true) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Spice Level',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    RadioListTile(
                      title: const Text('Less Spice'),
                      value: 'less',
                      groupValue: selectedSpiceLevel,
                      onChanged: (value) => setState(() => selectedSpiceLevel = value as String),
                    ),
                    RadioListTile(
                      title: const Text('More Spice'),
                      value: 'more',
                      groupValue: selectedSpiceLevel,
                      onChanged: (value) => setState(() => selectedSpiceLevel = value as String),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/order-details');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                  ),
                  child: const Text('Done'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}