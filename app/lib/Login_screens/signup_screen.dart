import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Only needed if role is Agent or Builder
  final agentTypeController = TextEditingController();
  final addressController = TextEditingController();
  final localityController = TextEditingController();
  final pinCodeController = TextEditingController();
  File? addressProofFile;

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
  Future<void> pickAddressProofFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        addressProofFile = File(result.files.single.path!);
      });
    }
  }
  Future<void> submitSignupForm(BuildContext context) async {
    var uri = Uri.parse(" http://localhost:3000/api/signup"); 

    var request = http.MultipartRequest("POST", uri);
    request.fields['username'] = nameController.text.trim();
    request.fields['email'] = emailController.text.trim();
    request.fields['password'] = passwordController.text.trim();
    request.fields['phoneNumber'] = phoneController.text.trim();
    request.fields['countryCode'] = '+91';
    request.fields['role'] = selectedRole;

    if (selectedRole == 'Agent' || selectedRole == 'Builder') {
      request.fields['agentType'] = agentTypeController.text.trim();
      request.fields['fullAddress'] = addressController.text.trim();
      request.fields['locality'] = localityController.text.trim();
      request.fields['pinCode'] = pinCodeController.text.trim();
      if (addressProofFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'addressProof',
          addressProofFile!.path,
          filename: basename(addressProofFile!.path),
        ));
      }
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Signup successful!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup Successful!")),
      );
    } else {
      print('Signup failed: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed: ${response.statusCode}")),
      );
    }
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
                    if (selectedRole == 'Agent' || selectedRole == 'Builder') ...[
                          const Text('Agent Type', style: TextStyle(color: Colors.red)),
                          TextField(
                            controller: agentTypeController,
                            decoration: customInputDecoration('E.g. Real Estate Agent'),
                          ),
                          const SizedBox(height: 16),
                          const Text('Full Address', style: TextStyle(color: Colors.red)),
                          TextField(
                            controller: addressController,
                            decoration: customInputDecoration('Street, City'),
                          ),
                          const SizedBox(height: 16),
                          const Text('Locality', style: TextStyle(color: Colors.red)),
                          TextField(
                            controller: localityController,
                            decoration: customInputDecoration('Locality'),
                             ),
                          const SizedBox(height: 16),
                          const Text('PIN Code', style: TextStyle(color: Colors.red)),
                          TextField(
                            controller: pinCodeController,
                            decoration: customInputDecoration('PIN Code'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: pickAddressProofFile,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: Text(addressProofFile == null
                                ? "Upload Address Proof"
                                : "Address Proof Selected "),
                          ),
                        ],
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
                        onPressed: isTermsAccepted ?(){ submitSignupForm(context); }: null,
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
