import 'package:app/main_screen.dart';
import 'package:flutter/material.dart';

class AgentSignupScreen extends StatefulWidget {
  const AgentSignupScreen({super.key});

  @override
  State<AgentSignupScreen> createState() => _AgentSignupScreenState();
}

class _AgentSignupScreenState extends State<AgentSignupScreen> {
  // TextEditingControllers for each field
  final TextEditingController agentTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController addressProofController = TextEditingController();
  final TextEditingController panCardController = TextEditingController();
  final TextEditingController uploadPanCardController = TextEditingController(); 

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
  void dispose() {
    // Dispose controllers to avoid memory leaks
    agentTypeController.dispose();
    addressController.dispose();
    pinCodeController.dispose();
    addressProofController.dispose();
    panCardController.dispose();
    uploadPanCardController.dispose();
    super.dispose();
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
                child: Image.asset(
                  'assets/verify_screen.png',
                  height: 40,
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
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
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            'Verify your Identity with Aadhaar',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            "Gain buyer's trust and Protected your business",
                             textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                      'Agent Name',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    TextField(
                      controller: agentTypeController,
                      decoration: customInputDecoration('Select Agent Type'),
                    ),
                        const SizedBox(height: 10),
                        const Text(
                      'Full Address',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    TextField(
                      controller: agentTypeController,
                      decoration: customInputDecoration('Address'),
                    ),
                        const SizedBox(height: 10),
                       const Text(
                      'Pin Code',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                    ),
                    TextField(
                      controller: agentTypeController,
                      decoration: customInputDecoration('eg: 440026'),
                    ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                           Column(
                             children: [
                               const Text(
                                                     'Address Proof *',
                                                     style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                                                   ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextField(
                                                                            controller: agentTypeController,
                                                                            decoration: customInputDecoration('Select     v'),
                                                                          ),
                                                    ),
                             ],
                           ),
                           SizedBox(width: 20,),
                    
                    Column(
                             children: [
                               const Text(
                                                     'Address Proof Upload *',
                                                     style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                                                   ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextField(
                                                                            controller: agentTypeController,
                                                                            decoration: customInputDecoration('Choose File'),
                                                                          ),
                                                    ),
                             ],
                           ),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                           Column(
                             children: [
                               const Text(
                                                     'PAN Card No. * *',
                                                     style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                                                   ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextField(
                                                                            controller: agentTypeController,
                                                                            decoration: customInputDecoration('Eg. EWWGF5627F'),
                                                                          ),
                                                    ),
                             ],
                           ),
                           SizedBox(width: 20,),
                    
                    Column(
                             children: [
                               const Text(
                                                     'Upload PAN Card *',
                                                     style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFF0000)),
                                                   ),
                                                    SizedBox(
                                                      width: 100,
                                                      child: TextField(
                                                                            controller: agentTypeController,
                                                                            decoration: customInputDecoration('Choose File'),
                                                                          ),
                                                    ),
                             ],
                           ),

                          ],
                        ),
                       
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                           child: ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  MainScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Verify Now',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                        ),
                      ],
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
