import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hospital/models/Admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:hospital/components/button.dart';
import 'package:http/http.dart' as http;

class CreateDoctor extends StatefulWidget {
  final Admin admin;
  const CreateDoctor({super.key, required this.admin});

  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutDoctorController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Doctor Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: image != null ? FileImage(image!) : null,
              child: image == null
                  ? const Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: Colors.grey,
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Button(
                  width: 100,
                  title: 'pick profile picture',
                  onPressed: () {
                    // take image from gallery
                    pickImage();
                  },
                  disable: false,
                  height: 40),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'address'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _aboutDoctorController,
              decoration: const InputDecoration(labelText: 'about doctor'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _specializationController,
              decoration: const InputDecoration(labelText: 'Specialization'),
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
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Button(
                  width: 400,
                  title: 'Create Account',
                  onPressed: () {
                    _createDoctor(
                        _nameController.text,
                        _specializationController.text,
                        _selectedGender.toString(),
                        _emailController.text,
                        _passwordController.text,
                        widget.admin.token,
                        _phoneController.text,
                        base64Image.toString(),
                        _aboutDoctorController.text,
                        _addressController.text,
                        context);
                  },
                  disable: false,
                  height: 50),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _createDoctor(
    String name,
    String specialization,
    String gender,
    String email,
    String password,
    String token,
    String phone,
    String base64Image,
    String aboutDoctor,
    String address,
    BuildContext context) async {
  final Uri api = Uri.parse('http://192.168.1.8:3000/admin/createnewdoctor');
  try {
    final response = await http.post(api, body: {
      'email': email,
      'password': password,
      'fullname': name,
      'gender': gender,
      'Specialization': specialization,
      'phone': phone,
      'token': token,
      'photo': base64Image,
      '_id' : 'sasa',
      'aboutDoctor': aboutDoctor,
      'address': address,
    });
    _showDoctorCreatedDialog(context);
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
        content: const Text('The doctor has been created successfully.'),
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

// final jsonData = json.decode(response.body);
// final Token = jsonData['result']['token'] ?? '';
// final Email = jsonData['result']['admin']['email'] ?? '';
// final Password = jsonData['result']['admin']['password'] ?? '';
// print(Email);
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) =>
//             HomePage(token: Token, email: Email, password: Password)));
