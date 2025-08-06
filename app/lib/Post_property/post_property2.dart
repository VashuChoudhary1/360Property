import 'package:app/Post_property/post_property3.dart';
import 'package:flutter/material.dart';

class AddPropertyDetailsScreen extends StatefulWidget {
  const AddPropertyDetailsScreen({super.key});

  @override
  State<AddPropertyDetailsScreen> createState() => _AddPropertyDetailsScreenState();
}

class _AddPropertyDetailsScreenState extends State<AddPropertyDetailsScreen> {
  String selectedBedroom = "2 BHK";
  String selectedFurnish = "Fully Furnished";
  String selectedFacing = "North";
  String availabilityStatus = "Ready to move";
  String propertyAge = "0–1 Years";

  final TextEditingController locationController = TextEditingController();
  final TextEditingController builtUpController = TextEditingController();
  final TextEditingController totalFloorsController = TextEditingController();
  final TextEditingController propertyOnFloorController = TextEditingController();

  List<String> selectedOtherRooms = [];

  List<String> bedrooms = ["1RK / 1BHK", "2 BHK", "3 BHK", "4 BHK", "5 BHK"];
  List<String> otherRooms = ["Project Room", "Study Room", "Servant Room", "Other"];
  List<String> furnishTypes = ["Fully Furnished", "Semi Furnished", "Unfurnished"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Property Details", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("STEP 2 OF 3", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),

            
            const Text("Property Type", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                "Independent House/Villa",
                "Independent Floor",
                "Duplex",
                "Residential Plot",
                "Studio",
                "Penthouse"
              ].map((type) => Chip(label: Text(type))).toList(),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Building/Project/Society (Optional)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            const Text("No. of Bedrooms", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: bedrooms.map((b) {
                final selected = selectedBedroom == b;
                return ChoiceChip(
                  label: Text(b),
                  selected: selected,
                  onSelected: (_) => setState(() => selectedBedroom = b),
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            
            TextField(
              controller: builtUpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Built Up Area (in Sq.ft.)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Other Rooms (Optional)", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: otherRooms.map((room) {
                final selected = selectedOtherRooms.contains(room);
                return FilterChip(
                  label: Text(room),
                  selected: selected,
                  onSelected: (bool value) {
                    setState(() {
                      if (value) {
                        selectedOtherRooms.add(room);
                      } else {
                        selectedOtherRooms.remove(room);
                      }
                    });
                  },
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            const Text("Furnish Type", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: furnishTypes.map((furnish) {
                final selected = selectedFurnish == furnish;
                return ChoiceChip(
                  label: Text(furnish),
                  selected: selected,
                  onSelected: (_) => setState(() => selectedFurnish = furnish),
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            
const Text("Floor Details", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
TextField(
  controller: totalFloorsController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: "Total Floors",
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 12),
TextField(
  controller: propertyOnFloorController,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: "Property on Floor",
    border: OutlineInputBorder(),
  ),
),
const SizedBox(height: 16),


const Text("Facing", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Wrap(
  spacing: 12,
  children: ["North", "East", "West", "South", "North-East"].map((direction) {
    final selected = selectedFacing == direction;
    return ChoiceChip(
      label: Text(direction),
      selected: selected,
      onSelected: (_) => setState(() => selectedFacing = direction),
      selectedColor: Colors.red,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
    );
  }).toList(),
),
const SizedBox(height: 16),


const Text("Availability Status", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Wrap(
  spacing: 12,
  children: ["Ready to move", "Under Construction"].map((status) {
    final selected = availabilityStatus == status;
    return ChoiceChip(
      label: Text(status),
      selected: selected,
      onSelected: (_) => setState(() => availabilityStatus = status),
      selectedColor: Colors.red,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
    );
  }).toList(),
),
const SizedBox(height: 16),

const Text("Age of Property", style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Wrap(
  spacing: 12,
  children: ["0–1 Years", "1–5 Years", "5–10 Years", "10+ Years"].map((age) {
    final selected = propertyAge == age;
    return ChoiceChip(
      label: Text(age),
      selected: selected,
      onSelected: (_) => setState(() => propertyAge = age),
      selectedColor: Colors.red,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
    );
  }).toList(),
),
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
              MaterialPageRoute(builder: (_) => const AddMediaPricingScreen()),
            );
          },
          child: const Text("Next, Add Media & Price Details", style: TextStyle(color: Colors.white)),

        ),
      ),
    );
  }
}

