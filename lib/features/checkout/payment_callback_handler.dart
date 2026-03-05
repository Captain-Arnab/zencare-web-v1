import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zencare/core/api_config.dart';
import 'package:zencare/utils/url_utils.dart';
import 'package:zencare/common/Toast.dart';

/// Runs on app load: if URL has ?payment=success|failed&txn=ORDER_ID (from
/// payment_callback.php redirect), calls paymentConfirmation on success,
/// navigates to Order history and shows message; on failed shows message and
/// keeps cart. Then clears URL params so refresh does not re-trigger.
class PaymentCallbackHandler extends StatefulWidget {
  const PaymentCallbackHandler({super.key, required this.child});

  final Widget child;

  @override
  State<PaymentCallbackHandler> createState() => _PaymentCallbackHandlerState();
}

class _PaymentCallbackHandlerState extends State<PaymentCallbackHandler> {
  bool _handling = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkPaymentCallback());
  }

  Future<void> _checkPaymentCallback() async {
    final params = Uri.base.queryParameters;
    final payment = params['payment'];
    final txn = params['txn']?.trim() ?? '';

    if (payment == null || payment.isEmpty) return;
    if (payment != 'success' && payment != 'failed') return;

    if (!mounted) return;
    setState(() => _handling = true);

    if (payment == 'success' && txn.isNotEmpty) {
      try {
        final uri = Uri.parse(ApiConfig.paymentConfirmation).replace(
          queryParameters: {'transactionId': txn},
        );
        final response = await http.get(uri);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final state = data['state']?.toString() ?? '';
          if (state == 'SUCCESS' || state == 'COMPLETED') {
            clearPaymentParamsFromUrl();
            if (!mounted) return;
            Navigator.of(context).pushNamed('/order-history');
            ToastMessage().toastMessage('Payment successful');
          } else {
            clearPaymentParamsFromUrl();
            if (!mounted) return;
            _showSnackBar('Payment status: $state', isError: false);
          }
        } else {
          clearPaymentParamsFromUrl();
          if (!mounted) return;
          _showSnackBar('Could not verify payment. Check Order history.', isError: true);
        }
      } catch (e) {
        clearPaymentParamsFromUrl();
        if (!mounted) return;
        _showSnackBar('Payment verification failed. Check Order history.', isError: true);
      }
    } else if (payment == 'failed') {
      clearPaymentParamsFromUrl();
      if (!mounted) return;
      _showSnackBar('Payment failed. Your cart has been kept.', isError: true);
    } else {
      // success but no txn
      clearPaymentParamsFromUrl();
    }

    if (mounted) setState(() => _handling = false);
  }

  void _showSnackBar(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_handling) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Verifying payment...',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    return widget.child;
  }
}
