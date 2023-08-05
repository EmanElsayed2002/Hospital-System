import 'package:flutter/material.dart';
import 'package:hospital/components/button.dart';

class CreateDoctor extends StatefulWidget {
  const CreateDoctor({super.key});

  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _specializationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? _selectedGender;
  List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Doctor Account'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage('assets/profile1.jpg'),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Button(
                  width: 100,
                  title: 'pick profile picture',
                  onPressed: () {},
                  disable: true,
                  height: 40),
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
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Button(
                  width: 400,
                  title: 'Create Account',
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
