import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'on_generate_routes.dart';
import 'whatsapp_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WhatsAppApp());
}

class WhatsAppApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF25D366)),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
