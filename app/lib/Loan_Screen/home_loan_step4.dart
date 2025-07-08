import 'package:flutter/material.dart';
import 'home_loan_step5.dart';

class HomeLoanStep4 extends StatefulWidget {
  const HomeLoanStep4({super.key});

  @override
  State<HomeLoanStep4> createState() => _HomeLoanStep4State();
}

class _HomeLoanStep4State extends State<HomeLoanStep4> {
  String selectedProfession = 'Salaried';
  final incomeController = TextEditingController();
  final emiController = TextEditingController();

  final professions = ['Salaried', 'Self Employed', 'Retired', 'Home Maker'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Home Loans',
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
                    stepLabel("3", "Professional Details", "3 of 4 steps"),
                    const SizedBox(height: 10),
                    const Text("Select Your Profession Type",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: professions.map((profession) {
                        final isSelected = selectedProfession == profession;
                        return ChoiceChip(
                          label: Text(profession),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedProfession = profession;
                            });
                          },
                          selectedColor: Colors.red,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    buildTextField("Your Monthly Income ₹", incomeController),
                    buildTextField("Any existing emi amount ₹ (Optional)",
                        emiController),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeLoanStep5()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Find Best Offers",style: TextStyle(color: Colors.white),),
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
    return Row(
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
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(sub, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          border: const UnderlineInputBorder(),
        ),
      ),
    );
  }
}
