import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hospital/models/Admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:hospital/components/button.dart';
import 'package:http/http.dart' as http;



class UpdateDataAdmin extends StatefulWidget {
  final Admin? admin;
  const UpdateDataAdmin({super.key, this.admin});

  @override
  State<UpdateDataAdmin> createState() => _UpdateDataAdminState();
}

class _UpdateDataAdminState extends State<UpdateDataAdmin> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

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
    _nameController.text = widget.admin!.fullname;
    _emailController.text = widget.admin!.email;
    _phoneController.text = widget.admin!.phone;
    _passwordController.text = widget.admin!.password;
    _ageController.text = widget.admin!.age;
    _genderController.text = widget.admin!.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update admin Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage: image != null ? FileImage(image!) : null,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Button(
                  width: 400,
                  title: 'Change Profle Picture',
                  onPressed: () {
                    pickImage();
                  },
                  disable: false,
                  height: 50),
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
              decoration: const InputDecoration(labelText: 'phone'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'age'),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(33, 150, 243, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Button(
                  width: 400,
                  title: 'Save Data',
                  onPressed: () {
                    _updateAdmin(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                        _phoneController.text,
                        _ageController.text,
                        _genderController.text,
                        base64Image!,
                        widget.admin!.token,
                        context);
                  },
                  disable: false,
                  height: 50),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 0, 0, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Button(
                  width: 400,
                  title: 'delete admin',
                  onPressed: () {
                    _deleteAdmin(_emailController.text,widget.admin!.token, context);
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

Future<dynamic> _updateAdmin(
    String name,
    String email,
    String password,
    String phone,
    String age,
    String gender,
    String base64Image,
    String token,
    BuildContext context) async {
  final Uri api = Uri.parse('http://192.168.1.11:3000/admin//updateadmin');
  try {
    final response = await http.post(api, body: {
      'email': email,
      'password': password,
      'fullname': name,
      'gender': gender,
      'age': age,
      'phone': phone,
      'photo': base64Image, 
      'token': token,
      'id' : 'sasa',
    });
    _showAdminCreatedDialog(context);
  } catch (e) {
    print(e);
  }
}

void _showAdminCreatedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Admin Created'),
        content: const Text('The Admin has been updated successfully.'),
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

Future<dynamic> _deleteAdmin(String email,String token , BuildContext context) async {
  final Uri api = Uri.parse('http://192.168.1.11:3000/admin/deleteAdmin');
  try {
    final response = await http.post(api, body: {
      'email': email,
      'token': token,
      'id' : 'sasa',
    });
    _showAdminDeletedDialog(context);
  } catch (e) {
    print(e);
  }
}

void _showAdminDeletedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Admin Deleted'),
        content: const Text('The Admin has been deleted successfully.'),
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
