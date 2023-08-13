import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/doctors/create_available_time.dart';
import 'package:hospital/doctors/doctorscreen.dart';
import 'package:hospital/doctors/massage_doctor.dart';
import 'package:hospital/models/patient.dart';
import 'package:hospital/models/doctorModel.dart';
import 'package:hospital/doctors/appointment_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/upCommingAppointments.dart';
import 'doctor_profile.dart';

class DoctorLayout extends StatefulWidget {
  final Doctor doctor;
  const DoctorLayout({super.key, required this.doctor});

  @override
  State<DoctorLayout> createState() => _DoctorLayoutState();
}

class _DoctorLayoutState extends State<DoctorLayout> {
  int currentPage = 0, cnt = 0;
  List<Appointment> appointment = [];
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context) {
    if (cnt == 0) {
      get_all_patient(appointment, widget.doctor);
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
          DoctorScreen(doctor: widget.doctor, appointments: appointment),
          MessageDoctor(doctor: widget.doctor),
          CreateAvailableTime(doctor: widget.doctor),
          AppointmentPage(doctor: widget.doctor),
          ProfilePage(doctor: widget.doctor),
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
              icon: Icon(FontAwesomeIcons.add),
              label: 'create',
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

// // 64cf7fa068475d52482b9e89
Future<void> get_all_patient(
    List<Appointment> appointmentss, Doctor doctor) async {
  final Uri api = Uri.parse('http://192.168.1.8:3000/doctor/readpatients');
  try {
    final response = await http.post(api, body: {
      'email': doctor.email,
    });
    final jsonData = json.decode(response.body);
    // print(jsonData);
    for (var appointmentData in jsonData['result']) {
      // Extract appointment details
      String appointmentDateTime = appointmentData[0]['appointments'][0];
      String date = appointmentDateTime.split(' ')[0];
      String time = appointmentDateTime.split(' ')[1];
      print(date);
      print(time);
      // Extract patient details
      dynamic patientData = appointmentData[0];
      String fullName = patientData['fullname'];
      String email = patientData['email'];
      String password = patientData['password'];
      String phone = patientData['phone'];

      // Create patient object
      Patient patient = Patient(
        fullname: fullName,
        email: email,
        password: password,
        phone: phone,
        age: '',
        appointments: null,
        gender: '',
        id: '',
        photo: '',
      );

      // Create appointment object and add it to the list
      Appointment appointment = Appointment(
        patient: patient,
        date: date,
        time: time,
      );
      appointmentss.add(appointment);
    }
  } catch (e) {
    print(e);
  }
}
