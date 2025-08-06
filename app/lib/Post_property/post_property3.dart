import 'package:app/Post_property/post_property4.dart';
import 'package:flutter/material.dart';

class AddMediaPricingScreen extends StatefulWidget {
  const AddMediaPricingScreen({super.key});

  @override
  State<AddMediaPricingScreen> createState() => _AddMediaPricingScreenState();
}

class _AddMediaPricingScreenState extends State<AddMediaPricingScreen> {
  String selectedOwnership = "Freehold";
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<String> ownershipTypes = [
    "Freehold", "Leasehold", "Co-operative Society", "Power of Attorney"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Media & Pricing", style: TextStyle(color: Colors.black)),
       
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("STEP 3 OF 3", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.cloud_upload_outlined, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text("Add at least 5 Photos"),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: null,
                      child: Text("Upload Photos"),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

           
            const Text("Ownership", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: ownershipTypes.map((type) {
                final selected = selectedOwnership == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: selected,
                  onSelected: (_) => setState(() => selectedOwnership = type),
                  selectedColor: Colors.red,
                  labelStyle: TextStyle(color: selected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            
            const Text("Price Details", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Expected Price",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            
            const Text("What makes your Property Unique",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Property Description",
                border: OutlineInputBorder(),
              ),
            ),
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
              MaterialPageRoute(builder: (_) => const AddAmenitiesScreen()),
            );
          },
          child: const Text("Next, Add Amenities", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

