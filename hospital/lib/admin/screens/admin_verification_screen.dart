import 'package:flutter/material.dart';
import 'package:hospital/admin/screens/admin_main_layout.dart';
import 'package:hospital/models/Admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'admin_home_screen.dart';

class AdminVerificationScreen extends StatefulWidget {
  final String email;
  final String password;
  const AdminVerificationScreen({required this.email, required this.password});

  @override
  _AdminVerificationScreenState createState() =>
      _AdminVerificationScreenState();
}

class _AdminVerificationScreenState extends State<AdminVerificationScreen> {
  final TextEditingController _verificationCodeController =
      TextEditingController();

  Future<dynamic> _loginUSer(
      String email, String password, BuildContext context) async {
    final Uri api = Uri.parse('http://192.168.1.8:3000/admin/login');
    try {
      final response = await http.post(api, body: {
        'email': email,
        'password': password,
      });

      final jsonData = json.decode(response.body);
      final result = jsonData['result'];
      print(response.body);
      if (result['admin'] != null) {
        _loginAsAdmin(context, result);
      }
    } catch (e) {
      print(e);
    }
  }

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
        _loginUSer(email, password, context as BuildContext);
      } else {
        print('Admin data not found');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Verification')),
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
                '${widget.email}',
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
                  widget.email,
                  widget.password,
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

void _loginAsAdmin(BuildContext context, dynamic result) {
  final admin = Admin(
    fullname: result['admin']['fullname'] ?? 'not found',
    email: result['admin']['email'] ?? 'not found',
    password: result['admin']['password'] ?? 'not found',
    phone: result['admin']['phone'] ?? 'not found',
    id: result['admin']['_id'] ?? 'not found',
    gender: result['admin']['gender'] ?? 'not found',
    age: result['admin']['age'] ?? 'not found',
    token: result['token'] ?? 'not found',
    photo: result['admin']['photo'] ?? 'null',
  );
  print(admin);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AdminLayuot(
                admin: admin,
              )));
}

Future<Admin?> getAdminDataByEmail(String email) async {
  final Uri api = Uri.parse('http://192.168.1.8:3000/admin/getData');
  try {
    final response = await http.post(api, body: {
      'email': email,
    });
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final result = jsonData['result'];

      return Admin(
        fullname: result['fullname'] ?? 'not found',
        email: result['email'] ?? 'not found',
        password: result['password'] ?? 'not found',
        phone: result['phone'] ?? 'not found',
        id: result['_id'] ?? 'not found',
        gender: result['gender'] ?? 'not found',
        age: result['age'] ?? 'not found',
        token: result['token'] ?? 'not found',
        photo: result['photo'] ?? 'null',
      );
    } else {
      print(response.body);
    }
  } catch (e) {
    print(e);
    return null;
  }
}
