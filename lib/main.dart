
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rock/login/login%20screen.dart';
import 'package:rock/login/phone%20page.dart';
import 'package:rock/splash/splash%20screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Add firebase_options.dart if using FlutterFire CLI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
