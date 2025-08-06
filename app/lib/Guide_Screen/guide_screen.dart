import 'package:flutter/material.dart';
import 'success_screen.dart';

class ContactExpertScreen extends StatefulWidget {
  const ContactExpertScreen({super.key});

  @override
  State<ContactExpertScreen> createState() => _ContactExpertScreenState();
}

class _ContactExpertScreenState extends State<ContactExpertScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController problemController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Contact Expert', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:Colors.pink
                ),
                child:  Image.asset(
                  "assets/guide_photo.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text("Contact"),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: const [
                    Icon(Icons.phone, color: Colors.red),
                    SizedBox(width: 8),
                    Text("Toll Free: +91 12345 67890"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text("Select Problem"),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                items: ['Option 1', 'Option 2', 'Option 3']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Write your Problem"),
              const SizedBox(height: 8),
              TextFormField(
                controller: problemController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Name"),
              const SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                validator: (value) =>
                    value!.isEmpty ? "Enter your name" : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Phone Number"),
              const SizedBox(height: 8),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? "Enter phone number" : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixText: '+91 ',
                ),
              ),
              const SizedBox(height: 16),
              const Text("Email"),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailController,
                validator: (value) =>
                    value!.isEmpty ? "Enter email" : null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text("I agree to the Terms & Privacy Policy"),
                value: agreeTerms,
                onChanged: (value) {
                  setState(() {
                    agreeTerms = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    if (_formKey.currentState!.validate() && agreeTerms) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuccessScreen()),
                      );
                    }
                  },
                  child:  Text(
                    "Submit Details",
                    style: TextStyle(fontSize: 16, color:Colors.white),
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
