import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    title: Text(title, style: const TextStyle(color: Colors.black)),
    iconTheme: const IconThemeData(color: Colors.black),
    elevation: 0,
  );
}
Widget inputSlider(
  String label,
  double value,
  double min,
  double max,
  ValueChanged<double> onChanged,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("₹ ${value.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      Slider(
        value: value,
        min: min,
        max: max,
        divisions: 100,
        label: value.toStringAsFixed(0),
        onChanged: onChanged,
        activeColor: Colors.red,
      ),
    ],
  );
}


Widget sliderField(String label, double value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      Slider(
        value: value,
        min: 0,
        max: 5000000,
        divisions: 100,
        onChanged: (_) {},
      ),
      Text("₹ ${value.toStringAsFixed(0)}", style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 10),
    ],
  );
}

Widget dropdownField(String label) {
  return DropdownButtonFormField<String>(
    items: const [
      DropdownMenuItem(value: 'option1', child: Text("Option 1")),
    ],
    onChanged: (_) {},
    decoration: InputDecoration(labelText: label),
  );
}

Widget resultCard(String title, String amount, String details,{
  VoidCallback? onTap,
})  {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        Text(amount,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(details, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size(double.infinity, 40),
          ),
          child: const Text("Calculate EMI",style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
