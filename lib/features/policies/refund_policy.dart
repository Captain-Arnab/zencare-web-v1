import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:zencare/common/footer.dart';
import 'package:zencare/common/zen_care_scaffold.dart';

class RefundPolicy extends StatelessWidget {
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
                      'CANCELLATION AND REFUND POLICY',
                      style: _isMobile(context)
                          ? Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )
                          : Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildBodyText(
                    context,
                    'Zen Care ("Company," "we," "us," or "our") strives to provide high-quality services to our '
                    'customers. This Cancellation and Refund Policy outlines the terms governing service '
                    'cancellations, refunds, and rescheduling. \n\n'
                    'By booking a service with Zen Care, you agree to the terms set forth in this policy.',
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '1. CANCELLATION POLICY'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(
                      context, '1.1 Cancellation by Customers'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. Customers may cancel their service booking through the Zen Care website, mobile app, or by contacting customer support.\n'
                    '2. Cancellation requests must be made at least 6 hours before the scheduled service time to be eligible for a full refund.\n'
                    '3. Cancellations made within 6 hours of the service appointment will be subject to a cancellation fee of 30% of the service cost.\n'
                    '4. Cancellations made after the service provider has arrived will not be eligible for a refund.',
                  ),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(
                      context, '1.2 Cancellation by Zen Care'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. Zen Care reserves the right to cancel bookings due to:\n'
                    '   a. Unavailability of service providers.\n'
                    '   b. Unforeseen circumstances (e.g., extreme weather, technical failures).\n'
                    '   c. Fraudulent or suspicious transactions.\n'
                    '2. In such cases, customers will receive a full refund or the option to reschedule the service.',
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '2. REFUND POLICY'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(context, '2.1 Eligibility for Refunds'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    'Refunds will be issued under the following conditions:\n'
                    '1. Service was canceled by Zen Care due to provider unavailability.\n'
                    '2. Service was canceled by the customer at least 6 hours before the scheduled time.\n'
                    '3. The service provider did not show up or failed to complete the service.\n'
                    '4. The service provided was not as described (subject to investigation and customer complaint resolution).',
                  ),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(context, '2.2 Non-Refundable Cases'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    'Refunds will not be issued in the following cases:\n'
                    '1. Customer cancels the service within 6 hours of the scheduled time.\n'
                    '2. Service was completed but did not meet customer expectations (partial compensation may be offered after review).\n'
                    '3. Service provider was denied entry to the premises by the customer.\n'
                    '4. Customer provided incorrect details leading to incomplete or unsatisfactory service.',
                  ),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(context, '2.3 Refund Processing Time'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                      context,
                      '1. Eligible refunds will be credited within 5-7 business days after approval.\n'
                      '2. Refunds will be credited to the original payment method (bank account, UPI, or card).\n'
                      "'3. Processing time may vary depending on the customer's bank or payment gateway.',"),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '3. RESCHEDULING POLICY'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildSubsectionTitle(
                      context, '3.1 Rescheduling by Customers'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    '1. Customers can request to reschedule their booking at least 6 hours before the scheduled time.\n'
                    '2. Rescheduling requests within 6 hours may incur a rescheduling fee of 10% of the service cost.\n'
                    '3. Rescheduling is subject to service provider availability.',
                  ),
                  SizedBox(height: _isMobile(context) ? 12 : 16),
                  _buildSectionTitle(context, '5. CONTACT INFORMATION'),
                  SizedBox(height: _isMobile(context) ? 6 : 8),
                  _buildBodyText(
                    context,
                    'For cancellation, refund, or rescheduling requests, please contact us:\n'
                    '1. Email: zencareservices@gmail.com\n'
                    '2. Customer Support: 8179550262\n\n'
                    'By booking a service with Zen Care, you acknowledge that you have read, understood, and agreed to this Cancellation and Refund Policy.',
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
