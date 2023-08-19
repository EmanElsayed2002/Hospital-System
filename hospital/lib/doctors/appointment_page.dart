import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/models/Appointment.dart';
import 'package:hospital/models/doctorModel.dart';

class AppointmentPage extends StatefulWidget {
  final Doctor doctor;

  const AppointmentPage({Key? key, required this.doctor}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  int _selectedIndex = 0;
  List<String> _choices = ["free", "booked", "canceled"];

  List<String> _filteredElements = [];

  @override
  void initState() {
    super.initState();
    _filterElements(_choices[_selectedIndex]);
  }

  void _filterElements(String choice) {
    List<Appointment>? appointments = widget.doctor.appointments;

    if (appointments != null) {
      List<String> filtered = [];
      for (int i = 0; i < appointments.length; i++) {
        String date = appointments[i].date;
        String status = appointments[i].status;

        if (status == choice) {
          filtered.add('Appointment at $date');
        }
      }

      setState(() {
        _filteredElements = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.doctor.appointments[0].status);
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_choices.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _filterElements(_choices[index]);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Text(
                      _choices[index].toUpperCase(),
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: _filteredElements.isEmpty
                ? Center(
                    child: Text(
                      'No appointments found',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredElements.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              child: Image.asset(
                                "assets/doctors.png",
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                              ),
                              title: Text(
                                _filteredElements[index],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 16.0,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
