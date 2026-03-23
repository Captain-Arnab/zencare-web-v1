import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/core/play_review_config.dart';
import 'package:zencare/services/auth_service.dart';

/// Shows OTP dialog for login. [password] is optional; if provided, Resend OTP will re-request OTP via phone+password.
void showOtpDialog(BuildContext context, String phone, {String? password, String? fromPage, Map<String, dynamic>? appointmentDetails}) {
  TextEditingController otpController = TextEditingController();

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Enter OTP', style: Theme.of(dialogContext).textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('A 6-digit verification code has been sent to $phone'),
            SizedBox(height: 20),
            PinCodeTextField(
              controller: otpController,
              highlightColor: Colors.blue,
              highlightAnimation: true,
              highlightAnimationBeginColor: Colors.white,
              highlightAnimationEndColor: Colors.blue,
              pinBoxRadius: 5,
              pinBoxHeight: 50,
              pinBoxWidth: 45,
              pinBoxColor: Colors.grey.shade200,
              pinBoxBorderWidth: 0.5,
              maxLength: 6,
              hasTextBorderColor: Colors.transparent,
              autofocus: true,
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => resendOtp(dialogContext, phone, password: password),
                child: Text('Resend OTP', style: Theme.of(dialogContext).textTheme.bodyMedium!.copyWith(decoration: TextDecoration.underline, color: Colors.grey[600])),
              ),
            ),
          ],
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(dialogContext).size.width * 0.2,
              height: 50,
              child: ElevatedButton(
                onPressed: () => confirmLoginOtp(dialogContext, phone, otpController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Verify', style: Theme.of(dialogContext).textTheme.bodyLarge!.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> resendOtp(BuildContext context, String phone, {String? password}) async {
  if (password == null || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please log in again with phone and password to request a new OTP.')));
    return;
  }
  try {
    final response = await http.post(
      Uri.parse(ApiConfig.login),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phone': phone.trim(), 'password': password}),
    );
    final data = json.decode(response.body) as Map<String, dynamic>? ?? {};
    final status = data['status']?.toString();
    final isSuccess = (data['statusCode'] == 200 || data['statusCode'] == '200') && status == 'otp_sent';
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(data['message']?.toString() ?? (isSuccess ? 'OTP sent again.' : 'Failed to resend OTP.'))),
    );
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Network error. Please try again.')));
    }
  }
}

/// Verify OTP and complete login. login.php returns token, user (id, first_name, last_name, email, phone, address, photo, status), expires_in_hours.
void confirmLoginOtp(BuildContext context, String phone, String otp) async {
  final trimmedOtp = otp.trim();
  if (trimmedOtp.isEmpty || trimmedOtp.length != 6) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid 6-digit OTP')));
    return;
  }

  try {
    final response = await http.post(
      Uri.parse(ApiConfig.login),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'phone': phone.trim(), 'otp': trimmedOtp}),
    );
    final data = json.decode(response.body) as Map<String, dynamic>? ?? {};
    final statusCode = data['statusCode'];
    final status = data['status']?.toString();
    final isSuccess = (statusCode == 200 || statusCode == '200') && status == 'success';

    if (isSuccess) {
      // Store token from login response; same token is sent as ?token=... for check_session.php (GET)
      final token = data['token']?.toString();
      final user = data['user'];
      String userId = '';
      String userName = '';
      Map<String, dynamic>? userProfile;

      if (user is Map<String, dynamic>) {
        userProfile = user;
        userId = (user['id'] ?? user['ID'])?.toString() ?? '';
        final first = user['first_name']?.toString() ?? '';
        final last = user['last_name']?.toString() ?? '';
        userName = '$first $last'.trim();
        if (userName.isEmpty) userName = user['email']?.toString() ?? user['phone']?.toString() ?? 'User';
      }

      if (token != null && token.trim().isNotEmpty) {
        await AuthService.saveLogin(token: token.trim(), userId: userId, userName: userName, userProfile: userProfile);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']?.toString() ?? 'Login successful.'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      if (PlayReviewConfig.matchesReviewerOtp(phone, trimmedOtp) && context.mounted) {
        await PlayReviewConfig.completeReviewSessionAndGoHome(context);
        return;
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message']?.toString() ?? 'Invalid OTP. Please try again.'), backgroundColor: Colors.red),
        );
      }
    }
  } catch (e) {
    if (PlayReviewConfig.matchesReviewerOtp(phone, trimmedOtp) && context.mounted) {
      await PlayReviewConfig.completeReviewSessionAndGoHome(context);
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Network error. Please try again.'), backgroundColor: Colors.red));
    }
  }
}
