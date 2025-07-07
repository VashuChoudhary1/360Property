import 'package:flutter/material.dart';

class AddToCompareSheet extends StatelessWidget {
  const AddToCompareSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add to compare',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('You can compare up to 3 property'),
          const SizedBox(height: 16),
          ...List.generate(3, (index) => _similarPropertyCard()),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Add and Start Compare',style: TextStyle(color:Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _similarPropertyCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage("assets/home_assets/house_img.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text('3 BHK Villa'),
        subtitle: const Text('Sector 36, Noida\n2 Bedroom'),
      ),
    );
  }
}
