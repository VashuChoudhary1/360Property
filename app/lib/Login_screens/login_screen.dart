import 'package:app/Home_screen/home_screen.dart';
import 'package:app/Login_screens/signup_screen.dart';
// Note: You will need to create a home screen to navigate to after login.
// import 'package:app/screens/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

// Enum to manage the login state
enum LoginMode { email, phone }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  // State variables
  LoginMode _currentMode = LoginMode.email;
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  String? _otpToken; // To store the token from the send-otp API

  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // Common input decoration from your signup file
  InputDecoration customInputDecoration(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2),
      ),
      suffixIcon: suffixIcon,
      counterText: "",
    );
  }

  // --- Login Logic ---

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_currentMode == LoginMode.email) {
      _loginWithEmail();
    } else {
      _sendOtpForLogin();
    }
  }

  // 1. Email/Password Login
  Future<void> _loginWithEmail() async {
    setState(() => _isLoading = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final dio = Dio();
    const url = "https://www.360property.in/api/app/auth/login";

    try {
      final response = await dio.post(url, data: {
        'mode': 'credentials',
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });

      if (!mounted) return;

      if (response.statusCode == 200 && response.data['token'] != null) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Login Successful!")),
        );
        // TODO: Navigate to your home screen and save the token
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(response.data['message'] ?? "Login Failed")),
        );
      }
    } on DioException catch (e) {
      if (!mounted) return;
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
              "Error: ${e.response?.data['message'] ?? 'An unknown error occurred'}"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // 2. Phone/OTP Login Flow
  // Step 2a: Send OTP
  Future<void> _sendOtpForLogin() async {
    setState(() => _isLoading = true);
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
        _showOtpDialog(); // Show dialog to enter OTP
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
          content:
              Text("Error: ${e.response?.data['message'] ?? 'Network error'}"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Step 2b: Show OTP Dialog
  void _showOtpDialog() {
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
                  _loginWithOtp(otpController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF0000),
              ),
              child: const Text('Verify & Login',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Step 2c: Verify OTP and Login
  Future<void> _loginWithOtp(String otp) async {
    setState(() => _isLoading = true);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final dio = Dio();
    // This is the new API endpoint for OTP login
    const url = "https://www.360property.in/api/app/auth/login";

    try {
      final response = await dio.post(url, data: {
        'mode': 'otp',
        'phone': phoneController.text.trim(),
        'otp': otp,
        // Note: The API docs you provided for OTP login didn't mention a token.
        // If the API requires the token from send-otp, you would add it here:
        // 'token': _otpToken,
      });

      if (!mounted) return;

      if (response.statusCode == 200 && response.data['token'] != null) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Login Successful!")),
        );
        // TODO: Navigate to your home screen and save the token
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
              "Error: ${e.response?.data['message'] ?? 'An error occurred'}"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // --- UI Widgets ---

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 33, 33),
      body: Container(
          width: double.infinity,
    height: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF06112D),
          Color(0xFFFFA9A9),
        ],
        stops: [0.024, 0.8798],
      ),
    ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            
            child: Stack(
        children: [
          Positioned(
             top: screenHeight * (55 / 800),
             left: screenWidth * (17 / 360),
             child: Opacity(
             opacity: 1, 
             child: Image.asset(
                   'assets/login_icon.png', 
              width: screenWidth * (123.56 / 360),
              height: screenHeight * (15 / 800),
              fit: BoxFit.contain,
             ),
            ),
          ),
          Positioned(
            top: screenHeight* (159.75 / 800),
            left: screenWidth* (50 / 360),
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                  'assets/login_bg.png',
                 width: screenWidth * (300.77 / 360),
                 height: screenHeight* (300.25 / 800),
                 fit: BoxFit.contain,   
                ),
              
            ),
          ),
          
        ],
            ),
          ),
        ),
        
              Expanded(
                flex: 3,
                child: Positioned(
                   top: screenHeight * (394 / 800),
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * (450 / 800),
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
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: const Offset(0, -3),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                          child: Column(
                            children: [
                              Text(
                                'Login to proceed',
                                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Save, Connect, Discover: Your login Perks await!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                              ),
                              const SizedBox(height: 20),
                          
                              Text(
                          'Phone Number',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.red, // red label
                          ),
                              ),
                              const SizedBox(height: 8),
                          
                              TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            const Text(
                            "+91",
                            style: TextStyle(
                           color: Colors.black,
                           fontSize: 24,
                           fontWeight: FontWeight.w500,
                           ),
                           ),
                         const SizedBox(width: 2),
                         const Icon(Icons.arrow_drop_down, color: Colors.black, size: 24),  
                               ],
                       ),

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 2),
                            ),
                            hintText: "Phone Number",
                          ),
                              ),
                          
                              const SizedBox(height: 24),
                          
                              // Login Button
                              SizedBox(
                          width: screenWidth * (342/360),
                          height: screenHeight * (50/800),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF0000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: isLoading ? null : handleLogin,
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                    'Login',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                          ),
                              ),
                          
                              const SizedBox(height: 12),
                          
                              Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'By clicking above you agree to ',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                              Text("Terms & Conditions",style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),)
                            ],
                          ),
                              ),
                          
                              const SizedBox(height: 16),
                          
                              Center(
                          child: Text(
                            'Or login with',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                              ),
                          
                              const SizedBox(height: 8),
                          
                              Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/devicon_google.png', width: 40),
                            const SizedBox(width: 20),
                            Image.asset('assets/Whatsapp.png', width: 40),
                          ],
                              ),
                          
                              const SizedBox(height: 16),
                          
                              Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don’t have an account?",
                                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                                },
                                child: Text(
                  "SignUp",
                  style: GoogleFonts.poppins(
                    color: Colors.red ,// 
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                                ),
                              ),
                            ],
                          ),
                              ),
                            ],
                          ),
                          
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
