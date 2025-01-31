import 'package:flutter/material.dart';

class MenuSidebar extends StatefulWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const MenuSidebar({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _MenuSidebarState createState() => _MenuSidebarState();
}

class _MenuSidebarState extends State<MenuSidebar> {
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
      width: 220, // Sidebar width
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15), // Extra space at the top
            ...categories.map((category) {
              bool isSelected = widget.selectedCategory == category['name'];

              return GestureDetector(
                onTap: () => widget.onCategorySelected(category['name'] as String),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 15), // **More spacing**
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.yellow : Colors.grey[400], // Gray default, yellow on tap
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: isSelected ? 6 : 3, // Light shadow for all, stronger for selected
                        offset: Offset(0, isSelected ? 4 : 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['name'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6), // Space between text elements
                      Text(
                        '${category['count']} items',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20), // Extra space at the bottom
          ],
        ),
      ),
    );
  }
}
