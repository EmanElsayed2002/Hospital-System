import 'package:flutter/material.dart';
import 'package:hospital/components/button.dart';

class UpdateDataDoctor extends StatefulWidget {
  const UpdateDataDoctor({super.key});

  @override
  State<UpdateDataDoctor> createState() => _UpdateDataDoctorState();
}

class _UpdateDataDoctorState extends State<UpdateDataDoctor> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();

  String? _selectedGender;
  List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    _nameController.text = 'Doctor Name';
    _emailController.text = 'doctor@example.com';
    _specializationController.text = 'Specialization';
    _selectedGender = 'Male';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Doctor Data'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage('assets/doctor1.jpg'),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Button(
                  width: 400,
                  title: 'Change Profle Picture',
                  onPressed: () {},
                  disable: true,
                  height: 50),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _specializationController,
              decoration: InputDecoration(labelText: 'Specialization'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items: _genders.map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Gender',
              ),
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Button(
                  width: 400,
                  title: 'Save Data',
                  onPressed: () {},
                  disable: true,
                  height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
