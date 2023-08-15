import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hospital/models/Admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:hospital/components/button.dart';
import 'package:http/http.dart' as http;

import '../../models/doctorModel.dart';

class UpdateDataDoctor extends StatefulWidget {
  final Doctor? doctor;
  final Admin admin;
  const UpdateDataDoctor({super.key, this.doctor, required this.admin});

  @override
  State<UpdateDataDoctor> createState() => _UpdateDataDoctorState();
}

class _UpdateDataDoctorState extends State<UpdateDataDoctor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];
  File? image;
  String? base64Image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        ConvertImage(imageTemporary);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future ConvertImage(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    base64Image = base64Encode(imageBytes);
    print(base64Image);
  }

  @override
  void initState() {
    _nameController.text = widget.doctor!.fullname;
    _emailController.text = widget.doctor!.email;
    _specializationController.text = widget.doctor!.Specialization;
    _selectedGender = widget.doctor?.gender;
    _phoneController.text = widget.doctor!.phone;
    _addressController.text = widget.doctor!.address;
    _aboutController.text = widget.doctor!.aboutDoctor;
    _priceController.text = widget.doctor!.price;
    _passwordController.text = widget.doctor!.password;
    _ageController.text = widget.doctor!.age;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final doctorimage;

    if (widget.doctor?.photo != 'null') {
      final Uint8List bytes = base64Decode(widget.doctor!.photo);
      doctorimage = MemoryImage(bytes);
    } else {
      doctorimage = AssetImage("assets/default.jpg");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Doctor Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: InkWell(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      image != null ? FileImage(image!) : doctorimage,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(33, 150, 243, 1),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Button(
                color: Colors.green,
                width: 400,
                title: 'Change Profle Picture',
                onPressed: () {
                  pickImage();
                },
                disable: false,
                height: 50,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _aboutController,
              decoration: const InputDecoration(
                labelText: 'About the doctor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _specializationController,
              decoration: const InputDecoration(
                labelText: 'Specialization',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(33, 150, 243, 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Button(
                color: Colors.green,
                width: 400,
                title: 'Save Data',
                onPressed: () {
                  _updateDoctor(
                    _nameController.text,
                    _specializationController.text,
                    _selectedGender.toString(),
                    _emailController.text,
                    _passwordController.text,
                    _phoneController.text,
                    base64Image.toString(),
                    _aboutController.text,
                    _priceController.text,
                    _addressController.text,
                    widget.admin.token,
                    widget.admin.id,
                    _ageController.text,
                    context,
                  );
                },
                disable: false,
                height: 50,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 0, 0, 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Button(
                color: Colors.red,
                width: 400,
                title: 'Delete Doctor',
                onPressed: () {
                  _deleteDoctor(
                    _emailController.text,
                    widget.admin.token,
                    context,
                  );
                },
                disable: false,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _updateDoctor(
    String name,
    String specialization,
    String gender,
    String email,
    String password,
    String phone,
    String base64Image,
    String aboutDoctor,
    String price,
    String address,
    String token,
    String id,
    String age,
    BuildContext context,
  ) async {
    final Uri api = Uri.parse('http://192.168.1.8:3000/admin/updatedoctor');
    try {
      final response = await http.post(api, body: {
        'email': email,
        'password': password,
        'fullname': name,
        'gender': gender,
        'Specialization': specialization,
        'phone': phone,
        'photo': base64Image,
        'aboutDoctor': aboutDoctor,
        'address': address,
        'token': token,
        'id': id,
        'Price': price,
        'age': age,
      });
      print(response.body);
      // _showDoctorCreatedDialog(context);
    } catch (e) {
      print(e);
    }
  }

  void _showDoctorCreatedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Doctor Created'),
          content: const Text('The doctor has been updated successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _deleteDoctor(
    String email,
    String token,
    BuildContext context,
  ) async {
    final Uri api = Uri.parse('http://192.168.1.8:3000/admin/deletedoctor');
    try {
      final response = await http.post(api, body: {
        'email': email,
        'token': token,
        'id': 'sasa',
      });
      _showDoctorDeletedDialog(context);
    } catch (e) {
      print(e);
    }
  }

  void _showDoctorDeletedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Doctor Deleted'),
          content: const Text('The doctor has been deleted successfully.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
