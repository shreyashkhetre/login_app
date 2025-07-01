import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rock/home%20screen.dart';
import 'package:rock/login/otp%20page.dart';
import 'package:rock/login/signup%20screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController(); // phone or email
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
                  "Login",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 30),

                // Email or Phone
                TextFormField(
                  controller: idController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Phone number or email", Icons.person),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter phone number or email';
                    }
                    bool isPhone = RegExp(r'^[0-9]{10}$').hasMatch(value);
                    bool isEmail = value.contains("@");
                    if (!isPhone && !isEmail) {
                      return 'Enter valid email or 10-digit phone number';
                    }
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
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white60,
                      ),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
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
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomeScreen()) );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      } else {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: input, password: password).then((value){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          });
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful')));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
                        }
                      }
                    }

                  },
                  style: _buttonStyle(),
                  child: const Text("Login", style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>SignupScreen())),
                  child: const Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.white70)),
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
