import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp_home_page.dart';
import 'package:whatsapp/verification_code_page.dart';
import 'package:whatsapp/registration_page.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
        builder: (_) => RegistrationPage(onRegistrationComplete: args as void Function()?),
      );
    case '/verify':
      if (args is String) {
        return MaterialPageRoute(
          builder: (_) => VerificationCodePage(verificationId: args),
        );
      }
      break;
    case '/home':
      if (args is Map<String, dynamic>) { // Check if args is a map of dynamic type
        return MaterialPageRoute(
          builder: (_) => WhatsAppHomePage(
            userId: args['firstName'], // Pass the userId here (you can use 'firstName' or any other key you prefer)
          ),
        );
      }
      break;
  }

  return null; // Default route when the named route is not found
}
