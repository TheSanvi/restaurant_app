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
  State<MenuSidebar> createState() => _MenuSidebarState();
}

class _MenuSidebarState extends State<MenuSidebar> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> categories = [
    {'name': 'All Menu', 'count': 132},
    {'name': 'Chapathi', 'count': 25},
    {'name': 'Curry', 'count': 30},
    {'name': 'Starters', 'count': 59},
    {'name': 'Dessert', 'count': 15},
    {'name': 'Beverages', 'count': 15},
    {'name': 'Soups', 'count': 15},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = category['name'] == widget.selectedCategory;

            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFE135) : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    widget.onCategorySelected(category['name']);
                  },
                  borderRadius: BorderRadius.circular(8),
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
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${category['count']} items',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[900],
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
      ),
    );
  }
}
