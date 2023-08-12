import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital/admin/screens/update_data_doctor.dart';
import 'package:hospital/models/Admin.dart';

import '../../models/doctorModel.dart';

class ReadDoctors extends StatefulWidget {
  final List<Doctor>? doctors;
  final Admin admin;
  const ReadDoctors({super.key, this.doctors , required this.admin});

  @override
  State<ReadDoctors> createState() => _ReadDoctorsState();
}

class _ReadDoctorsState extends State<ReadDoctors> {
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final Uint8List bytes = base64Decode(widget.admin.photo);
    MemoryImage image = MemoryImage(bytes);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        leadingWidth: 30,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Hospital System",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 120,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                'Category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(medCat.length, (index) {
                    return Card(
                      margin: const EdgeInsets.only(right: 20),
                      color: Colors.green,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            FaIcon(
                              medCat[index]['icon'],
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              medCat[index]['category'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Doctors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF0080FE),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ListView.builder(
                  itemCount: widget.doctors!.length,
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
                              widget.doctors![index].fullname,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              widget.doctors![index].Specialization,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateDataDoctor(
                                        doctor: widget.doctors![index],
                                        admin : widget.admin,
                                        ),
                                  ),
                                );
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
                  },
                ))
          ],
        ),
      ),
    );
  }
}
