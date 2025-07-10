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
                Image.asset("assets/home_assets/house_img.png",
                    height: 250, width: double.maxFinite, fit: BoxFit.fill),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.location_on, size: 14, color: Colors.red),
                        SizedBox(width: 4),
                        Text("Sector 36, Noida",
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text("See 3D View on Map",
                        style: TextStyle(color: Colors.white, fontSize: 10)),
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
                          _buildTag(
                              "Ready To Move", Colors.red.shade100, Colors.red),
                          const SizedBox(width: 8),
                          _buildTag(
                              "Furnished", Colors.red.shade100, Colors.red),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Price and description
                      const Text("₹ 47,00,000",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text(
                          "2,3,4 BHK flats & Apartments for rent and sale"),

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
                            imagePath: "assets/product_assets/img1.png",
                            title: "3 BHK and 1 baths",
                            backgroundColor: Color(0xFFC7D4FD),
                          ),
                          _InfoChip(
                            imagePath: "assets/product_assets/img2.png",
                            title: "162.0 sq.m.\nsuper area",
                            backgroundColor: Color(0xFFC7FFCE),
                          ),
                          _InfoChip(
                            imagePath: "assets/product_assets/img3.png",
                            title: "3.4 Lac\nprice per sq.m.",
                            backgroundColor: Color(0xFFF3FFA1),
                          ),
                          _InfoChip(
                            imagePath: "assets/product_assets/img4.png",
                            title: "1 Year Old\nProperty",
                            backgroundColor: Color(0xFFFFD9DA),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // About Property
                      const Text("About Property",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F4FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Property Highlights",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            _highlightChip(
                              icon_img:
                                  "assets/product_assets/location_icon.png",
                              title: "Parking",
                            ),
                            _highlightChip(
                              icon_img:
                                  "assets/product_assets/elevator_icon.png",
                              title: "Elevator",
                            ),
                            _highlightChip(
                              icon_img: "assets/product_assets/garden_icon.png",
                              title: "Garden",
                            ),
                            _highlightChip(
                              icon_img:
                                  "assets/product_assets/heating_icon.png",
                              title: "Heating",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                "Property Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              _detailRow("Layout", "1 BHK, 1 Baths,\nServant Room"),
              _detailRow("Ownership", "-----"),
              _detailRow("Super Area", "1243.75 sq.ft."),
              _detailRow("Overlooking", "Others"),
              _detailRow("Width of facing road", "39.4 ft"),
              _detailRow("Flooring", "Cement"),
              _detailRow("Water Source", "Municipal corporation"),
              _detailRow("Furnishing", "Furnished"),
              _detailRow("Facing", "East"),
              const SizedBox(height: 24),

               const Text(
                "Your Visual Walkthrough Starts Here.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Photo Tours Made Easy.",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 16),
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
                      child: const Text("View Number",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
  final String imagePath;
  final String title;
  final Color backgroundColor;

  const _InfoChip({
    required this.imagePath,
    required this.title,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class _highlightChip extends StatelessWidget {
  final String icon_img;
  final String title;
  const _highlightChip({required this.icon_img, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon_img,
          height: 15,
          width: 15,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 5,
        ),
        Text(title, style: TextStyle(fontSize: 12))
      ],
    );
  }
}

Widget _detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
           SizedBox(width: 8,),
          Expanded(child: Text(value,
          style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),)
      
      ],
    ),
  );
}
