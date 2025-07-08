import 'package:flutter/material.dart';
import 'home_loan_step3.dart';

class HomeLoanStep2 extends StatelessWidget {
  const HomeLoanStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 10),
                      Text("Home Loans",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/home_loan.png")
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    stepLabel("1", "Enter the Loan details", "1 of 4 steps"),
                    textField("Property Amount"),
                    dropdownField("Select City"),
                    textField("Pincode"),
                    const Text("Have you shortlisted a property?"),
                    Row(
                      children: [
                        choiceChip("Yes"),
                        const SizedBox(width: 10),
                        choiceChip("No"),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeLoanStep3()),
                        );
                      },
                      child: const Text("Next, Add Personal Details",style: TextStyle(color: Colors.white),),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        "By clicking above you agree to Terms & Conditions",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(String hint) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: const UnderlineInputBorder(),
          ),
        ),
      );

  Widget dropdownField(String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: DropdownButtonFormField<String>(
          items: ["Delhi", "Mumbai", "Bangalore"]
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (value) {},
          decoration: InputDecoration(
            hintText: label,
            border: const UnderlineInputBorder(),
          ),
        ),
      );

  Widget choiceChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }

  Widget stepLabel(String number, String title, String sub) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.red.shade100,
              child: Text(number, style: const TextStyle(color: Colors.red)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(sub, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
