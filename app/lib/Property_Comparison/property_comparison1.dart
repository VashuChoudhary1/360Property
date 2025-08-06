import 'package:app/Property_Comparison/add_to_compare_sheet.dart';
import 'package:flutter/material.dart';

class ComparePropertyScreen extends StatelessWidget {
  const ComparePropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Compare Property',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                _propertyThumbnail(),
                const SizedBox(width: 12),
                _addPropertyBox(context),
                SizedBox(width: 12,)
              ],
            ),
            const SizedBox(height: 16),
            _propertyDetails(),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 10,right:10),
              child: _contactButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _propertyThumbnail() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/home_assets/house_img.png",
              fit: BoxFit.cover,            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.black.withOpacity(0.6),
              child: const Text(
                '2,3,4 BHK Flats & Apartments\nfor rent and sale',
                style: TextStyle(color: Colors.white, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addPropertyBox(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            isScrollControlled: true,
            builder: (_) => const AddToCompareSheet(),
          );
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.red),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                SizedBox(
                  height:80,
                  child: Image.asset("assets/compare_assets/compare_photo.png",fit: BoxFit.cover,),),
                SizedBox(height: 6),
                Text(
                  'Add Property to Compare',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _propertyDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
           DetailRow(label: "Price", value: "₹ 6.6 Cr"),
        DetailRow(label: "Property Type", value: "Independent House"),
        DetailRow(label: "BHK (size)", value: "3 BHK"),
        DetailRow(label: "Ammenities", value: "Parking"),
        DetailRow(label: "", value: "Swimming Pool"),
          
        ],
      ),
    );
  }

 
  Widget _contactButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {},
        child: const Text(
          'Contact Seller',
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
      ),
    );
  }
}
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 4.0,left:15.0),
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        Container(
          width: double.infinity,
          color: const Color(0xFFF7E4E4),
          padding: const EdgeInsets.all(12),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}