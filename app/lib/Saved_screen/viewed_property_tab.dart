import 'package:app/widgets/nearby_property_card.dart';
import 'package:flutter/material.dart';

class ViewedProperty extends StatelessWidget {
  const ViewedProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Recent Viewed',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      '02',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height:5),
          
    ListView.builder(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return NearbyCard();
       },
),

        ],
      ),
    );
  }
}