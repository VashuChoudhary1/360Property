import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

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
          children: const [
            BottomNavItem(icon: Icons.home, label: "Home"),
            BottomNavItem(icon: Icons.article, label: "News"),
            SizedBox(width: 30), // Space for FAB
            BottomNavItem(icon: Icons.favorite, label: "Saved"),
            BottomNavItem(icon: Icons.menu_book, label: "Guide"),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const BottomNavItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))
      ],
    );
  }
}
