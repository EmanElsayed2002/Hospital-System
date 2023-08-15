import 'dart:convert';
import 'dart:ui';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:hospital/admin/screens/admin_home_screen.dart';
import 'package:hospital/admin/screens/admin_main_layout.dart';
import 'package:hospital/models/Admin.dart';
import 'package:hospital/welcome_screen.dart';
import 'package:http/http.dart' as http;

class PasswordVerification extends StatefulWidget {
  PasswordVerification({super.key, required this.admin});
  final Admin admin;
  @override
  State<PasswordVerification> createState() => _PasswordVerificationState();
}

class _PasswordVerificationState extends State<PasswordVerification> {
  final TextEditingController _verificationCodeController =
      TextEditingController();

  Future<void> _verifyCode(String email, String password, String code) async {
    final Uri api = Uri.parse('http://192.168.1.8:3000/verify-code');

    try {
      final response = await http.post(api, body: {
        'email': email,
        'password': password,
        'code': code,
      });
      print(response.body);
      final jsonData = json.decode(response.body);
      print(email);
      if (jsonData['success']) {
        _showChangePasswordDialog(context, 'Password Changed Successfully');
      } else {
        print('Admin data not found');
      }
    } catch (e) {
      print(e);
    }
  }

  void _showChangePasswordDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminLayuot(
                      admin: widget.admin,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Password Verification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Enter Verification Code sent to',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 5),
              child: Text(
                '${widget.admin.email}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.blueAccent),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(
                  labelText: 'Enter Code',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _verifyCode(
                  widget.admin.email,
                  widget.admin.password,
                  _verificationCodeController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
              ),
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }
}
