import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home screen.dart';
import '../login/login screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User already logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        // User not logged in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff0f172a),
      body: Center(
        child: Text(
          'SHREYASH',
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
