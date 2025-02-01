import 'package:flutter/material.dart';

class MenuSidebar extends StatefulWidget {
  const MenuSidebar({Key? key}) : super(key: key);

  @override
  State<MenuSidebar> createState() => _MenuSidebarState();
}

class _MenuSidebarState extends State<MenuSidebar> {
  String selectedCategory = 'All Menu';

  final List<Map<String, dynamic>> categories = [
    {'name': 'All Menu', 'count': 132},
    {'name': 'Chapathi', 'count': 25},
    {'name': 'Curry', 'count': 30},
    {'name': 'Starters', 'count': 59},
    {'name': 'Dessert', 'count': 15},
    {'name': 'Beverages', 'count': 12},
    {'name': 'Soups', 'count': 8},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.grey[100],
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category['name'] == selectedCategory;

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFFE135) : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    selectedCategory = category['name'];
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${category['count']} items',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}