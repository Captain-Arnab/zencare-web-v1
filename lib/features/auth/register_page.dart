import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zencare/core/api_config.dart';
import 'package:zencare/features/auth/register_otp_dialog.dart';

class RegisterDialog extends StatefulWidget {
  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cmfPassword = TextEditingController();

  bool isRegistering = false;

  registerUser() async {
    setState(() {
      isRegistering = true;
    });

    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
        'POST',
        Uri.parse(ApiConfig.register),
      );

      //  Send data WITHOUT Cookie header - sessions are handled server-side
      request.body = json.encode({
        "firstname": firstName.text.trim(),
        "lastname": lastName.text.trim(),
        "email": email.text.trim(),
        "phone": phone.text.trim(),
        "address": address.text.trim(),
        "password": password.text
      });
      request.headers.addAll(headers);

      print(' Sending registration request...');
      print('Data: ${request.body}');

      http.StreamedResponse response = await request.send();
      String responseString = await response.stream.bytesToString();

      print(' Registration Status Code: ${response.statusCode}');
      print(' Registration Response: $responseString');

      if (response.statusCode == 200) {
        final data = json.decode(responseString);

        //  Show message only if widget is still mounted
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Registration response received')),
          );
        }

        // register.php returns statusCode 200 and status "otp_sent" when OTP is sent
        final code = data['statusCode'];
        if ((code == 200 || code == '200') && data['status'] == 'otp_sent') {
          final userPhone = phone.text.trim();

          //  Store the name BEFORE showing OTP dialog
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String fullName = '${firstName.text.trim()} ${lastName.text.trim()}';
          await prefs.setString('userName', fullName);
          await prefs.setString('userEmail', email.text.trim());

          print(' Success! OTP sent. User name stored: $fullName');
          print(' Showing OTP dialog for phone: $userPhone');

          //  Close register dialog first, then show OTP dialog
          if (mounted) {
            Navigator.pop(context);
            showEmailOtpDialog(context, userPhone);
          }
        } else {
          print('⚠️ Unexpected response: statusCode=${data['statusCode']}, status=${data['status']}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data['message'] ?? 'Registration failed'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      } else {
        // Handle HTTP errors (400, 500, etc.)
        print(' HTTP Error: ${response.statusCode}');
        try {
          final errorData = json.decode(responseString);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorData['message'] ?? 'Registration failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration failed: ${response.statusCode}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (e) {
      print(' Exception during registration: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isRegistering = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.all(20),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'User Registration',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 10),
              Text(
                'Please fill all the information to access your account',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 10),
              _buildTextField(firstName, "First Name"),
              _buildTextField(lastName, "Last Name"),
              _buildTextField(email, "Email"),
              _buildTextField(phone, "Mobile Number"),
              _buildTextField(address, "Address", maxLines: 2),
              _buildTextField(password, "Password", obscureText: true),
              _buildTextField(cmfPassword, "Confirm Password", obscureText: true),
            ],
          ),
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: 50,
            child: ElevatedButton(
              onPressed: isRegistering
                  ? null
                  : () {
                //  Validate all fields
                if (firstName.text.trim().isEmpty ||
                    lastName.text.trim().isEmpty ||
                    email.text.trim().isEmpty ||
                    phone.text.trim().isEmpty ||
                    address.text.trim().isEmpty ||
                    password.text.isEmpty ||
                    cmfPassword.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields to proceed')),
                  );
                  return;
                }

                //  Validate email format
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text.trim())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid email address')),
                  );
                  return;
                }

                //  Validate phone number (10 digits)
                if (!RegExp(r'^\d{10}$').hasMatch(phone.text.trim())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid 10-digit phone number')),
                  );
                  return;
                }

                //  Check password match
                if (password.text != cmfPassword.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                //  Validate password strength
                if (password.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password must be at least 6 characters long')),
                  );
                  return;
                }

                registerUser();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: isRegistering
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Register',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

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
          hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey[700]),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    address.dispose();
    password.dispose();
    cmfPassword.dispose();
    super.dispose();
  }
}