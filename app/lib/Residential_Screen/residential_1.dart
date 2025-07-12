import 'package:app/Residential_Screen/residential_2.dart';
import 'package:flutter/material.dart';

class ResidentialSearchScreen extends StatelessWidget {
  const ResidentialSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Residential',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("You are looking to buy in",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Search city, location, landmark",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
            ),
            const SizedBox(height: 20),
            const Text("Last Searched..",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              children: List.generate(
                3,
                (index) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.history, size: 20),
                  title: const Text("Last searched location Name here"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Popular Locations",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _locationChip("Noida"),
                _locationChip("Delhi"),
                _locationChip("Mumbai"),
                _locationChip("Chennai"),
                _locationChip("Gurgaon"),
                _locationChip("Bangalore"),
                _locationChip("Hyderabad"),
                _locationChip("Pune"),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResidentialFilterScreen(),
      ),
    );
                },
                child: const Text("Search",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.black, fontSize: 13)),
    );
  }
}
