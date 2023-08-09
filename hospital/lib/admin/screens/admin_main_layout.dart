import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/admin/screens/ReadDoctors.dart';
import 'package:hospital/admin/screens/admin_home_screen.dart';
import 'package:hospital/admin_profile.dart';
import 'package:hospital/admin/screens/create_doctor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'doctorModel.dart';

class AdminLayuot extends StatefulWidget {
  const AdminLayuot({super.key});

  @override
  State<AdminLayuot> createState() => _AdminLayuotState();
}

class _AdminLayuotState extends State<AdminLayuot> {
  int currentPage = 0, cnt = 0 ;
  // create non const list to get data from api
  List<Doctor> doctors = [];
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {  
    if(cnt == 0)
    {
      get_all_doctors(doctors);
      cnt++;
    }
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: <Widget>[
          AdminScreen(),
          CreateDoctor(),
          ReadDoctors(doctors: doctors),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0XFF0080FE),
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: currentPage,
          onTap: (page) {
            setState(() {
              currentPage = page;
              _page.animateToPage(
                page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseChimneyMedical),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.add,
              ),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userDoctor),
              label: 'Doctors',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidUser),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> get_all_doctors(List doctors) async {
  final Uri api = Uri.parse('http://192.168.1.8:3000/admin/readdoctorsdata');
  try {
    final response = await http.get(api);
    final jsonData = json.decode(response.body);
    final doctorList = jsonData['result'];
    for (var element in doctorList) {
      final doctor = Doctor(
        id: element['_id'] ?? 'sasa',
        fullname: element['fullname'] ?? 'sasa',
        email: element['email'] ?? 'sasa',
        password: element['password'] ?? 'sasa',
        Specialization: element['Specialization'] ?? 'sasa',
        gender: element['gender'] ?? 'sasa',
        phone: element['phone'] ?? 'sasa',
        address: element['address'] ?? 'sasa',
        aboutDoctor: element['aboutDoctor'] ?? 'sasa',
        price: element['price'] ?? 'sasa',
      );
      doctors.add(doctor);
    }
  } catch (e) {
    print(e);
  }
}
