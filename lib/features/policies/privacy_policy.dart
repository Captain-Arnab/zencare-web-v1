import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';

class PrivacyPolicy extends StatelessWidget {
  // Helper method to determine if we're on mobile (or Android for consistent layout)
  bool _isMobile(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.android ||
        MediaQuery.of(context).size.width < 768;
  }

  @override
  Widget build(BuildContext context) {
    return ZenCareScaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _isMobile(context) ? 20 : 50,
                vertical: _isMobile(context) ? 15 : 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'PRIVACY POLICY',
                      style: _isMobile(context)
                          ? Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold)
                          : Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildBodyText(
                    context,
                    'Zen Care ("Company," "we," "us," or "our") values your privacy and is committed to protecting '
                    'your personal data. This Privacy Policy outlines how we collect, use, disclose, and safeguard '
                    'your information when you use our website, mobile application, and services.\n\n'
                    'By accessing or using Zen Care services, you agree to this Privacy Policy. If you do not agree, '
                    'please discontinue using our platform.',
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '1. INFORMATION WE COLLECT'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(context, '1.1 Personal Information'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. Identity Information: Name, age, gender, profile picture, and government-issued ID (if required for verification).\n'
                    '2. Contact Information: Email address, phone number, and mailing address.\n'
                    '3. Payment Information: UPI ID, bank account details, and debit/credit card information (processed via secure gateways).',
                  ),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(
                      context, '1.2 Non-Personal Information'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. Device Data: IP address, browser type, operating system, and device information.\n'
                    '2. Usage Data: Browsing activity, pages visited, service preferences, and interactions with the platform.\n'
                    '3. Location Data: GPS or IP-based location tracking for service delivery (only with user consent).',
                  ),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSectionTitle(context, '2. HOW WE COLLECT INFORMATION'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. User Input: When you create an account, book services, or contact customer support.\n'
                    '2. Automated Technologies: Cookies, tracking tools, and analytics software.\n'
                    '3. Third-Party Sources: Social media logins, referral programs, or publicly available data.',
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '3. HOW WE USE YOUR INFORMATION'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. To Provide Services: Processing bookings, connecting you with service providers, and facilitating customer support.\n'
                    '2. To Process Payments: Secure transactions through encrypted payment gateways.\n'
                    '3. To Improve User Experience: Customizing service recommendations based on preferences.\n'
                    '4. To Send Promotions & Updates: Special offers, discounts, and service-related notifications (opt-out available).\n'
                    '5. To Enhance Security & Fraud Prevention: Monitoring suspicious activities and ensuring compliance with legal regulations.\n'
                    '6. To Comply with Legal Obligations: Adhering to The Information Technology Act, 2000 and other applicable Indian laws.',
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '4. CONTACT INFORMATION'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    'For privacy concerns, complaints, or data requests, please contact us:\n'
                    '1. Email: zencareservices@gmail.com\n'
                    '2. Customer Support: 8179550262\n\n'
                    'By using Zen Care, you acknowledge that you have read, understood, and agreed to this Privacy Policy.',
                  ),
                ],
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: _isMobile(context)
          ? Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold)
          : Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildSubsectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: _isMobile(context)
          ? Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600)
          : Theme.of(context).textTheme.displayMedium,
    );
  }

  Widget _buildBodyText(BuildContext context, String text) {
    return Text(
      text,
      style: _isMobile(context)
          ? Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)
          : Theme.of(context).textTheme.displayMedium,
    );
  }
}
