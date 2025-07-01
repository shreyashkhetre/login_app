import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../home screen.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String verificationId;

  const OTPScreen({super.key, required this.phone, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f172a),
      appBar: AppBar(
        title: const Text("Enter OTP"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              "We've sent an OTP to your phone",
              style: TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              onChanged: (val) => otp = val,
              onCompleted: (val) => otp = val,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.black26,
                inactiveFillColor: Colors.black12,
                selectedFillColor: const Color(0xff1e40af),
              ),
              enableActiveFill: true,
              textStyle: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: otp,
                  );

                  await FirebaseAuth.instance.signInWithCredential(credential);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login successful")));
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP")));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff38bdf8),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: const Text("Verify OTP", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
