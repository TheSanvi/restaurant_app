class MenuCategory {
  final String name;
  final int itemCount;
  final bool isSelected;

  MenuCategory({
    required this.name,
    required this.itemCount,
    this.isSelected = false,
  });
}

