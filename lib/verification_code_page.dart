import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registration_page.dart';
import 'whatsapp_home_page.dart';

class VerificationCodePage extends StatefulWidget {
  final String? verificationId;

  VerificationCodePage({required this.verificationId});

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _verificationCodeController = TextEditingController();

  void _submitVerificationCode(BuildContext context) async {
    String verificationCode = _verificationCodeController.text.trim();

    if (verificationCode.isNotEmpty) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId!,
        smsCode: verificationCode,
      );

      try {
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        // Authentication successful, handle navigation or other actions
        print("User signed in: ${userCredential.user?.phoneNumber}");
        // Navigate to the next screen or perform necessary actions
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
          arguments: userCredential.user?.uid, // Pass the userId here
        );
      } on FirebaseAuthException catch (e) {
        // Handle authentication errors
        print("Authentication failed: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Authentication failed: ${e.message}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Enter Verification Code',
            style: TextStyle(
              color: Color(0xFF075e54),
              fontWeight: FontWeight.bold,
            )
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Verification Code',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitVerificationCode(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
