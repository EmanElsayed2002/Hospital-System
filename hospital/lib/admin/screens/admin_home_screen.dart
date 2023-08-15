import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hospital/admin/screens/admin_profile.dart';

import '../../models/Admin.dart';

class AdminScreen extends StatelessWidget {
  final Admin admin;

  const AdminScreen({Key? key, required this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width;
    final containerHeight = MediaQuery.of(context).size.height;

    final image = _getAdminImage();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        leadingWidth: 30,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: containerWidth * 0.01),
              child: Text(
                "Hospital System",
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: containerWidth * 0.27),
            Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        admin: admin,
                      ),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: image,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundImage: image,
            ),
            SizedBox(height: containerHeight * 0.04),
            _buildWelcomeText("You can make CRUD now"),
          ],
        ),
      ),
    );
  }

  ImageProvider _getAdminImage() {
    if (admin.photo != 'null') {
      final Uint8List bytes = base64Decode(admin.photo);
      return MemoryImage(bytes);
    } else {
      return AssetImage("assets/default.jpg");
    }
  }

  Container _buildWelcomeText(String text) {
    return Container(
      height: 50,
      width: text.length * 17.0,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 113, 132, 164),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
