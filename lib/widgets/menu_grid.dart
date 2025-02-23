import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../screens/customization_page.dart';

class MenuGrid extends StatelessWidget {
  final String selectedCategory;

  const MenuGrid({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
        id: '1',
        name: 'Paneer Masala',
        description: 'Delicious paneer in spicy masala sauce.',
        price: 250,
        image: 'assets/paneer_masala.jpg',
        category: 'Curry',
        customizationOptions: {'servings': true},
      ),
      MenuItem(
        id: '2',
        name: 'Dhal Makhani',
        description: 'Creamy lentils cooked in butter.',
        price: 200,
        image: 'assets/dhal_makhani.jpg',
        category: 'Curry',
        customizationOptions: {'servings': true},
      ),
      MenuItem(
        id: '3',
        name: 'Malai Kofta',
        description: 'Soft koftas in rich creamy gravy.',
        price: 300,
        image: 'assets/malai_kofta.jpg',
        category: 'Curry',
        customizationOptions: {'servings': true},
      ),
      MenuItem(
        id: '4',
        name: 'Butter Naan',
        description: 'Soft and fluffy naan with butter.',
        price: 50,
        image: 'assets/butter_naan.jpg',
        category: 'Chapathi',
        customizationOptions: {'servings': false},
      ),
      MenuItem(
        id: '5',
        name: 'Chicken Tikka',
        description: 'Grilled chicken with special spices.',
        price: 350,
        image: 'assets/chicken_tikka.jpg',
        category: 'Starters',
        customizationOptions: {'spicy_level': true},
      ),
      MenuItem(
        id: '6',
        name: 'Gulab Jamun',
        description: 'Sweet dumplings in sugar syrup.',
        price: 100,
        image: 'assets/gulab_jamun.jpg',
        category: 'Dessert',
        customizationOptions: {'servings': false},
      ),
    ];

    // **Filter items based on selected category**
    final filteredItems = selectedCategory == 'All Menu'
        ? menuItems
        : menuItems.where((item) => item.category == selectedCategory).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFE135),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
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
              Expanded(
                flex: 2,
                child: Padding(
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            item.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹ ${item.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomizationPage(item: item),
                                );
                              },
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
