import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayInfo = user?.phoneNumber ?? user?.email ?? 'User';

    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Welcome"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          )
        ],
      ),
      body: Center(
        child: Text(
          "Hello, $displayInfo 👋",
          style: const TextStyle(fontSize: 24, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
