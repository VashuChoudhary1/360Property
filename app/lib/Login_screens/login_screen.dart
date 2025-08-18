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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 33, 33),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'assets/login_bg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 6, // Increased flex to accommodate new fields
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
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: const Offset(0, -3),
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            'Sign in to your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Tab Switcher
                        _buildLoginModeSwitcher(),

                        const SizedBox(height: 20),

                        // Conditional Form Fields
                        if (_currentMode == LoginMode.email)
                          _buildEmailForm()
                        else
                          _buildPhoneForm(),

                        const SizedBox(height: 30),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF0000),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _isLoading ? null : _handleLogin,
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    _currentMode == LoginMode.phone
                                        ? 'Send OTP'
                                        : 'Login',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Social Logins (as per original code)
                        _buildSocialLogins(),

                        const SizedBox(height: 16),

                        _buildSignupRedirect(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoginModeSwitcher() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _currentMode = LoginMode.email;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _currentMode == LoginMode.email
                    ? const Color(0xFFFF0000)
                    : Colors.transparent,
                border: Border.all(color: const Color(0xFFFF0000)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
              ),
              child: Center(
                child: Text(
                  'EMAIL/PASSWORD',
                  style: TextStyle(
                    color: _currentMode == LoginMode.email
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _currentMode = LoginMode.phone;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _currentMode == LoginMode.phone
                    ? const Color(0xFFFF0000)
                    : Colors.transparent,
                border: Border.all(color: const Color(0xFFFF0000)),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
              ),
              child: Center(
                child: Text(
                  'PHONE/OTP',
                  style: TextStyle(
                    color: _currentMode == LoginMode.phone
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('EMAIL ID',
            style: TextStyle(
                color: Color(0xFFFF0000), fontWeight: FontWeight.bold)),
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: customInputDecoration('Eg: example@gmail.com'),
          validator: (v) {
            if (v == null || v.trim().isEmpty) return "Email is required";
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
              return "Enter a valid email";
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text('PASSWORD',
            style: TextStyle(
                color: Color(0xFFFF0000), fontWeight: FontWeight.bold)),
        TextFormField(
          controller: passwordController,
          obscureText: !_isPasswordVisible,
          decoration: customInputDecoration(
            'Enter Password',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return "Password is required";
            if (v.length < 6) return "Password must be at least 6 characters";
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPhoneForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PHONE NUMBER',
            style: TextStyle(
                color: Color(0xFFFF0000), fontWeight: FontWeight.bold)),
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: customInputDecoration('Enter your phone number'),
          validator: (v) {
            if (v == null || v.isEmpty) return "Phone number is required";
            if (!RegExp(r'^\d{10}$').hasMatch(v)) {
              return "Enter a valid 10-digit phone number";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSocialLogins() {
    return Column(
      children: [
        Center(
          child: Text(
            'Or sign in with',
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
      ],
    );
  }

  Widget _buildSignupRedirect() {
    return Center(
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
              "Sign Up",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFF0000),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
