import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hospital/models/doctorModel.dart';
import 'package:hospital/patients/screens/home_page.dart';
import 'package:hospital/patients/components/message_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/Appointment.dart';
import '../../models/patient.dart';
import '../screens/myappointments.dart';
import '../screens/patientProfile.dart';

class MainLayout extends StatefulWidget {
  final Patient patient;
  final List<Doctor>? myDoctors;
  const MainLayout({Key? key, required this.patient, required this.myDoctors})
      : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0, cnt = 0;
  List<Doctor> PopularDoctors = [];
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    if (cnt == 0) {
      get_all_patient(PopularDoctors);
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
          HomePage(patient: widget.patient, PopularDoctors: PopularDoctors),
          MessagesScreen(),
          MyDoctorsScreen(
              patient: widget.patient, myDoctors: widget.myDoctors!),
          ProfilePage(patient: widget.patient), //profile
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
                CupertinoIcons.chat_bubble_text_fill,
              ),
              label: "Messages",
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidCalendarCheck),
              label: 'Appointments',
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

Future<void> get_all_patient(List<Doctor> PopularDoctors) async {
  final Uri api = Uri.parse('http://192.168.1.8:3000/patient/populardoctor');
  try {
    final response = await http.get(api);
    final jsonData = jsonDecode(response.body);
    final doctorsList = jsonData['result'];
    for (var element in doctorsList) {
      final doctortId = element['_id'].toString();
      final appointments = await _getappointmentsfordoctor(doctortId);
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
        price: element['price'] ?? '150',
        photo: element['photo'] ?? 'sasa',
        age: element['age'] ?? 'sasa',
        // appointments: _convertToAppointments(appointments) ?? [],
      );
      PopularDoctors.add(doctor);
    }
    print(PopularDoctors.length);
    // print(PopularDoctors);
  } catch (e) {
    print(e);
  }
}

Future<List<dynamic>> _getappointmentsfordoctor(String id) async {
  final Uri api =
      Uri.parse('http://192.168.1.8:3000/doctor/getallappointments');
  try {
    final response = await http.post(api, body: {
      'id': id,
    });
    final jsonData = json.decode(response.body);

    return jsonData['result'];
  } catch (e) {
    print(e);
    return [];
  }
}

List<Appointment> _convertToAppointments(List<dynamic> appointmentsData) {
  List<Appointment> appointments = [];

  for (dynamic appointmentData in appointmentsData) {
    String date = appointmentData['date'] ?? '';
    String time = appointmentData['time'] ?? '';
    String status = appointmentData['status'] ?? '';
    String patientId = appointmentData['patientId'] ?? '';
    String doctorId = appointmentData['doctorId'] ?? '';
    String Id = appointmentData['_id'] ?? '';

    Appointment appointment = Appointment(
      date: date,
      time: time,
      status: status,
      patientId: patientId,
      doctorId: doctorId,
      Id: Id,
    );

    appointments.add(appointment);
  }

  return appointments;
}
