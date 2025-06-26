import 'package:flutter/material.dart';

class AffordabilityCalculatorScreen extends StatelessWidget {
  const AffordabilityCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Affordability Calculator"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            sliderField("Down Payment", 200000),
            sliderField("Gross Income (Monthly)", 200000),
            sliderField("Tenure (year)", 30),
            sliderField("Interest Rate (p.a)", 9.5),
            sliderField("Other EMIs (Monthly)", 50000),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Calculate Affordability"),
            ),
            const SizedBox(height: 20),
            resultCard("Your Home Loan Eligibility", "₹ 50,00,000", "Monthly EMI: ₹ 50,000"),
            const SizedBox(height: 20),
            Image.asset('assets/ads_banner.png', height: 150),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(),
    );
  }
}
