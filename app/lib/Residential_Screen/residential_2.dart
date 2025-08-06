import 'package:app/Residential_Screen/residential_3.dart';
import 'package:flutter/material.dart';

class ResidentialFilterScreen extends StatefulWidget {
  const ResidentialFilterScreen({super.key});

  @override
  State<ResidentialFilterScreen> createState() => _ResidentialFilterScreenState();
}

class _ResidentialFilterScreenState extends State<ResidentialFilterScreen> {
  double _budget = 25;

  String selectedPropertyType = "Independent House";
  String selectedBedrooms = "2 BHK";
  String listedBy = "Owner";
  String constructionStatus = "Ready to Move";

  final List<String> propertyTypes = [
    "Independent House",
    "Independent Floor",
    "Residential Plot",
    "Farm House",
    "Studio",
    "Duplex"
  ];

  final List<String> bedrooms = [
    "1RK / 1 BHK",
    "2 BHK",
    "3 BHK",
    "4 BHK",
    "5 BHK",
  ];

  final List<String> listedByOptions = [
    "Agent",
    "Owner",
    "Builder",
  ];

  final List<String> constructionStatusOptions = [
    "Ready to Move",
    "Under Construction",
    "New Launch",
  ];

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
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.more_vert, color: Colors.black),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              children: [
                const Text("You are looking to buy in "),
                const Spacer(),
                Text("Clear all", style: TextStyle(color: Colors.red.shade600)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Noida", style: TextStyle(color: Colors.red)),
                  SizedBox(width: 6),
                  Icon(Icons.close, color: Colors.red, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Property Types"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: propertyTypes.map((type) => _optionChip(type, selectedPropertyType, (val) {
                setState(() => selectedPropertyType = val);
              })).toList(),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Budget in ₹"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("1K"), Text("1CR+")],
            ),
            Slider(
              value: _budget,
              onChanged: (val) => setState(() => _budget = val),
              min: 1,
              max: 100,
              divisions: 99,
              activeColor: Colors.red,
            ),
            const SizedBox(height: 20),
            _sectionTitle("No. of Bedrooms"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: bedrooms.map((b) => _optionChip(b, selectedBedrooms, (val) {
                setState(() => selectedBedrooms = val);
              })).toList(),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Listed By"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: listedByOptions.map((b) => _optionChip(b, listedBy, (val) {
                setState(() => listedBy = val);
              })).toList(),
            ),
            const SizedBox(height: 20),
            _sectionTitle("Construction Status"),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: constructionStatusOptions.map((b) => _optionChip(b, constructionStatus, (val) {
                setState(() => constructionStatus = val);
              })).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResidentialListingScreen(),
      ),
    );
                },
                child: const Text("See all 170 Properties",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );

  Widget _optionChip(String label, String selected, Function(String) onTap) {
    final isSelected = label == selected;
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red.shade50 : Colors.white,
          border: Border.all(
              color: isSelected ? Colors.red : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.red : Colors.black),
        ),
      ),
    );
  }
}
