import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../models/menu_item.dart';

class CustomizationPage extends StatefulWidget {
  final MenuItem item;

  const CustomizationPage({Key? key, required this.item}) : super(key: key);

  @override
  _CustomizationPageState createState() => _CustomizationPageState();
}

class _CustomizationPageState extends State<CustomizationPage> {
  int fullServings = 0;
  int halfServings = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(widget.item.image),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  widget.item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Servings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            _buildServingOption('Full', fullServings, (value) {
              setState(() => fullServings = value);
            }),
            const SizedBox(height: 8),
            _buildServingOption('1/2', halfServings, (value) {
              setState(() => halfServings = value);
            }),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (fullServings > 0 || halfServings > 0)
                    ? () {
                  final cart = context.read<CartModel>();
                  if (fullServings > 0) {
                    cart.addToCart(
                      widget.item,
                      {'serving': 'Full'},
                      fullServings,
                    );
                  }
                  if (halfServings > 0) {
                    cart.addToCart(
                      widget.item,
                      {'serving': 'Half'},
                      halfServings,
                    );
                  }
                  Navigator.pop(context);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Done',
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

  Widget _buildServingOption(String title, int value, Function(int) onChanged) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: value > 0 ? () => onChanged(value - 1) : null,
        ),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onChanged(value + 1),
        ),
      ],
    );
  }
}