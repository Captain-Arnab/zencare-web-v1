import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:zencare/core/api_config.dart';
import 'package:zencare/core/play_review_config.dart';
import 'package:zencare/features/auth/login_otp_page.dart';
import 'package:zencare/features/auth/register_page.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();

  userLogin() async {
    final phoneNumber = phone.text.trim();
    final passwordValue = password.text;
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }
    if (passwordValue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password')),
      );
      return;
    }
    if (PlayReviewConfig.matchesReviewerCredentials(phoneNumber, passwordValue)) {
      if (!mounted) return;
      await PlayReviewConfig.completeReviewSessionAndGoHome(context);
      return;
    }
    // login.php: phone + password → send OTP; response status "otp_sent" on success
    final body = {
      'phone': phoneNumber,
      'password': passwordValue,
    };
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.login),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      final responseString = response.body;
      final data = json.decode(responseString) as Map<String, dynamic>? ?? {};
      if (!mounted) return;
      final statusCode = data['statusCode'];
      final status = data['status']?.toString();
      final isSuccess = (statusCode == 200 || statusCode == '200') && status == 'otp_sent';
      String message = data['message']?.toString() ?? (isSuccess ? 'OTP sent.' : 'Request failed.');
      // If server still expects email+password (old API), show a clear message
      if (!isSuccess && message.toLowerCase().contains('email') && message.toLowerCase().contains('password')) {
        message = 'Server expects phone and password for login. Please ensure the API (login.php) is updated to accept phone + password and returns OTP.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      if (isSuccess) {
        Navigator.pop(context);
        showOtpDialog(context, phoneNumber, password: passwordValue);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.all(20), // Add padding for better layout
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3, // 80% of screen width
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize:
                MainAxisSize.min, // Prevent unnecessary height expansion
            children: [
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Text(
                'Login to your account to use our services',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10),
              _buildTextField(phone, "Mobile Number"),
              _buildTextField(password, "Password", obscureText: true),
            ],
          ),
        ),
      ),
      actions: [
        Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 50, // Make the button take full width
                child: ElevatedButton(
                  onPressed: () => userLogin(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    padding: EdgeInsets.symmetric(
                        vertical: 15), // Increase button height
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text('Login',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            signUp
          ],
        ),
      ],
    );
  }

  Widget get signUp => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
            showDialog(context: context, builder: (ctx) => RegisterDialog());
          },
          child: const Text(
            "Don't have an account? Register Now!",
            style: TextStyle(
                fontFamily: 'Nunito',
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                decoration: TextDecoration.underline,
                decorationColor: Colors.grey),
          ),
        ),
      ],
    ),
  );

  Widget _buildTextField(TextEditingController controller, String hintText,
      {bool obscureText = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey[700]),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}
