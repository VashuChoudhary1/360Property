import 'package:flutter/material.dart';

class ContactSellerScreen extends StatefulWidget {
  const ContactSellerScreen({super.key});

  @override
  State<ContactSellerScreen> createState() => _ContactSellerScreenState();
}

class _ContactSellerScreenState extends State<ContactSellerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool agreedToTerms = false;
  String agentChoice = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Check availability & more",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Contact", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Lucky", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Seller or owner", style: TextStyle(color: Colors.grey)),
                    Text("+91 **********", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildInputField("Your Name"),
                  const SizedBox(height: 10),
                  _buildInputField("Email"),
                  const SizedBox(height: 10),
                  _buildInputField("Phone Number"),
                  const SizedBox(height: 10),
                  _buildInputField("Tell us what is your best time to connect on call?", maxLines: 3),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Are You a Real Estate Agent?", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                _agentButton("Yes"),
                const SizedBox(width: 12),
                _agentButton("No"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: agreedToTerms,
                  onChanged: (value) {
                    setState(() {
                      agreedToTerms = value!;
                    });
                  },
                ),
                Expanded(
                  child: Wrap(
                    children: const [
                      Text("I agree to 360Property "),
                      Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(" and "),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() && agreedToTerms) {
                    // Show success / handle logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Request Submitted")),
                    );
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Required' : null,
    );
  }

  Widget _agentButton(String label) {
    final selected = agentChoice == label;
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            agentChoice = label;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: selected ? Colors.red : Colors.white,
          side: BorderSide(
              color: selected ? Colors.red : Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          label,
          style: TextStyle(color: selected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
