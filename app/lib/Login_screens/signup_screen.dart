import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for user input
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Controllers for Agent/Builder specific fields
  final agentTypeController = TextEditingController();
  final addressController = TextEditingController();
  final localityController = TextEditingController();
  final pinCodeController = TextEditingController();

  File? addressProofFile;
  String? _otpToken; // To store the token from the OTP API

  // State variables for UI logic
  String selectedRole = 'Owner';
  bool isTermsAccepted = false;
  bool isFormValid = false;
  bool _isSendingOtp = false; // For loading indicator on the button

  @override
  void dispose() {
    // Dispose controllers to free up resources
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    agentTypeController.dispose();
    addressController.dispose();
    localityController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  // Reusable decoration for TextFormFields
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
      counterText: "",
    );
  }

  // Function to pick an address proof image
  Future<void> pickAddressProofFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        addressProofFile = File(result.files.single.path!);
      });
      _checkFormValidity();
    }
  }

  // Checks if the form is valid to enable the submit button
  void _checkFormValidity() {
    bool isFormValidNow = _formKey.currentState?.validate() ?? false;
    // For Agent or Builder, address proof is also mandatory
    if (selectedRole == 'Agent' || selectedRole == 'Builder') {
      if (addressProofFile == null) {
        isFormValidNow = false;
      }
    }
    setState(() {
      isFormValid = isFormValidNow && isTermsAccepted;
    });
  }

  // Step 1: Send OTP to the user's phone
  Future<void> _sendOtp(BuildContext context) async {
    if (!isFormValid) {
      _formKey.currentState?.validate();
      return;
    }
    setState(() {
      _isSendingOtp = true;
    });

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final dio = Dio();
    const url = "https://www.360property.in/api/send-otp";

    try {
      final response = await dio.post(url, data: {
        'mobile': phoneController.text.trim(),
        'countryCode': '+91',
      });

      if (!mounted) return;

      if (response.statusCode == 200 && response.data['success'] == true) {
        _otpToken = response.data['token'];
        _showOtpDialog(context);
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(
              content: Text(response.data['message'] ?? "Failed to send OTP")),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
              "Error sending OTP: ${e.response?.data['message'] ?? 'Network error'}"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSendingOtp = false;
        });
      }
    }
  }

  // Step 2: Show a dialog for OTP input
  void _showOtpDialog(context) {
    final otpController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Enter OTP',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('A 4-digit code has been sent to your mobile number.'),
              const SizedBox(height: 20),
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                maxLength: 4,
                decoration: customInputDecoration('----'),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (otpController.text.length == 4) {
                  Navigator.of(dialogContext).pop();
                  _verifyOtpAndRegister(otpController.text, context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF0000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  const Text('Sign Up', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Step 3: Verify OTP and then register the user
  Future<void> _verifyOtpAndRegister(String otp, BuildContext context) async {
    if (_otpToken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
      return;
    }

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final dio = Dio();
    const verifyUrl = "https://www.360property.in/api/verify-otp";

    try {
      final response = await dio.post(verifyUrl, data: {
        'otp': otp,
        'token': _otpToken,
      });

      if (!mounted) return;

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['success'] == true) {
        await submitSignupForm(context);
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? "Invalid OTP")),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
              "Verification failed: ${e.response?.data['message'] ?? 'An error occurred'}"),
        ),
      );
    }
  }

  Future<void> submitSignupForm(context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final dio = Dio();
    const registerUrl = "https://www.360property.in/api/auth/register";

    final Map<String, dynamic> data = {
      'username': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'countryCode': '+91',
      'role': selectedRole,
    };

    if ((selectedRole == 'Agent' || selectedRole == 'Builder') &&
        addressProofFile != null) {
      data['agentType'] = agentTypeController.text.trim();
      data['fullAddress'] = addressController.text.trim();
      data['locality'] = localityController.text.trim();
      data['pinCode'] = pinCodeController.text.trim();
      data['addressProof'] = await MultipartFile.fromFile(
        addressProofFile!.path,
        filename: basename(addressProofFile!.path),
      );
    }

    final formData = FormData.fromMap(data);

    try {
      final response = await dio.post(registerUrl, data: formData);

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Signup Successful!")),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
              "Signup failed: ${e.response?.data['message'] ?? 'An error occurred'}"),
        ),
      );
    }
  }

  // Validator for fields that cannot be empty
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/sign_up.png',
                  ),
                ),
              ),
              Expanded(
                flex: 12,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ]),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      onChanged: _checkFormValidity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Sign up today',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              'Your personalized property experience starts here.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text('Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF0000))),
                          TextFormField(
                            controller: nameController,
                            decoration:
                                customInputDecoration('Enter full Name'),
                            validator: (v) => _validateNotEmpty(v, "Name"),
                          ),
                          const SizedBox(height: 16),
                          const Text('Email ID',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF0000))),
                          TextFormField(
                            controller: emailController,
                            decoration:
                                customInputDecoration('Eg: example@gmail.com'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return "Email is required";
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text('Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF0000))),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: customInputDecoration(
                                'Please enter your password'),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Password is required";
                              }
                              if (v.length < 6) {
                                return "Minimum 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text('Phone Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF0000))),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xFFFF0000), width: 1),
                                    ),
                                  ),
                                  child: const Text('+91',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      customInputDecoration('Phone Number'),
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return "Phone number is required";
                                    }
                                    if (!RegExp(r'^\d{10}$').hasMatch(v)) {
                                      return "Enter a valid 10-digit phone number";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text('Getting started? Choose your role:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF0000))),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            children: ['Owner', 'Agent', 'Builder'].map((role) {
                              return ChoiceChip(
                                label: Text(role),
                                selected: selectedRole == role,
                                selectedColor: const Color(0xFFFF0000),
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      selectedRole = role;
                                      nameController.clear();
                                      emailController.clear();
                                      phoneController.clear();
                                      passwordController.clear();
                                      agentTypeController.clear();
                                      addressController.clear();
                                      localityController.clear();
                                      pinCodeController.clear();
                                      addressProofFile = null;
                                    });

                                    _checkFormValidity();
                                  }
                                },
                                backgroundColor: Colors.grey.shade200,
                                labelStyle: TextStyle(
                                  color: selectedRole == role
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          if (selectedRole == 'Agent' ||
                              selectedRole == 'Builder') ...[
                            const Text('Agent Type',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: agentTypeController,
                              decoration: customInputDecoration(
                                  'E.g. Real Estate Agent'),
                              validator: (v) =>
                                  _validateNotEmpty(v, "Agent Type"),
                            ),
                            const SizedBox(height: 16),
                            const Text('Full Address',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: addressController,
                              decoration: customInputDecoration('Street, City'),
                              validator: (v) =>
                                  _validateNotEmpty(v, "Full Address"),
                            ),
                            const SizedBox(height: 16),
                            const Text('Locality',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: localityController,
                              decoration: customInputDecoration('Locality'),
                              validator: (v) =>
                                  _validateNotEmpty(v, "Locality"),
                            ),
                            const SizedBox(height: 16),
                            const Text('PIN Code',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: pinCodeController,
                              decoration: customInputDecoration('PIN Code'),
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "PIN Code is required";
                                }
                                if (!RegExp(r'^\d{6}$').hasMatch(v)) {
                                  return "Enter a valid 6-digit PIN Code";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: pickAddressProofFile,
                              icon: Icon(
                                addressProofFile != null
                                    ? Icons.check_circle
                                    : Icons.upload_file,
                                color: addressProofFile != null
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              label: Text(
                                addressProofFile == null
                                    ? "Upload Address Proof"
                                    : "Proof Selected",
                                style: const TextStyle(color: Colors.black54),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: isTermsAccepted,
                                onChanged: (value) {
                                  setState(() {
                                    isTermsAccepted = value!;
                                  });
                                  _checkFormValidity();
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
                              onPressed: () {
                                if (isFormValid && !_isSendingOtp) {
                                  _sendOtp(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF0000),
                                disabledBackgroundColor: Colors.red.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: _isSendingOtp
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text(
                                      'Send OTP',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
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
