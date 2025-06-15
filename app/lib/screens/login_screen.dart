import 'package:app/screens/signup_screen.dart';
import 'package:app/screens/verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 33, 33),
      body: SafeArea(
        child: Column(
          children: [
            // Top Illustration
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                child: Image.asset(
                  'assets/login_bg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Login Card
            SingleChildScrollView(
              child: Expanded(
                flex: 3,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login to proceed',
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Phone Number',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      CustomTextField(
                        hintText: '+91 Phone Number',
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                      ),
                      const SizedBox(height: 20),

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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifyScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // OR Sign In
                      Center(
                        child: Text(
                          'Or sign in with',
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Google & Apple Buttons
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
                              "Don’t have account?",
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen(),
                                    ));
                              },
                              child: Text(
                                " Sign up",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFF0000),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
