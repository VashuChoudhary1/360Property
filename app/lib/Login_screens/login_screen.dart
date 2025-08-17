import 'package:app/Login_screens/signup_screen.dart';
import 'package:app/Login_screens/verify_screen.dart';
import 'package:app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  Future<void> handleLogin() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    setState(() => isLoading = true);
    
    try {
      final isRegistered = await AuthService.isUserRegistered(phone);
      setState(() => isLoading = false);

      if(!isRegistered){
        setState(()=> isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Number is not registered"))
        );
        Navigator.push(context, 
        MaterialPageRoute(builder: (context) => const SignupScreen(),),);
        return;
      }

    final token = await AuthService.sendOtp(phone, '+91');

    setState(() => isLoading = false);

    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyScreen(token:token),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send OTP. Try again.')),
      );
    }
  }
  catch (e) {
    setState(() => isLoading = false);
    debugPrint('Error during OTP request: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Something went wrong: $e')),
    );
  }
}

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
