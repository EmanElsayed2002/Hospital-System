import 'package:flutter/material.dart';
import 'package:hospital/screens/login_screen.dart';
import 'package:hospital/screens/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 65,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/doctors.png"),
            ),
            SizedBox(height: 100),
            Center(
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
            SizedBox(height: 10),
            Text(
              "Appoint Your Doctor",
              style: TextStyle(
                color: Color(0XFF0080FE),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Color(0XFF0080FE),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => loginScreen(),
                          ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
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
                  color: Color(0XFF0080FE),
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      child: Text(
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
