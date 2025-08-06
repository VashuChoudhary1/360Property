import 'package:flutter/material.dart';
import 'home_loan_step2.dart';

class HomeLoanStep1 extends StatelessWidget {
  const HomeLoanStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Center(
            child: Text(
              'Home Loans',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("How it works",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const Text("Quicker home loan"),
                  const SizedBox(height: 20),
                  step("Compare Various bank offers", Icons.compare),
                  step("Share your details and apply to one or multiple banks",
                      Icons.share),
                  step("Sit back and relax and wait for bank to contact you",
                      Icons.event_note),
                  step("Avail Home loan", Icons.home),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeLoanStep2()),
                        );
                      },
                      child: const Text("Next, Add Loan Details"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget step(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red.shade100,
            child: Icon(icon, color: Colors.red),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
