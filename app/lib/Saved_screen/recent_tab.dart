import 'package:flutter/material.dart';

class RecentSearchTab extends StatelessWidget {
  const RecentSearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return RecentSearchCard();
      },
    );
  }
}

class RecentSearchCard extends StatelessWidget {
  const RecentSearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network('https://via.placeholder.com/100', width: 100, height: 100, fit: BoxFit.cover),
        ),
        title: const Text('3 BHK Villa'),
        subtitle: const Text('Sector 36, Noida'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('View Number', style: TextStyle(color: Colors.red, fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
