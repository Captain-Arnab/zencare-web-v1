import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:zencare/features/Home/screens/about_us.dart';
import 'package:zencare/features/Home/screens/contact_us.dart';
import 'package:zencare/features/Home/screens/home.dart';
import 'package:zencare/features/Services/screens/AC_Services.dart';
import 'package:zencare/features/Services/screens/ChimneyRepair.dart';
import 'package:zencare/features/Services/screens/CleaningServices.dart';
import 'package:zencare/features/Services/screens/PestControl.dart';
import 'package:zencare/features/Services/screens/RefrigeratorServices.dart';
import 'package:zencare/features/Services/screens/WashingMachineServices.dart';
import 'package:zencare/features/Services/screens/WaterPurifierServices.dart';
import 'package:zencare/features/Services/screens/SalonService.dart';
import 'package:zencare/features/checkout/shopping_cart.dart';
import 'package:zencare/features/controller.dart';
import 'package:zencare/features/policies/privacy_policy.dart';
import 'package:zencare/features/policies/refund_policy.dart';
import 'package:zencare/features/policies/terms_and_conditions.dart';
import 'package:zencare/features/Services/screens/CarpenterService.dart';
import 'package:zencare/features/checkout/payment_response.dart';
import 'package:zencare/features/Partner/partner_registration_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zencare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Feather',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontFamily: 'archivo', fontSize: 18, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(
              fontFamily: 'archivo', fontSize: 14, fontWeight: FontWeight.w400),
          displayMedium: TextStyle(
              fontFamily: 'archivo', fontSize: 16, fontWeight: FontWeight.w300),
          titleLarge: TextStyle(
              fontFamily: 'archivo', fontSize: 20, fontWeight: FontWeight.bold),
          labelLarge: TextStyle(
              fontFamily: 'archivo', fontSize: 30, fontWeight: FontWeight.bold),
          labelMedium: TextStyle(
              fontFamily: 'archivo', fontSize: 24, fontWeight: FontWeight.w500),
          titleMedium: TextStyle(
              fontFamily: 'archivo',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
          displayLarge: TextStyle(
              fontFamily: 'archivo', fontSize: 42, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(
              fontFamily: 'archivo', fontSize: 20, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(
              fontFamily: 'archivo', fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/about-us': (context) => AboutUs(),
        '/contact-us': (context) => ContactUs(),
        '/ac-services': (context) => const ACService(),
        '/refrigerator-services': (context) => const RefrigeratorServices(),
        '/cleaning': (context) => const CleaningServices(),
        '/salon': (context) => const SalonService(isWomenSalon: true),
        '/pest-control': (context) => const PestControl(),
        '/washing-machine': (context) => const WashingMachineServices(),
        '/water-purifier': (context) => const WaterPurifierService(),
        '/chimney-repair': (context) => const ChimneyRepairServices(),
        '/shopping-cart': (context) => const ShoppingCart(),
        '/refund-policy': (context) => RefundPolicy(),
        '/terms-and-conditions': (context) => TermsAndConditions(),
        '/privacy-policy': (context) => PrivacyPolicy(),
        '/carpenter-service': (context) => const CarpenterService(),
        '/payment-response': (context) => const PaymentResponsePage(),
        '/partner-registration': (context) => const PartnerRegistrationPage(),
      },
    );
  }
}
