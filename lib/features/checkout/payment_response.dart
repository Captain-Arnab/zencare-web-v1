import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zencare/core/api_config.dart';
import 'package:zencare/services/auth_service.dart';

class PaymentResponsePage extends StatefulWidget {
  const PaymentResponsePage({super.key});

  @override
  State<PaymentResponsePage> createState() => _PaymentResponsePageState();
}

class _PaymentResponsePageState extends State<PaymentResponsePage> {
  bool _isLoading = true;
  String _status = 'pending';
  String _message = 'Verifying payment status...';
  Map<String, dynamic>? _paymentData;

  @override
  void initState() {
    super.initState();
    // Get transaction ID from URL and verify payment
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handlePaymentResponse();
    });
  }

  Future<void> _handlePaymentResponse() async {
    try {
      // Parse URL to get transaction ID
      final uri = Uri.base;
      final transactionId = uri.queryParameters['transactionId'];
      final merchantId = uri.queryParameters['merchantId'];
      
      print('=== Payment Response ===');
      print('Transaction ID: $transactionId');
      print('Merchant ID: $merchantId');
      print('All params: ${uri.queryParameters}');
      print('======================');

      if (transactionId == null || transactionId.isEmpty) {
        setState(() {
          _isLoading = false;
          _status = 'cancelled';
          _message = 'Payment was cancelled or no transaction ID found';
        });
        return;
      }

      // Verify payment status from backend
      await _verifyPaymentStatus(transactionId);
      
    } catch (e) {
      print('Error handling payment response: $e');
      setState(() {
        _isLoading = false;
        _status = 'error';
        _message = 'Error processing payment response';
      });
    }
  }

  Future<void> _verifyPaymentStatus(String transactionId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.paymentConfirmation),
        headers: await AuthService.authHeaders(),
        body: json.encode({
          'transactionId': transactionId,
        }),
      );

      print('Verification Response: ${response.statusCode}');
      print('Verification Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        setState(() {
          _isLoading = false;
          _paymentData = data;
          
          if (data['success'] == true) {
            final state = data['state'] ?? '';
            
            switch (state) {
              case 'SUCCESS':
                _status = 'success';
                _message = 'Payment successful!';
                break;
              case 'FAILED':
                _status = 'failed';
                _message = 'Payment failed. Please try again.';
                break;
              case 'PENDING':
                _status = 'pending';
                _message = 'Payment is still being processed.';
                break;
              default:
                _status = 'cancelled';
                _message = 'Payment was cancelled.';
            }
          } else {
            _status = 'error';
            _message = data['message'] ?? 'Unable to verify payment status';
          }
        });
      } else {
        setState(() {
          _isLoading = false;
          _status = 'error';
          _message = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      print('Error verifying payment: $e');
      setState(() {
        _isLoading = false;
        _status = 'error';
        _message = 'Network error. Please check your connection.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment Status'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: _isLoading
            ? _buildLoadingView()
            : _buildStatusView(),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text(
          'Verifying payment...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusView() {
    IconData icon;
    Color color;

    switch (_status) {
      case 'success':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'failed':
        icon = Icons.error;
        color = Colors.red;
        break;
      case 'cancelled':
        icon = Icons.cancel;
        color = Colors.orange;
        break;
      case 'pending':
        icon = Icons.access_time;
        color = Colors.blue;
        break;
      default:
        icon = Icons.warning;
        color = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
            color: color,
          ),
          SizedBox(height: 24),
          Text(
            _message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          if (_paymentData != null) ...[
            Text(
              'Transaction ID: ${_paymentData!['merchantTransactionId'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            if (_paymentData!['amount'] != null)
              Text(
                'Amount: ₹${(_paymentData!['amount'] / 100).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
          ],
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              _status == 'success' ? 'Go to Home' : 'Try Again',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}