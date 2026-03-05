import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_links/app_links.dart';
import 'package:zencare/common/Toast.dart';
import 'package:zencare/common/appbar.dart';
import 'package:zencare/common/footer.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/features/auth/login_page.dart';
import 'package:zencare/services/auth_service.dart';
import 'package:zencare/services/serviceable_areas_service.dart';
import 'package:http/http.dart' as http;
import '../controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}
int selectedPaymentMethod = 1;
class _ShoppingCartState extends State<ShoppingCart> {
  List<dynamic> cartItems = [];
  late AppLinks _appLinks;
  StreamSubscription? _sub;
  List<ServiceableArea> _serviceableAreas = [];
  bool _loadingAreas = true;
  String? _selectedServiceablePincode;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    initDeepLinks();
    _loadServiceableAreas();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CartData>(context, listen: false).loadCartData();
    });
  }

  Future<void> _loadServiceableAreas() async {
    final list = await fetchServiceableAreas();
    if (mounted) setState(() {
      _serviceableAreas = list;
      _loadingAreas = false;
      if (list.isNotEmpty && _selectedServiceablePincode == null) {
        _selectedServiceablePincode = list.first.pincode;
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  // Helper method to determine if we're on mobile
  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _isMobile(context) ? 10.0 : 20.0,
                vertical: _isMobile(context) ? 20.0 : 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Responsive layout: Stack vertically on mobile, side by side on tablet+
                  _isMobile(context)
                      ? Column(
                    children: [
                      _buildLoginAndBillingSection(context),
                      SizedBox(height: 20),
                      _buildOrderSummary(context),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SafeArea(
                          child: _buildLoginAndBillingSection(context),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 2,
                        child: _buildOrderSummary(context),
                      ),
                    ],
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

  Widget _buildOrderSummary(BuildContext context) {
    final cartData = Provider.of<CartData>(context);
    List<Map<String, String>> cartItems = cartData.selectedPackages;
    double totalPrice = cartItems.fold(
        0, (sum, item) => sum + double.parse(item['price'] ?? '0'));

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: _isMobile(context) ? 20.0 : 60.0,
      ),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(_isMobile(context) ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Order',
                style: _isMobile(context)
                    ? Theme.of(context).textTheme.headlineSmall
                    : Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 16),
              if (cartItems.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No items in cart',
                      style: _isMobile(context)
                          ? Theme.of(context).textTheme.bodyLarge
                          : Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                )
              else
                ...cartItems.map((item) => _buildOrderItem(item)).toList(),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Total: ',
                        style: _isMobile(context)
                            ? Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)
                            : Theme.of(context).textTheme.displayMedium),
                    Text('\₹${totalPrice.toStringAsFixed(2)}',
                        style: _isMobile(context)
                            ? Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)
                            : Theme.of(context).textTheme.displayMedium),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Payment',
                style: _isMobile(context)
                    ? Theme.of(context).textTheme.titleLarge
                    : Theme.of(context).textTheme.displayMedium,
              ),
              _buildPaymentOptions(),
              Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  left: _isMobile(context) ? 0 : 15,
                ),
                child: SizedBox(
                  width: _isMobile(context) ? double.infinity : null,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty ? null : () async {
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      var isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
                      isLoggedIn ? _placeOrder() : _showLoginPrompt();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      padding: EdgeInsets.all(_isMobile(context) ? 16.0 : 8.0),
                    ),
                    child: Text(
                      'Place an Order',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontSize: _isMobile(context) ? 16 : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    ToastMessage().toastMessage('Proceeding to checkout..');
    initiatePayment();
  }

  String generateRandomOrderId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    // Generate a random 30-character string
    String randomString = List.generate(
        30, (index) => chars[random.nextInt(chars.length)])
        .join();

    // Insert underscores every 10 characters
    return '${randomString.substring(0, 10)}_${randomString.substring(10, 20)}_${randomString.substring(20)}';
  }

void initiatePayment() async {
  // Get cart data to calculate total amount
  final cartData = Provider.of<CartData>(context, listen: false);
  List<Map<String, String>> cartItems = cartData.selectedPackages;
  
  // Calculate total price from cart items
  double totalPrice = cartItems.fold(
    0, (sum, item) => sum + double.parse(item['price'] ?? '0')
  );
  
  // Generate a random Order ID
  String orderId = generateRandomOrderId();
  
  print('=== Payment Request Debug ===');
  print('Generated Order ID: $orderId');
  print('Total Amount: ₹$totalPrice');
  print('Request Method: POST');
  print('===========================');

  try {
    // IMPORTANT: This is a POST request, not GET!
    final headers = await AuthService.authHeaders();
    headers['Accept'] = 'application/json';
    final body = {
      'orderId': orderId,
      'amount': totalPrice.toStringAsFixed(2),
    };
    final pincode = _selectedServiceablePincode;
    if (pincode != null) {
      body['pincode'] = pincode;
    }
    final response = await http.post(
      Uri.parse(ApiConfig.payments),
      headers: headers,
      body: json.encode(body),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // API format: success, payment_url, transaction_id (payments.php / PhonePe v2)
      final bool success = data['success'] == true;
      final String? paymentUrl = data['payment_url'] ?? data['redirectUrl'];
      final String? txnId = data['transaction_id'] ?? data['orderId'] ?? orderId;

      if (success && paymentUrl != null && paymentUrl.isNotEmpty) {
        print('Transaction ID: $txnId');
        print('Redirect URL: $paymentUrl');
        print('Amount: ₹$totalPrice');

        final Uri paymentUri = Uri.parse(paymentUrl);

        bool launched = await launchUrl(
          paymentUri,
          mode: LaunchMode.externalApplication,
        );

        if (launched) {
          print('Successfully launched payment gateway');
          ToastMessage().toastMessage('Redirecting to payment gateway...');
        } else {
          print('Could not launch payment URL');
          ToastMessage().toastMessage('Unable to open payment gateway');
        }
      } else if (data.containsKey('state') && data.containsKey('redirectUrl')) {
        // Legacy: state + redirectUrl
        String state = data['state'];
        String redirectUrl = data['redirectUrl'];
        if (state == 'PENDING') {
          bool launched = await launchUrl(
            Uri.parse(redirectUrl),
            mode: LaunchMode.externalApplication,
          );
          if (launched) {
            ToastMessage().toastMessage('Redirecting to payment gateway...');
          } else {
            ToastMessage().toastMessage('Unable to open payment gateway');
          }
        } else {
          ToastMessage().toastMessage('Payment status: $state');
        }
      } else {
        String errorMessage = data['error'] ?? data['message'] ?? 'Payment initialization failed';
        ToastMessage().toastMessage(errorMessage);
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
      print('Error Body: ${response.body}');

      try {
        var errorData = json.decode(response.body);
        String errorMessage = errorData['message'] ?? 'Server error: ${response.statusCode}';
        
        // Print debug info if available
        if (errorData.containsKey('debug')) {
          print('=== Server Debug Info ===');
          print(json.encode(errorData['debug']));
          print('========================');
        }
        
        ToastMessage().toastMessage(errorMessage);
      } catch (e) {
        ToastMessage().toastMessage('Server error: ${response.statusCode}');
      }
    }
  } catch (e, stackTrace) {
    print('Exception during payment initiation: $e');
    print('Stack trace: $stackTrace');
    ToastMessage().toastMessage('Network error. Please check your connection.');
  }
}

  Widget _buildOrderItem(Map<String, String> item) {
    final cartData = Provider.of<CartData>(context, listen: false);
    int index = cartData.selectedPackages.indexOf(item);

    // Add null-safe access with default values
    final title = item['title'] ?? 'Unknown Item';
    final price = item['price'] ?? '0';
    final priceValue = double.tryParse(price) ?? 0.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: _isMobile(context)
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,  // Use the null-safe variable
                  style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 20,
                ),
                onPressed: () {
                  _showDeleteConfirmation(context, index);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quantity: x${1}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '\₹${(priceValue * 1).toStringAsFixed(2)}',  // Use the null-safe variable
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(height: 20),
        ],
      )
          : ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        title: Text(
          title,  // Use the null-safe variable
          style: Theme.of(context).textTheme.displayMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'x${1}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(width: 30),
            Text(
              '\₹${(priceValue * 1).toStringAsFixed(2)}',  // Use the null-safe variable
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(width: 30),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: MediaQuery.of(context).size.width > 800 ? 30 : 15,
              ),
              onPressed: () {
                _showDeleteConfirmation(context, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Remove Item',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to remove this item from cart?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.purple,
                      side: BorderSide(color: Colors.purple, width: 1.5),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final cartData = Provider.of<CartData>(context, listen: false);
                      cartData.removePackage(index);
                      Navigator.of(dialogContext).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }



  Future<void> confirmPayment(String txnId) async {
    final headers = await AuthService.authHeaders();
    final response = await http.post(
      Uri.parse(ApiConfig.paymentConfirmation),
      headers: headers,
      body: json.encode({"transactionId": txnId}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        if (data['state'] == "SUCCESS") {
          print(" Payment successful");
        } else if (data['state'] == "PENDING") {
          print(" Payment pending");
        } else {
          print(" Payment failed");
        }
      } else {
        print("Error: ${data['message']}");
      }
    } else {
      print("Server error: ${response.statusCode}");
    }
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Direct Bank Transfer',
            style: _isMobile(context)
                ? Theme.of(context).textTheme.bodyLarge
                : Theme.of(context).textTheme.displayMedium,
          ),
          leading: Radio(
            value: 1,
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value as int;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Online Gateway',
            style: _isMobile(context)
                ? Theme.of(context).textTheme.bodyLarge
                : Theme.of(context).textTheme.displayMedium,
          ),
          leading: Radio(
            value: 2,
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value as int;
              });
            },
          ),
        ),
      ],
    );
  }

  void _showLoginPrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: _isMobile(context)
              ? MediaQuery.of(context).size.width * 0.9
              : 300,
          child: AlertDialog(
            title: Text('Login Required',
                style: Theme.of(context).textTheme.displayMedium),
            content: Text(
              'Please log in to place your order.',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigate to the login screen
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LoginDialog();
                    },
                  );
                },
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.pink,
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginAndBillingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Login Section

        // Billing Details
        Padding(
          padding: EdgeInsets.all(_isMobile(context) ? 8.0 : 10.0),
          child: Text(
            'Billing Details',
            style: _isMobile(context)
                ? Theme.of(context).textTheme.titleLarge
                : Theme.of(context).textTheme.labelLarge,
          ),
        ),
        _buildBillingDetailsForm(),
      ],
    );
  }

  Widget _buildBillingDetailsForm() {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(_isMobile(context) ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Create responsive grid for mobile
            if (_isMobile(context)) ...[
              _buildTextField('First Name *'),
              _buildTextField('Last Name *'),
              _buildTextField('Address *'),
              _buildTextField('Address Line 2'),
              _buildServiceableAreaField(context),
              _buildTextField('Phone *'),
              _buildTextField('Company Name'),
              _buildTextField('Email Address *'),
              _buildTextField('Additional Information', maxLines: 3),
            ] else ...[
              // Original layout for tablet and desktop
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('First Name *'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Last Name *'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Address *'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Address Line 2'),
                ),
              ),
              _buildServiceableAreaField(context, isDesktop: true),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Phone *'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Company Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Email Address *'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: _inputDecoration('Additional Information'),
                  maxLines: 3,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildServiceableAreaField(BuildContext context, {bool isDesktop = false}) {
    final padding = isDesktop ? const EdgeInsets.all(8.0) : const EdgeInsets.only(bottom: 16.0);
    Widget child;
    if (_loadingAreas) {
      child = InputDecorator(
        decoration: _inputDecoration('Serviceable Area'),
        child: const SizedBox(height: 20, child: LinearProgressIndicator()),
      );
    } else if (_serviceableAreas.isEmpty) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Serviceable Area (approved zones)', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Expanded(child: Text('Could not load areas. Check connection.', style: TextStyle(fontSize: 13, color: Colors.grey.shade600))),
              TextButton(onPressed: _loadServiceableAreas, child: const Text('Retry')),
            ],
          ),
        ],
      );
    } else {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Serviceable Area (approved zones)', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          DropdownButtonFormField<String>(
            value: _selectedServiceablePincode,
            decoration: _inputDecoration('Select area (Name - Pincode)'),
            isExpanded: true,
            items: _serviceableAreas.map((a) => DropdownMenuItem(value: a.pincode, child: Text(a.label, overflow: TextOverflow.ellipsis))).toList(),
            onChanged: (v) => setState(() => _selectedServiceablePincode = v),
          ),
        ],
      );
    }
    return Padding(padding: padding, child: child);
  }

  // Helper widget for mobile text fields
  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: _inputDecoration(label),
        maxLines: maxLines,
      ),
    );
  }

  // Method to create a bordered and rounded InputDecoration
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelStyle: _isMobile(context)
          ? Theme.of(context).textTheme.bodyMedium
          : Theme.of(context).textTheme.displayMedium,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.pink),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: _isMobile(context) ? 16.0 : 12.0,
      ),
    );
  }

  void initDeepLinks() {
    _sub = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri == null) return;
      if (uri.host != "payment-response") return;

      final txnId = uri.queryParameters['transactionId'] ?? uri.queryParameters['txn'] ?? '';
      final merchantId = uri.queryParameters['merchantId'] ?? '';
      final respCode = uri.queryParameters['responseCode'] ?? '';

      print("PhonePe Redirect: txn=$txnId, merchant=$merchantId, code=$respCode");

      if (txnId.isEmpty) {
        _showPaymentCancelledDialog();
        return;
      }
      confirmPayment(txnId);
    });
  }

  void _showPaymentCancelledDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.cancel, color: Colors.orange, size: 30),
              SizedBox(width: 10),
              Text(
                'Payment Cancelled',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: Text(
            'Your payment was cancelled. Would you like to try again?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/',
                  (route) => false,
                );
              },
              child: Text(
                'Go to Home',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
              ),
              child: Text(
                'Try Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}