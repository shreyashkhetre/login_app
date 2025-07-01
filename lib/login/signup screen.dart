import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rock/home%20screen.dart';

import 'otp page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final idController = TextEditingController(); // email or phone
  final passwordController = TextEditingController();


  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),

                // Name
                TextFormField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Full Name", Icons.person),
                  validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 20),

                // Email or Phone
                TextFormField(
                  controller: idController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Phone number or email", Icons.mail),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter email or phone';
                    bool isPhone = RegExp(r'^[0-9]{10}$').hasMatch(value);
                    bool isEmail = value.contains('@');
                    if (!isPhone && !isEmail) return 'Enter valid email or 10-digit phone';
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscure,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Password", Icons.lock).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white60),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (value) => value != null && value.length >= 6
                      ? null
                      : 'Password must be at least 6 characters',
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    final input = idController.text;
                    final password = passwordController.text;
                    final isPhone = RegExp(r'^[0-9]{10}$').hasMatch(input);

                    if (isPhone) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+91$input',
                        verificationCompleted: (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'Error')));
                        },
                        codeSent: (verificationId, resendToken) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                        },
                        codeAutoRetrievalTimeout: (verificationId) {},
                      );
                    } else {
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: input, password: password).then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signup successful')));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
                      }
                    }
                  },
                  style: _buttonStyle(),
                  child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Already have an account? Login", style: TextStyle(color: Colors.white70)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.black26,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff38bdf8),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
