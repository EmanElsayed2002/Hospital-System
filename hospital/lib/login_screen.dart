import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospital/components/social_button.dart';
import 'package:http/http.dart' as http;
import 'package:hospital/signup_screen.dart';

import 'admin/screens/admin_main_layout.dart';
import 'doctors/doctor_main_layout.dart';
import 'models/Admin.dart';
import 'models/doctorModel.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool passToggle = true;
  final email = TextEditingController();
  final password = TextEditingController();
  // make global variable for the response
  var response;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.06),
                child: Image.asset(
                  "assets/doctors.png",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                child: TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter email",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03,
                    bottom: MediaQuery.of(context).size.height * 0.02),
                child: TextField(
                  controller: password,
                  obscureText: passToggle ? true : false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Enter Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: passToggle
                          ? const Icon(CupertinoIcons.eye_slash_fill)
                          : const Icon(CupertinoIcons.eye_fill),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: InkWell(
                  onTap: () {
                    // receive the response from the _loginUser function
                    _loginUSer(email.text, password.text, context);
                    // make a map for the user data
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0XFF0080FE),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "OR",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 5, 37, 14),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                "Log In With",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF0080FE),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SocialButton(social: 'google'),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  const SocialButton(social: 'facebook'),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF0080FE),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> _loginUSer(
    String email, String password, BuildContext context) async {
  final Uri api = Uri.parse('http://192.168.1.8:3000/doctor/login');
  try {
    final response = await http.post(api, body: {
      'email': email,
      'password': password,
    });

    final jsonData = json.decode(response.body);
    final result = jsonData['result'];
    if (result['admin'] != null) {
      _loginAsAdmin(context, result);
    } else if (result['doctor'] != null) {
      _loginAsDoctor(context, result);
    } else if (result['patient'] != null) {
      _loginAsPatient(context, result);
    }
  } catch (e) {
    print(e);
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
    photo: result['admin']['photo'] ?? 'not found',
  );
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AdminLayuot(
                admin: admin,
              )));
}

void _loginAsDoctor(BuildContext context, dynamic result) {
  final doctor = Doctor(
    fullname: result['doctor']['fullname'] ?? 'not found',
    Specialization: result['doctor']['Specialization'] ?? 'not found',
    phone: result['doctor']['phone'] ?? 'not found',
    password: result['doctor']['password'] ?? 'not found',
    email: result['doctor']['email'] ?? 'not found',
    gender: result['doctor']['gender'] ?? 'not found',
    photo: result['doctor']['photo'] ?? 'not found',
    id: result['doctor']['id'] ?? 'not found',
    address: result['doctor']['address'] ?? 'not found',
    aboutDoctor: result['doctor']['aboutDoctor'] ?? 'not found',
    price: result['doctor']['price'] ?? 'not found',
    age: result['doctor']['age'] ?? 'not found',
  );
  List<dynamic> decodedAppointments =result['doctor']['appointments'];
  doctor.appointments = decodedAppointments;
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DoctorLayout(
                doctor: doctor,
              )));
}

void _loginAsPatient(BuildContext context, dynamic result) {}
