import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../screens/customization_page.dart';

class MenuGrid extends StatelessWidget {
  const MenuGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
        id: '1',
        name: 'Paneer Masala',
        description: 'A juicy, seasoned patty served with toppings like lettuce, tomato, cheese, and sauces for a smoky, flavorful bite.',
        price: 250,
        image: 'assets/paneer_masala.jpg',
        category: 'Curry',
        customizationOptions: {'servings': true},
      ),
      MenuItem(
        id: '2',
        name: 'Dhal Makhani',
        description: 'A juicy, seasoned patty served with toppings like lettuce, tomato, cheese, and sauces for a smoky, flavorful bite.',
        price: 200,
        image: 'assets/dhal_makhani.jpg',
        category: 'Curry',
        customizationOptions: {'servings': true},
      ),
      MenuItem(
        id: '3',
        name: 'Malai Kofta',
        description: 'A juicy, seasoned patty served with toppings like lettuce, tomato, cheese, and sauces for a smoky, flavorful bite.',
        price: 300,
        image: 'assets/malai_kofta.jpg',
        category: 'Curry',
        customizationOptions: {'servings': true},
      ),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFE135),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    item.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${item.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomizationPage(item: item),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                          ),
                          child: const Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}