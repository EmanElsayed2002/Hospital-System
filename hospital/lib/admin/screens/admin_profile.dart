import "dart:convert";
import "dart:typed_data";

import "package:flutter/material.dart";
import "package:hospital/admin/screens/change_password.dart";
import 'package:hospital/admin/screens/edit_profile_doctor.dart';
import "package:hospital/admin/screens/update_data_admin.dart";
import "package:hospital/models/Admin.dart";

import "../../login_screen.dart";

class ProfilePage extends StatefulWidget {
  final Admin admin;
    ProfilePage({Key? key , required this.admin}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final Uint8List bytes = base64Decode(widget.admin.photo!);
    MemoryImage image = MemoryImage(bytes);
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color:   Color(0XFF0080FE),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                CircleAvatar(
                  radius: 65.0,
                  backgroundImage: image,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  'Dr. ${widget.admin.fullname}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  // '21 | male',
                  '${widget.admin.age} | ${widget.admin.gender}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: EdgeInsets.all( 
                      MediaQuery.of(context).size.width * 0.05,
                    ),

                    child: Column(
                      children: [
                          Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Divider(
                          color: Colors.grey[300],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.blueAccent[400],
                              size: 35,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateDataAdmin(admin: widget.admin,),
                                  ),
                                );
                              },
                              child:   Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: Color(0XFF0080FE),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Icon(
                              Icons.history,
                              color: Color(0XFF0080FE),
                              size: 35,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePassword(admin : widget.admin),
                                  ),
                                );
                              },
                              child:   Text(
                                "Change Password",
                                style: TextStyle(
                                  color: Color(0XFF0080FE),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Icon(
                              Icons.logout_outlined,
                              color: Color(0XFF0080FE),
                              size: 35,
                            ),
                             SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            TextButton(
                              onPressed: () {
                                // sent to login page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => loginScreen(),
                                  ),
                                );
                              },
                              child:   Text(
                                "Logout",
                                style: TextStyle(
                                  color: Color(0XFF0080FE),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
