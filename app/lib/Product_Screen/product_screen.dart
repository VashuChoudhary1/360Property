import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: SafeArea(
        child: Column(
          children: [
            // Top Image with overlay content
            Stack(
              children: [
                Image.network(
                  'https://via.placeholder.com/600x250', // Replace with your image
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite_border, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.share, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.red),
                        SizedBox(width: 4),
                        Text("Sector 36, Noida", style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text("See 3D View on Map", style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),

            // Bottom content
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tags
                      Row(
                        children: [
                          _buildTag("Villa", Colors.red.shade100, Colors.red),
                          const SizedBox(width: 8),
                          _buildTag("Ready To Move", Colors.red.shade100, Colors.red),
                          const SizedBox(width: 8),
                          _buildTag("Furnished", Colors.red.shade100, Colors.red),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Price and description
                      const Text("₹ 47,00,000", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text("2,3,4 BHK flats & Apartments for rent and sale"),

                      const SizedBox(height: 16),

                      // Tab Bar
                      SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            _tabItem("Overview", true),
                            _tabItem("Highlights", false),
                            _tabItem("Property Details", false),
                            _tabItem("Gallery", false),
                            _tabItem("Location", false),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Info Chips
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _InfoChip(
                            icon: Icons.bed_outlined,
                            title: "3 BHK and 1 baths",
                          ),
                          _InfoChip(
                            icon: Icons.square_foot,
                            title: "162.0 sq.m.\nsuper area",
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          _InfoChip(
                            icon: Icons.price_change_outlined,
                            title: "3.4 Lac\nprice per sq.m.",
                          ),
                          _InfoChip(
                            icon: Icons.home_work_outlined,
                            title: "1 Year Old\nProperty",
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // About Property
                      const Text("About Property", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text(
                        "Lorem ipsum dolor sit amet consectetur. Lorem accumsan faucibus donec nulla augue...",
                        style: TextStyle(fontSize: 13),
                      ),
                      const Text(
                        "Read More",
                        style: TextStyle(color: Colors.blue, fontSize: 13),
                      ),

                      const SizedBox(height: 16),

                      // Property Highlights
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Property Highlights", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text("✔ Parking"),
                            Text("✔ Elevator"),
                            Text("✔ Garden"),
                            Text("✔ Heating"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: const Text("View Number", style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Contact Seller"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabItem(String label, bool isActive) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.red : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.red : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, color: textColor)),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String title;

  const _InfoChip({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
