import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String selectedRole = 'Owner'; // Default
  bool isTermsAccepted = false;

  InputDecoration customInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/signup_image.png', // Replace with your asset path
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign up today',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your personalized property experience starts here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Name
            const Text(
              'Name',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
            ),
            TextField(
              controller: nameController,
              decoration: customInputDecoration('Enter full Name'),
            ),
            const SizedBox(height: 16),

            // Email
            const Text(
              'Email ID',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
            ),
            TextField(
              controller: emailController,
              decoration: customInputDecoration('Eg: example@gmail.com'),
            ),
            const SizedBox(height: 16),

            // Phone
            const Text(
              'Phone Number',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
            ),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFFF0000), width: 2),
                    ),
                  ),
                  child: const Text('+91'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: customInputDecoration('Phone Number'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Role Selection
            const Text(
              'Getting started? Choose your role:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              children: ['Owner', 'Agent', 'Buyer'].map((role) {
                return ChoiceChip(
                  label: Text(role),
                  selected: selectedRole == role,
                  selectedColor: Color(0xFFFF0000),
                  onSelected: (selected) {
                    setState(() {
                      selectedRole = role;
                    });
                  },
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: selectedRole == role ? Colors.white : Colors.black,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Terms
            Row(
              children: [
                Checkbox(
                  value: isTermsAccepted,
                  onChanged: (value) {
                    setState(() {
                      isTermsAccepted = value!;
                    });
                  },
                  activeColor: Color(0xFFFF0000),
                ),
                Expanded(
                  child: RichText(
                    text: const TextSpan(
                      text: 'I agree to 360property ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // SignUp Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isTermsAccepted
                    ? () {
                        print('Name: ${nameController.text}');
                        print('Email: ${emailController.text}');
                        print('Phone: ${phoneController.text}');
                        print('Role: $selectedRole');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF0000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'SignUp',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
