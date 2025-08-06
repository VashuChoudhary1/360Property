import 'package:app/Post_property/post_property5.dart';
import 'package:flutter/material.dart';

class AddAmenitiesScreen extends StatefulWidget {
  const AddAmenitiesScreen({super.key});

  @override
  State<AddAmenitiesScreen> createState() => _AddAmenitiesScreenState();
}

class _AddAmenitiesScreenState extends State<AddAmenitiesScreen> {
  List<String> selectedFurnishings = [];
  List<String> selectedWaterSources = [];
  List<String> selectedSocietyAmenities = [];
  List<String> selectedLocationAdvantages = [];

  final List<String> furnishingOptions = [
    "AC", "Dining Table", "Washing Machine", "Sofa", "Microwave", "TV",
    "Fridge", "Bed", "Water Purifier", "Gas Pipeline", "Cupboard", "Geyser"
  ];

  final List<String> waterOptions = ["Municipal Corporation", "24*7", "Borewell/Tank"];

  final List<String> societyOptions = [
    "Lift", "CCTV", "GYM", "Garden", "Kids Area", "Swimming Pool", "Power Backup",
    "Intercom", "Gated Community", "CLUB HOUSE", "Community Hall", "Pet Allowed", "Sports"
  ];

  final List<String> locationOptions = [
    "Close to metro Station", "Close to School", "Close to Hospital",
    "Close to Market", "Close to Railway Station"
  ];

  Widget buildFilterChips(List<String> options, List<String> selectedList) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((item) {
        final selected = selectedList.contains(item);
        return FilterChip(
          label: Text(item),
          selected: selected,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                selectedList.add(item);
              } else {
                selectedList.remove(item);
              }
            });
          },
          selectedColor: Colors.red,
          labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Amenities", style: TextStyle(color: Colors.black)),
       
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Furnishing Amenities", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildFilterChips(furnishingOptions, selectedFurnishings),
            const SizedBox(height: 24),

            const Text("Water Source", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildFilterChips(waterOptions, selectedWaterSources),
            const SizedBox(height: 24),

            const Text("Society Amenities", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildFilterChips(societyOptions, selectedSocietyAmenities),
            const SizedBox(height: 24),

          
            const Text("Location Advantages", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildFilterChips(locationOptions, selectedLocationAdvantages),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VerifyPropertyScreen()),
            );
          },
          child: const Text("Next", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
