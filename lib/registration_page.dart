import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'verification_code_page.dart';
import 'whatsapp_home_page.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onRegistrationComplete;

  RegistrationPage({required this.onRegistrationComplete});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  CountryCode? _selectedCountryCode;

  void _verifyPhoneNumber(BuildContext context) async {
    if (_selectedCountryCode == null || _phoneNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please enter valid phone number and select country code.')),
      );
      return;
    }

    String phoneNumber =
        '${_selectedCountryCode!.dialCode}${_phoneNumberController.text}';

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieval of the verification code completed.
        // Sign the user in (or link the credential) with Firebase.
        await _auth.signInWithCredential(credential);
        print("Verification completed automatically: ${credential.smsCode}");
        _saveRegistrationStatus(); // Save registration status in shared preferences
        widget
            .onRegistrationComplete!(); // Call the callback on successful registration
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure (e.g., invalid phone number).
        print("Verification failed: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification failed: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID to use later.
        // You can show the user a UI to enter the verification code.
        print("Verification code sent to phone");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                VerificationCodePage(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Called when the auto-retrieval timer expires.
        print("Auto-retrieval timer expired");
      },
    );
  }

  void _saveRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRegistered', true);
  }

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus(); // Check registration status when the page is loaded
  }

  void _checkRegistrationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool('isRegistered') ?? false;
    if (isRegistered) {
      // If the user is already registered, redirect to the home page
      widget.onRegistrationComplete!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Verify Your Phone Number',
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WhatsApp will send an SMS message(Carrier charges may apply) to verify your phone number. Enter your country code and phone number:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            CountryCodePicker(
              onChanged: (CountryCode? countryCode) {
                setState(() {
                  _selectedCountryCode = countryCode;
                });
              },
              initialSelection: 'US', // Initial country code selection
              favorite: [
                '+1',
                'US'
              ], // Optional: Add your favorite country codes
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 55),
            ElevatedButton(
              onPressed: () => _verifyPhoneNumber(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),),
              child: Text('Next',),
            ),
            SizedBox(height: 16),
            Text(
              'you must be at least 16 years old to register',
              style: TextStyle(fontSize: 15,color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
