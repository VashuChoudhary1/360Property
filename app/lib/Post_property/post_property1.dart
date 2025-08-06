import 'package:app/Post_property/post_property2.dart';
import 'package:flutter/material.dart';

class AddBasicDetailsScreen extends StatefulWidget {
  const AddBasicDetailsScreen({super.key});

  @override
  State<AddBasicDetailsScreen> createState() => _AddBasicDetailsScreenState();
}

class _AddBasicDetailsScreenState extends State<AddBasicDetailsScreen> {
  String selectedUser = "Owner";
  String selectedPropertyType = "Residential";

  final List<String> cities = [
    "Mumbai", "Bengaluru", "Kolkata", "Chennai", "Hyderabad", "Pune", "Delhi"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Basic Details", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("STEP 1 OF 3", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),

           
            const Text("Are You a", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: ["Owner", "Agent"].map((type) {
                final selected = selectedUser == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Text(type),
                    selected: selected,
                    onSelected: (_) => setState(() => selectedUser = type),
                    selectedColor: Colors.red,
                    labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            /// Property Type
            const Text("What Kind of Property ?", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: ["Residential", "Commercial", "Agricultural Land"].map((type) {
                final selected = selectedPropertyType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: selected,
                  onSelected: (_) => setState(() => selectedPropertyType = type),
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            
            const Text("Select Your City", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Search for your location here",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.gps_fixed, size: 16, color: Colors.red),
                SizedBox(width: 4),
                Text("Use my Current Location", style: TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Popular Cities", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...cities.map((city) => ListTile(
                  title: Text(city),
                  onTap: () {
                  },
                )),

            const SizedBox(height: 24),
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
              MaterialPageRoute(builder: (_) => const AddPropertyDetailsScreen()),
            );
          },
          child: const Text("Next, Add Property Details", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
