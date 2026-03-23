import 'package:flutter/material.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return ZenCareScaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'TERMS AND CONDITIONS',
                      style: Theme.of(context).textTheme.headlineSmall, // For the main title
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to Zen Care! These Terms and Conditions ("Terms") govern the access, use, and '
                        'services offered by Zen Care through its website, mobile application, and offline operations. By '
                        'accessing, browsing, or using Zen Care’s services, you ("User" or "Customer") agree to comply '
                        'with these Terms. If you do not agree to these Terms, you must discontinue the use of Zen Care\'s '
                        'services immediately.',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '1. DEFINITIONS',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'For the purposes of this Agreement:\n'
                          '1. "Zen Care" refers to the brand and its parent company, affiliates, and subsidiaries.\n'
                          '2. "User" or "Customer" refers to any individual or entity accessing or availing services '
                          'through Zen Care.\n'
                          '3. "Service Provider" refers to third-party professionals or businesses offering services '
                          'through Zen Care.\n'
                          '4. "Platform" refers to the Zen Care website, mobile application, and other digital mediums '
                          'facilitating service bookings.\n'
                          '5. "Services" include, but are not limited to, salon, spa, AC repair, refrigerator repair, home '
                          'cleaning, pest control, carpentry, interior design, and water purifier installation and '
                          'maintenance.\n'
                          '6. "Agreement" refers to these Terms and Conditions and any additional policies published by Zen Care.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '2. ELIGIBILITY CRITERIA',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Users must be at least 18 years of age to access and avail of Zen Care’s services.\n'
                          '2. Users must be legally competent under the Indian Contract Act, 1872 to enter into a '
                          'binding contract.\n'
                          '3. Zen Care reserves the right to refuse service to any individual or entity at its discretion.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '3. REGISTRATION & ACCOUNT MANAGEMENT',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '3.1  Account Creation\n'
                          '1. Users may need to register and create an account to book services.\n'
                          '2. Users must provide accurate, complete, and up-to-date information during registration.\n'
                          '3. Zen Care reserves the right to suspend or terminate accounts with incorrect or fraudulent '
                          'information.\n\n'
                          '3.2  User Responsibilities\n'
                          '1. Users must maintain the confidentiality of their login credentials.\n'
                          '2. Users are responsible for all activities conducted through their account.\n'
                          '3. Users must immediately notify Zen Care in case of unauthorized access or security breaches.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '4. SERVICE TERMS',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\n4.1 Booking & Scheduling\n'
                          '1. Services must be booked through the Zen Care platform (website/app).\n'
                          '2. Service availability is subject to location, service provider availability, and operational '
                          'feasibility.\n\n'
                          '4.2 Pricing & Payment\n'
                          '1. Service charges are displayed on the platform and are inclusive of applicable GST '
                          'under The CGST Act, 2017.\n'
                          '2. Payment options include:\n'
                          '  ○ Online payment (UPI, net banking, debit/credit cards, wallets).\n'
                          '  ○ Cash-on-delivery (subject to availability).\n'
                          '3. Zen Care reserves the right to modify pricing at any time without prior notice.\n\n'
                          '4.3 Invoicing & Taxes\n'
                          '1. Users receive invoices for all services booked through the platform.\n'
                          '2. GST invoices are provided where applicable under Indian taxation laws.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '5. CANCELLATIONS, REFUNDS & RESCHEDULING',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '5.1 Cancellation Policy\n'
                          '1. Cancellations made 24 hours before the scheduled service will be eligible for a full '
                          'refund.\n'
                          '2. Cancellations within 24 hours of service may be subject to a cancellation fee.\n'
                          '3. In case of no-show by the service provider, a full refund will be processed.\n\n'
                          '5.2 Refund Policy\n'
                          '1. Refunds, if applicable, will be processed within 7 business days via the original '
                          'payment method.\n'
                          '2. Partial refunds may be issued in case of incomplete service delivery.\n\n'
                          '5.3 Rescheduling Policy\n'
                          '1. Users can reschedule services subject to service provider availability.\n'
                          '2. Last-minute rescheduling (within 12 hours of service) may attract additional charges.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '6. USER RESPONSIBILITIES',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Users must ensure safe and hygienic premises for service execution.\n'
                          '2. Users shall not abuse, harass, or exploit service providers in any manner.\n'
                          '3. Users shall not engage in fraudulent activities such as multiple refunds or false '
                          'complaints.\n'
                          '4. Any damages caused by the User’s negligence during service execution shall be the '
                          'User’s responsibility.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '7. SERVICE PROVIDER OBLIGATIONS',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Service providers operate as independent contractors and are not employees of Zen Care.\n'
                          '2. They must adhere to professional ethics and comply with:\n'
                          '  ○ The Shops and Establishments Act (state-wise).\n'
                          '  ○ The Labour Laws (Minimum Wages Act, 1948 & Employees\' Compensation Act, 1923).\n'
                          '3. Service providers must use approved products and equipment while delivering services.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '8. LIABILITY DISCLAIMER',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Zen Care acts as a facilitator and does not assume direct responsibility for the quality of '
                          'services rendered by third-party service providers.\n'
                          '2. Zen Care shall not be held liable for:\n\n'
                          '  ○ Personal injuries due to service provider negligence.\n'
                          '  ○ Property damages caused by service providers (unless proven).\n'
                          '  ○ Delays or service failures due to unforeseen circumstances (force majeure).',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '9. PRIVACY & DATA SECURITY',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Zen Care complies with the Information Technology (Reasonable Security Practices '
                          'and Procedures and Sensitive Personal Data or Information) Rules, 2011.\n'
                          '2. Personal data collected is used solely for service execution and not shared without '
                          'consent.\n'
                          '3. Users can request data deletion as per The Personal Data Protection Bill, 2019 (once '
                          'enacted).',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '10. INTELLECTUAL PROPERTY RIGHTS',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. All content, including trademarks, logos, text, and images, is owned by Zen Care and '
                          'protected under:\n\n'
                          '  ○ The Copyright Act, 1957\n'
                          '  ○ The Trademarks Act, 1999\n\n'
                          '2. Users shall not copy, modify, or redistribute Zen Care’s intellectual property without '
                          'prior written consent.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '11. CONSUMER RIGHTS & DISPUTE RESOLUTION',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Users have the right to file complaints under the Consumer Protection Act, 2019 for '
                          'any unfair trade practices or service deficiencies.\n'
                          '2. Disputes shall be resolved through negotiation and mediation before initiating legal '
                          'action.\n'
                          '3. If unresolved, disputes shall be subject to the exclusive jurisdiction of courts in '
                          'India',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '12. TERMINATION & ACCOUNT SUSPENSION',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Zen Care reserves the right to terminate or suspend user accounts for:\n\n'
                          '  ○ Violation of these Terms.\n'
                          '  ○ Fraudulent or illegal activities.\n'
                          '  ○ Misuse of services or harassment of service providers.\n\n'
                          '2. Terminated accounts shall forfeit all credits, balances, and bookings unless eligible '
                          'under the refund policy.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '13. MODIFICATIONS & UPDATES',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1. Zen Care may revise these Terms at any time without prior notice.\n'
                          '2. Continued use of services post-updates implies acceptance of the revised Terms.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '14. FORCE MAJEURE',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Zen Care shall not be liable for service delays or failures due to unforeseen events including, '
                          'but not limited to, natural disasters, strikes, or government restrictions.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '15. CONTACT INFORMATION',
                    style: Theme.of(context).textTheme.headlineSmall, // For section title
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'For queries, complaints, or support, contact us:\n'
                          'Email: [zencareservices@gmail.com]\n'
                          'Customer Support: [8179550262]',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'By using Zen Care’s services, you acknowledge and agree to these Terms and Conditions.',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
            ),
            Footer()
          ],
        ),
      ),
    );
  }
}