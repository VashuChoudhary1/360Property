import 'package:app/Saved_screen/contact_tab.dart';
import 'package:app/Saved_screen/recent_tab.dart';
import 'package:app/Saved_screen/saved_property_tab.dart';
import 'package:app/Saved_screen/viewed_property_tab.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  int selectedIndex = 0;

  final List<Widget> tabs = const [
    SavedPropertyTab(),
   ViewedProperty(),
    ContactedTab(),
    RecentTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: buildTabItem(
                    index == 0 ? 'Saved Property' : 
                    index == 1 ? 'Viewed Property' :
                    index == 2 ? 'Contacted Property' : 
                                 'Recent Property',
                    selectedIndex == index,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Expanded(child: tabs[selectedIndex]),
          ],
        ),
      ),
    );
  }

  Widget buildTabItem(String title, bool isSelected) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSelected ? Colors.red : Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.home, color: isSelected ? Colors.red : Colors.grey, size: 24),
          const SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  color: isSelected ? Colors.red : Colors.grey, fontSize: 10),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
