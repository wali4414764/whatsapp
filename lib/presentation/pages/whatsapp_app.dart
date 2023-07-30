import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/navigation/on_generate_routes.dart';


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
