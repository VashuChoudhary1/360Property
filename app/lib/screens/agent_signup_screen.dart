import 'package:flutter/material.dart';

class AgentSignupScreen extends StatelessWidget {
  const AgentSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Verify your Identity with Aadhaar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              //const CustomTextField(hintText: 'Agent Type', keyboardType: "null",),
              const SizedBox(height: 10),
             // const CustomTextField(hintText: 'Full Address'),
              const SizedBox(height: 10),
             // const CustomTextField(  hintText: 'Pin Code', keyboardType: TextInputType.number), const SizedBox(height: 10),
             // const CustomTextField(hintText: 'Address Proof Upload'),
            //  const SizedBox(height: 10),
              //const CustomTextField(hintText: 'PAN Card No'),
              const SizedBox(height: 10),
              //const CustomTextField(hintText: 'Upload PAN Card'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Verify Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
