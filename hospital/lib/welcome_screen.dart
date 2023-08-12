import 'package:flutter/material.dart';
import 'package:hospital/login_screen.dart';
import 'package:hospital/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 65,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/doctors.png"),
            ),
            const SizedBox(height: 100),
            const Center(
              child: Text(
                "Hospital System",
                style: TextStyle(
                  color: Color(0xFF0080FE),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Appoint Your Doctor",
              style: TextStyle(
                color: Color(0XFF0080FE),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: const Color(0XFF0080FE),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const loginScreen(),
                          ));
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: const Color(0XFF0080FE),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
