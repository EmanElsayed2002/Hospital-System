import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hospital/doctors/massage_doctor.dart';
import 'package:hospital/models/doctorModel.dart';
import 'package:hospital/patients/screens/appointment_screen.dart';

import '../models/upCommingAppointments.dart';

class DoctorScreen extends StatefulWidget {
  final Doctor doctor;
  final List<Appointment>? appointments;
  DoctorScreen({super.key, required this.doctor, this.appointments});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
  final Uint8List bytes = base64Decode(widget.doctor.photo);
  MemoryImage image = MemoryImage(bytes);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        leadingWidth: 30,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Dr. ${widget.doctor.fullname}",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
            ),
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 25,
                backgroundImage: image,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Upcoming Appointments',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      // Add a list of upcoming appointments here
                      // You can use ListView.builder or other appropriate widgets
                      Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ListView.builder(
                  itemCount: widget.appointments!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                "assets/doctor1.jpg",
                              ),
                            ),
                            title: Text(
                              widget.appointments![index].patient.fullname,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              widget.appointments![index].date,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => UpdateDataDoctor(
                                //         doctor: widget.doctors![index],
                                //         admin : widget.doctor,
                                //         ),
                                //   ),
                                // );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              
                            },
                          ),
                        ),
                      ),
                    );

                      // ...
                    },
                  ),
                ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Add more sections or widgets for other relevant information
            ],
          ),
        ),
      ),
    );
  }
}
