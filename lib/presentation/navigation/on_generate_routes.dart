import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/pages/whatsapp_home_page.dart';
import 'package:whatsapp/presentation/pages/verification_code_page.dart';
import 'package:whatsapp/presentation/pages/registration_page.dart';
import 'package:whatsapp/presentation/pages/profile_setup_page.dart'; // Import the profile setup page

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
      if (args is Map<String, dynamic>) {
        if (args['isNewUser'] == true) { // Check if the user is a new user (added 'isNewUser' check)
          return MaterialPageRoute(
            builder: (_) => ProfileSetupPage(),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => WhatsAppHomePage(userId: args['userId']),
          );
        }
      }
      break;
  }

  return null;
}
