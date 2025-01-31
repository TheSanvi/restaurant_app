import 'package:flutter/material.dart';
import '../models/menu_category.dart';
import '../models/menu_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String selectedCategory = 'All Menu';

  final List<MenuCategory> categories = [
    MenuCategory(name: 'All Menu', itemCount: 132),
    MenuCategory(name: 'Chapathi', itemCount: 25),
    MenuCategory(name: 'Curry', itemCount: 30),
    MenuCategory(name: 'Starters', itemCount: 59),
    MenuCategory(name: 'Dessert', itemCount: 59),
    MenuCategory(name: 'Beverages', itemCount: 10),
    MenuCategory(name: 'Soups', itemCount: 6),
  ];

  final List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      name: 'Paneer Masala',
      description: 'A juicy, seasoned patty served with toppings like lettuce, tomato, cheese, and sauces for a smoky, flavorful bite.',
      price: 250,
      image: 'assets/paneer_masala.jpg',
      category: 'Curry',
      customizationOptions: {
        'spiceLevel': true,
        'size': true,
      },
    ),
    MenuItem(
      id: '2',
      name: 'Dhal Makhani',
      description: 'A juicy, seasoned patty served with toppings like lettuce, tomato, cheese, and sauces for a smoky, flavorful bite.',
      price: 200,
      image: 'assets/dhal_makhani.jpg',
      category: 'Curry',
      customizationOptions: {
        'spiceLevel': true,
        'size': true,
      },
    ),
    MenuItem(
      id: '3',
      name: 'Malai Kofta',
      description: 'A juicy, seasoned patty served with toppings like lettuce, tomato, cheese, and sauces for a smoky, flavorful bite.',
      price: 300,
      image: 'assets/malai_kofta.jpg',
      category: 'Curry',
      customizationOptions: {
        'spiceLevel': true,
        'size': true,
      },
    ),
    // Add more items with the same structure
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Text(
              'Menu',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '#219',
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE135),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'T2',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: categories.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category.name == selectedCategory;

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFFE135) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    title: Text(
                      category.name,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text('${category.itemCount} items'),
                    onTap: () {
                      setState(() {
                        selectedCategory = category.name;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          // Menu Grid
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: menuItems.where((item) =>
                      selectedCategory == 'All Menu' || item.category == selectedCategory
                      ).length,
                      itemBuilder: (context, index) {
                        final filteredItems = menuItems.where((item) =>
                        selectedCategory == 'All Menu' || item.category == selectedCategory
                        ).toList();
                        return _buildMenuItem(filteredItems[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFE135),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.shopping_cart, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFE135),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              item.image,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                );
              },
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
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
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
  }
}

