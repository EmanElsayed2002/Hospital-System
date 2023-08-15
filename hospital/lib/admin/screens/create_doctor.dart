import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hospital/models/Admin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateDoctor extends StatefulWidget {
  final Admin admin;
  const CreateDoctor({Key? key, required this.admin}) : super(key: key);

  @override
  State<CreateDoctor> createState() => _CreateDoctorState();
}

class _CreateDoctorState extends State<CreateDoctor> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutDoctorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
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
        convertImage(imageTemporary);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future convertImage(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    base64Image = base64Encode(imageBytes);
    print(base64Image);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _specializationController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _aboutDoctorController.dispose();
    _priceController.dispose();
    super.dispose();
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
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: TextButton(
                onPressed: () {
                  pickImage();
                },
                child: const Text(
                  'Pick Profile Picture',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _nameController,
              labelText: 'Name',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _emailController,
              labelText: 'Email',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _passwordController,
              labelText: 'Password',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _phoneController,
              labelText: 'Phone',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _addressController,
              labelText: 'Address',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _aboutDoctorController,
              labelText: 'About Doctor',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _specializationController,
              labelText: 'Specialization',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _priceController,
              labelText: 'Price',
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
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
              labelText: 'Gender',
            ),
            const SizedBox(height: 24),
            _buildButton(
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
                  _priceController.text,
                  context,
                );
              },
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required void Function(String?)? onChanged,
    required List<DropdownMenuItem<String>> items,
    required String labelText,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: items,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required void Function() onPressed,
    required double height,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(33, 150, 243, 1),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
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
    String price,
    BuildContext context,
  ) async {
    final Uri api = Uri.parse('http://192.168.1.7:3000/admin/createnewdoctor');
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
        'auth': '',
        'aboutDoctor': aboutDoctor,
        'address': address,
        'Price': price,
      });
      var message = jsonDecode(response.body)['message'];
      print(message);
      if (response.statusCode == 200)
        _showDoctorCreatedDialog(context, "Created", message);
      else
        _showDoctorCreatedDialog(context, "Error", message);
    } catch (e) {
      print(e);
    }
  }

  void _showDoctorCreatedDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                _aboutDoctorController.clear();
                _addressController.clear();
                _emailController.clear();
                _nameController.clear();
                _passwordController.clear();
                _phoneController.clear();
                _priceController.clear();
                _specializationController.clear();
                _genders.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
