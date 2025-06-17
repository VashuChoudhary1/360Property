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
      body:Container(
        decoration: BoxDecoration(
          gradient:  LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
           Color(0xFF06112D),
    Color(0xFFFFA9A9),
        ],
        stops: [0.02, 0.88],
      ),
        ),
        child: SafeArea(
             child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'assets/sign_up.png',
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      child:Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: const Text(
                                  'Sign up today',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: const Text(
                                  'Your personalized property experience starts here.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            
                    const SizedBox(height: 30),
                    const Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: customInputDecoration('Enter full Name'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Email ID',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: customInputDecoration('Eg: example@gmail.com'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Phone Number',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          decoration: const BoxDecoration(
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
                    const Text(
                      'Getting started? Choose your role:',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: ['Owner', 'Agent', 'Buyer'].map((role) {
                        return ChoiceChip(
                          label: Text(role),
                          selected: selectedRole == role,
                          selectedColor: const Color(0xFFFF0000),
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
                    Row(
                      children: [
                        Checkbox(
                          value: isTermsAccepted,
                          onChanged: (value) {
                            setState(() {
                              isTermsAccepted = value!;
                            });
                          },
                          activeColor: const Color(0xFFFF0000),
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
                          backgroundColor: const Color(0xFFFF0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'SignUp',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    ],
                          ),
                        ),
                      
                    ),
                  ],
                ),
           ),
      ),
          
          
      
    );
  }
}
