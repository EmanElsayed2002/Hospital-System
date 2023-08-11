import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../models/Admin.dart';

class AdminScreen extends StatefulWidget {
  final Admin admin;
    AdminScreen({super.key , required this.admin});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width * 0.9;
    final containerHeight = MediaQuery.of(context).size.height * 0.3;
    final Uint8List bytes = base64Decode(widget.admin.photo!);
    MemoryImage image = MemoryImage(bytes);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue,
        leadingWidth: 30,
        title: Row(
          children: [
              Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
              child: Text(
                "Hospital System",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 90,
              backgroundImage: image,
            ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
              SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding:   EdgeInsets.all(MediaQuery.of(context).size.height * 0.02), 
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child:   Center(
                  child: Text(
                    'you can make CRUD now',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
