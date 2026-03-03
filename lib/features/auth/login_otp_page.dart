import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/features/Home/screens/home.dart';
import 'package:zencare/services/auth_service.dart';

void showOtpDialog(BuildContext context, String phone, {String? fromPage, Map<String, dynamic>? appointmentDetails}) {
  TextEditingController otpController = TextEditingController();

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Enter OTP', style: Theme.of(context).textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('A verification code has been sent to $phone'),
            SizedBox(height: 20),
            PinCodeTextField(
              controller: otpController,
              highlightColor: Colors.blue,
              highlightAnimation: true,
              highlightAnimationBeginColor: Colors.white,
              highlightAnimationEndColor: Colors.blue,
              pinBoxRadius: 5,
              pinBoxHeight: 50,
              pinBoxWidth: 50,
              pinBoxColor: Colors.grey.shade200,
              pinBoxBorderWidth: 0.5,
              maxLength: 4,
              hasTextBorderColor: Colors.transparent,
              autofocus: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => resendOtp(phone),
                child: Text('Resend OTP', style: Theme.of(context).textTheme.bodyMedium!.copyWith(decoration: TextDecoration.underline,color: Colors.grey[600])),
              ),
            ),
          ],
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 50, // Make the button take full width
              child: ElevatedButton(
                onPressed: () => confirmRegistration(context, phone, otpController.text, fromPage, appointmentDetails),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(
                      vertical: 10), // Increase button height
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Verify',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    },
  );
}

void resendOtp(String phone) {
  // Add logic to resend OTP
  print("Resending OTP to $phone");
}

void confirmRegistration(BuildContext context, String phone, String otp, String? fromPage, Map<String, dynamic>? appointmentDetails) async {
  final trimmedOtp = otp.trim();
  if (trimmedOtp.isEmpty || trimmedOtp.length != 4) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid 4-digit OTP')));
    return;
  }

  var headers = {'Content-Type': 'application/json'};
  var request = http.Request('POST', Uri.parse(ApiConfig.login));
  request.body = json.encode({
    "action": "verify_otp",
    "user_type": "user",
    "phone": phone.trim(),
    "otp": trimmedOtp,
  });
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    final data = json.decode(responseString);

    final statusCode = data['statusCode'];
    final isSuccess = statusCode == 200 || statusCode == '200';

    if (isSuccess) {
      // login.php returns: user (ID), userName (first_name), token, message
      final token = data['token']?.toString();
      final userId = (data['user'] ?? data['user_id'] ?? data['userId'])?.toString();
      final userName = data['userName']?.toString() ?? '';

      if (token != null && token.isNotEmpty) {
        await AuthService.saveLogin(token: token, userId: userId ?? '', userName: userName);
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', userId ?? '');
        await prefs.setString('userName', userName);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login successful.'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Invalid OTP. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network error: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
