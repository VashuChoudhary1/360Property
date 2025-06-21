import 'package:app/Home_screen/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/Home_screen/home_screen.dart';
import 'package:app/News_Screen/news_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    NewsScreen(),
    Placeholder(), // For "Saved"
    Placeholder(), // For "Guide"
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB action here
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
