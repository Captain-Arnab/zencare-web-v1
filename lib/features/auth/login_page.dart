import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:zencare/core/api_config.dart';
import 'package:zencare/features/auth/login_otp_page.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController phone = TextEditingController();

  userLogin() async {
    final phoneNumber = phone.text.trim();
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(ApiConfig.login));
    request.body = json.encode({
      "action": "login",
      "user_type": "user",
      "phone": phoneNumber,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    final data = json.decode(responseString);

    if (!mounted) return;
    final statusCode = data['statusCode'];
    final isSuccess = statusCode == 200 || statusCode == '200';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message'] ?? (isSuccess ? 'OTP sent.' : 'Request failed.'))),
    );
    if (isSuccess) {
      Navigator.pop(context);
      showOtpDialog(context, phoneNumber);
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

  Widget signUp = Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {},
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
