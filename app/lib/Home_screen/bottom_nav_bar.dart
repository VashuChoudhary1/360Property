import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black87,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.home,
              label: "Home",
              isSelected: currentIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            BottomNavItem(
              icon: Icons.article,
              label: "News",
              isSelected: currentIndex == 1,
              onTap: () => onTabSelected(1),
            ),
            const SizedBox(width: 30), 
            BottomNavItem(
              icon: Icons.favorite,
              label: "Saved",
              isSelected: currentIndex == 2,
              onTap: () => onTabSelected(2),
            ),
            BottomNavItem(
              icon: Icons.menu_book,
              label: "Guide",
              isSelected: currentIndex == 3,
              onTap: () => onTabSelected(3),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.red : Colors.white),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
