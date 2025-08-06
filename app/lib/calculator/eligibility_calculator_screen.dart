import 'package:app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class EligibilityCalculatorScreen extends StatefulWidget {
  const EligibilityCalculatorScreen({super.key});

  @override
  State<EligibilityCalculatorScreen> createState() => _EligibilityCalculatorScreenState();
}

class _EligibilityCalculatorScreenState extends State<EligibilityCalculatorScreen> {

  double monthlySalary = 200000;
  double tenure_year = 20;
  double interest_rate = 9.5;
  double other_emi = 5000;


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: appBar("Eligibility Calculator"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            inputSlider("Your Monthly Salary (Net)",monthlySalary, 0, 200000, (value) {
              setState(() => monthlySalary= value);
            }),
            const SizedBox(height: 10),
            inputSlider("Tenure (year)",tenure_year, 0, 30, (value) {
              setState(() => tenure_year= value);
            }),
            const SizedBox(height: 10),
            inputSlider("Interest Rate (p.a)",interest_rate, 0, 9.5, (value) {
              setState(() => interest_rate = value);
            }),
            const SizedBox(height: 10),
            inputSlider("Other EMIs (Monthly)",other_emi, 0, 80000, (value) {
              setState(() => other_emi = value);
            }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Calculate Eligibility",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            resultCard("Your Home Loan Eligibility", "₹ 50,00,000", "Monthly EMI: ₹ 50,000"),
            const SizedBox(height: 20),
            Image.asset('assets/home_assets/home_loans.png', height: 150),
          ],
        ),
      ),
    );
  }
}
