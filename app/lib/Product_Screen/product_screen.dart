import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isAgent = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool agreedToTerms = false;
  String agentChoice = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: SafeArea(
        child: Column(
          children: [
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
                    child: const Text("See 3D View on Map",
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ),
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
                      const Text("₹ 47,00,000", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Text("2,3,4 BHK flats & Apartments for rent and sale"),
                      const SizedBox(height: 16),
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
                      const Text("About Property", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text(
                        "Lorem ipsum dolor sit amet consectetur. Lorem accumsan faucibus donec nulla augue...",
                        style: TextStyle(fontSize: 13),
                      ),
                      const Text("Read More", style: TextStyle(color: Colors.blue, fontSize: 13)),
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
                            Text("Property Highlights", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            _highlightChip(icon_img: "assets/product_assets/location_icon.png", title: "Parking"),
                            _highlightChip(icon_img: "assets/product_assets/elevator_icon.png", title: "Elevator"),
                            _highlightChip(icon_img: "assets/product_assets/garden_icon.png", title: "Garden"),
                            _highlightChip(icon_img: "assets/product_assets/heating_icon.png", title: "Heating"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Property Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                      const Text("Your Visual Walkthrough Starts Here.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const Text("Photo Tours Made Easy.", style: TextStyle(fontSize: 13, color: Colors.grey)),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/property_main.jpg", fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(4, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage("assets/property_thumb.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("Explore On map", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/map_placeholder.png"),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFCEAEA),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _compareImage("assets/property_thumb.jpg"),
                                const SizedBox(width: 8),
                                _compareImage("assets/property_thumb.jpg", showBorder: true),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Text("Compare Property", style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            const Text("Add and Compare", style: TextStyle(fontSize: 12)),
                            const SizedBox(height: 6),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {},
                              child: const Text("Compare Now", style: TextStyle(color: Colors.white)),
                            ),
                            ],
                        ),
                      ),
                            SizedBox(height: 12),
                            const Text("Check availability & More", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 12),
                            const Text("Contact", style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.person, color: Colors.white),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text("Seller or owner", style: TextStyle(color: Colors.grey)),
                                    Text("+91 **********", style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildInputField("Your Name"),
                                  const SizedBox(height: 10),
                                  _buildInputField("Email"),
                                  const SizedBox(height: 10),
                                  _buildInputField("Phone Number"),
                                  const SizedBox(height: 10),
                                  _buildInputField("Tell us what is your best time to connect on call?", maxLines: 3),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Are You a Real Estate Agent?", style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _agentButton("Yes"),
                                const SizedBox(width: 12),
                                _agentButton("No"),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: agreedToTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      agreedToTerms = value!;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Wrap(
                                    children: const [
                                      Text("I agree to 360Property "),
                                      Text("Terms & Conditions",
                                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                      Text(" and "),
                                      Text("Privacy Policy",
                                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate() && agreedToTerms) {
                                    // Submit logic
                                  }
                                },
                                child: const Text("View Phone Number",
                                    style: TextStyle(color: Colors.white, fontSize: 16)),
                              ),
                            ),
                             const SizedBox(height: 20),

          const Text(
            "Interesting Reads",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 12),
           SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),             child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/property_thumb.jpg",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                     const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "How to Choose the right location in Noida?",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Mar 12, 2025",
                              style: TextStyle(fontSize: 11, color: Colors.grey),
 ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
          const Text(
            "Read More articles on home buying →",
            style: TextStyle(color: Colors.blue),
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "View Number ⌃",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Contact Seller",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
   Widget _agentButton(String label) {
    final selected = agentChoice == label;
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            agentChoice = label;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? Colors.red : Colors.white,
          side: BorderSide(
              color: selected ? Colors.red : Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          label,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

  Widget _buildInputField(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
    );
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
Widget _compareImage(String path, {bool showBorder = false}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: Colors.red, width: 2) : null,
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
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

