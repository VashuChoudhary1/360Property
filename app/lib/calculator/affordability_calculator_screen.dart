import 'package:app/calculator/eligibility_calculator_screen.dart';
import 'package:app/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class AffordabilityCalculatorScreen extends StatefulWidget {
  const AffordabilityCalculatorScreen({super.key});

  @override
  State<AffordabilityCalculatorScreen> createState() =>
      _AffordabilityCalculatorScreenState();
}

class _AffordabilityCalculatorScreenState
    extends State<AffordabilityCalculatorScreen> {
  double downPayment = 5000000;
  double grossIncome = 200000;
  double tenure = 20;
  double interestRate = 9.5;
  double otherEmi = 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Affordability Calculator"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            inputSlider("Down Payment", downPayment, 0, 5000000, (value) {
              setState(() => downPayment = value);
            }),
            const SizedBox(height: 10),
            inputSlider("Gross Income (Monthly)", grossIncome, 0, 200000,
                (value) {
              setState(() => grossIncome = value);
            }),
            const SizedBox(height: 10),
            inputSlider("Tenure (year)", tenure, 0, 30, (value) {
              setState(() => tenure = value);
            }),
            const SizedBox(height: 10),
            inputSlider("Interest Rate (p.a)", interestRate, 0, 9.5, (value) {
              setState(() => interestRate = value);
            }),
            const SizedBox(height: 10),
            inputSlider("Other EMIs (Monthly)", otherEmi, 0, 50000, (value) {
              setState(() => otherEmi = value);
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Calculate Affordability",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 20),
            resultCard("Your Home Loan Eligibility", "₹ 50,00,000",
                "Monthly EMI: ₹ 50,000",
                onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EligibilityCalculatorScreen(),
      ),
    );
  },

                ),
            const SizedBox(height: 20),
            Image.asset('assets/home_assets/home_loans.png', height: 150),
          ],
        ),
      ),
    );
  }
}
