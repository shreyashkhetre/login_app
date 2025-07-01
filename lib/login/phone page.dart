/*import 'package:flutter/material.dart';

import 'otp page.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Login with Phone"),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter Your Phone Number",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    prefixText: "+91 ",
                    prefixStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.phone, color: Colors.white),
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    labelStyle: const TextStyle(color: Colors.white70),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter phone number';
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Enter valid 10-digit number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OTPScreen(phone: phoneController.text),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff38bdf8),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Send OTP", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/