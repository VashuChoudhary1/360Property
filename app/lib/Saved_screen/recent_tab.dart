
import 'package:app/widgets/nearby_property_card.dart';
import 'package:flutter/material.dart';

class RecentTab extends StatelessWidget {
  const RecentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Recent Searched',
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
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(), 
  itemCount: 2,
  itemBuilder: (context, index) {
        return NearbyCard();
       },
),

        ],
      ),
    );
  }
}