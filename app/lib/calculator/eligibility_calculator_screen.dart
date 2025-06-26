import 'package:flutter/material.dart';

class EligibilityCalculatorScreen extends StatelessWidget {
  const EligibilityCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Eligibility Calculator"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            sliderField("Your Monthly Salary (Net)", 200000),
            sliderField("Tenure (year)", 30),
            sliderField("Interest Rate (p.a)", 9.5),
            sliderField("Other EMIs (Monthly)", 80000),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Calculate Eligibility"),
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
