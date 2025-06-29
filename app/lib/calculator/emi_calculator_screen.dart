import 'package:app/calculator/affordability_calculator_screen.dart';
import 'package:app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  double loanAmount = 2000000;
  double interestRate = 9.5;
  double tenure = 20;
  double prePayment = 0;
  String frequency = 'Every Month';
  String startDate = 'JUNE,2025';

  final frequencies = ['Every Month', 'Quarterly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("EMI Calculator"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            inputSlider("Loan Amount", loanAmount, 0, 5000000, (value) {
              setState(() => loanAmount = value);
            }),
            SizedBox(height: 10,),
            dropdownField("Select Bank (Optional)"),
            SizedBox(height: 10,),
            inputSlider("Tenure (year)", tenure, 1, 30, (value) {
              setState(() => tenure = value);
            }),
            SizedBox(height: 10,),
            inputSlider("Interest Rate (p.a)", interestRate, 5, 15, (value) {
              setState(() => interestRate = value);
            }),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: "Pre-payment Amount (Optional)"),
              keyboardType: TextInputType.number,
              onChanged: (value) => prePayment = double.tryParse(value) ?? 0,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: frequency,
              items: frequencies.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
              onChanged: (val) => setState(() => frequency = val!),
              decoration: const InputDecoration(labelText: "Frequency"),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: "Starting Date"),
              controller: TextEditingController(text: startDate),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AffordabilityCalculatorScreen()),
                        );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Calculate EMI",
              style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/home_assets/home_loans.png', height: 150), // Placeholder ad
          ],
        ),
      ),
    );
  }
}
