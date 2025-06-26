import 'package:app/Loan_Screen/home_loan_step4.dart';
import 'package:flutter/material.dart';

class HomeLoanStep3 extends StatelessWidget {
  const HomeLoanStep3({super.key});

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
                  Container(
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
                    stepLabel("2", "Add Personal Details", "2 of 4 steps"),
                    textField("Your Full Name"),
                    textField("Your Age (in Years)"),
                    const SizedBox(height: 10),
                    const Text("Your Gender"),
                    Row(
                      children: [
                        genderChip("Male"),
                        const SizedBox(width: 10),
                        genderChip("Female"),
                      ],
                    ),
                    textField("Phone Number"),
                    textField("Email Address"),
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        const Text("I am a Non-Resident Indian")
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
                              builder: (_) => const HomeLoanStep4()),
                        );
                      },
                      child: const Text("Next, Add Professional Details",style: TextStyle(color: Colors.white),),
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

  Widget textField(String hint) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: const UnderlineInputBorder(),
          ),
        ),
      );

  Widget genderChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }
}
