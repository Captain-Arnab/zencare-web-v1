import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/services/auth_service.dart';

//  Modified to accept PHONE for OTP verification
void showEmailOtpDialog(BuildContext context, String phone) {
  TextEditingController otpController = TextEditingController();
  bool isVerifying = false;

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              'Verify Your Mobile Number',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "We've sent a 6-digit OTP to your mobile number via SMS.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[700]),
                ),
                SizedBox(height: 5),
                Text(
                  'Please check your phone',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  controller: otpController,
                  highlightColor: Colors.blue,
                  pinBoxColor: Colors.grey.shade100,
                  pinBoxBorderWidth: 0.5,
                  pinBoxHeight: 50,
                  pinBoxWidth: 45,
                  pinBoxRadius: 8,
                  maxLength: 6,
                  hasTextBorderColor: Colors.transparent,
                  autofocus: true,
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Resending OTP requires re-registration. Please contact support if needed.'),
                        ),
                      );
                    },
                    child: Text(
                      'Resend Code',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[600],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isVerifying
                      ? null
                      : () async {
                    if (otpController.text.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please enter a valid 6-digit OTP')),
                      );
                      return;
                    }

                    setState(() => isVerifying = true);
                    bool verified = await verifyEmailOtp(phone, otpController.text, context);
                    setState(() => isVerifying = false);

                    if (verified) {
                      Navigator.pop(context); // close OTP dialog

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Registration completed successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      //   Navigate to Home and clear all previous routes to force AppBar rebuild
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                            (route) => false, // This removes all previous routes
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isVerifying
                      ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : Text(
                    'Verify OTP',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

//  Verify OTP with phone number (matching your PHP logic)
Future<bool> verifyEmailOtp(String phone, String otp, BuildContext context) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(ApiConfig.register),
    );

    //  Send phone and otp (PHP checks isset($data->otp) first)
    request.body = json.encode({
      "phone": phone.trim(),
      "otp": otp.trim(),
    });
    request.headers.addAll(headers);

    print(' Sending OTP verification: phone=$phone, otp=$otp');

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();

    print(' OTP Verification Status Code: ${response.statusCode}');
    print(' OTP Verification Response: $responseBody');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(responseBody);

      // register.php verify returns: statusCode 200, status "success", user_id, token, message (no userName)
      final statusCode = data['statusCode'];
      final ok = (statusCode == 200 || statusCode == '200') && data['status'] == 'success';
      if (ok) {
        final prefs = await SharedPreferences.getInstance();
        final token = data['token']?.toString();
        final userId = data['user_id']?.toString() ?? data['userId']?.toString();
        final name = data['userName']?.toString() ?? prefs.getString('userName') ?? '';

        if (token != null && token.isNotEmpty) {
          await AuthService.saveLogin(
            token: token,
            userId: userId ?? '',
            userName: name,
          );
        } else {
          await prefs.setBool('isLoggedIn', true);
          if (userId != null) await prefs.setString('userId', userId);
          if (name.isNotEmpty) await prefs.setString('userName', name);
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message'] ?? 'Verification successful'),
              backgroundColor: Colors.green,
            ),
          );
        }
        return true;
      } else {
        // Show error message from server
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message'] ?? 'Verification failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return false;
      }
    } else {
      // Handle HTTP errors (400, 500, etc.)
      try {
        final errorData = json.decode(responseBody);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorData['message'] ?? 'Verification failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
      return false;
    }
  } catch (e) {
    print(' Error verifying OTP: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return false;
  }
}