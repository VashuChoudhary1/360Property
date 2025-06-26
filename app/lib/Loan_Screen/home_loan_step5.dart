import 'package:app/Loan_Screen/home_loan_success.dart';
import 'package:flutter/material.dart';

class HomeLoanStep5 extends StatefulWidget {
  const HomeLoanStep5({super.key});

  @override
  State<HomeLoanStep5> createState() => _HomeLoanStep5State();
}

class _HomeLoanStep5State extends State<HomeLoanStep5> {
  int selectedIndex = -1;

  final bankList = List.generate(
    4,
    (index) => {
      'name': 'Canara Bank',
      'interest': '8.15%',
      'gst': '999',
    },
  );

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
                    stepLabel("4", "Select Bank", "4 of 4 steps"),
                    const SizedBox(height: 10),
                    const Text("Exclusive deals for You",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: bankList.length,
                        itemBuilder: (context, index) {
                          final bank = bankList[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() => selectedIndex = index);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? Colors.green
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 20,
                                    child: Text("B", style: TextStyle(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(bank['name']!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text("Interest: ${bank['interest']}"),
                                        Text("GST: ₹${bank['gst']}"),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    selectedIndex == index
                                        ? Icons.check_circle
                                        : Icons.radio_button_off,
                                    color: selectedIndex == index
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeLoanSuccessScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Done",style: TextStyle(color: Colors.white),),
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
}
