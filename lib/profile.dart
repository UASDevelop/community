import 'dart:convert';

import 'package:community/Api/CustomApi.dart';
import 'package:community/Api/alertbox.dart';
import 'package:community/changes_profile.dart';
import 'package:community/community.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  String name;
  String email;
  String uid;
  String photourl;
  String phoneNO;
  Profile(
      {required this.name,
      required this.email,
      required this.uid,
      required this.photourl,
      required this.phoneNO});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phoneNo = TextEditingController();
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();

  CustomAlert customAlert = CustomAlert();
//   Future<http.Response> sendUserDataToApi() async {
//     final response = await http.post(
//       Uri.parse("${CustomApi.baseUrl}${CustomApi.signup_end_point}"),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'username': widget.name,
//         'email': widget.email,
//         'password': widget.uid,
//         "profileImage": widget.photourl,
//         "phoneNumber": widget.phoneNO,
//         "address": _address.text
//       }),
//     );
//     Map<String, dynamic> parsedResponse = json.decode(response.body);
//
// // Access the user ID
//     String userId = parsedResponse['user']['_id'];
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var id = prefs.setString('userId', userId);
//     if (response.statusCode == 200) {
//       // If the status code is 200 (OK), the request was successful.
//       // You can navigate to the 'Community' screen or perform other actions here.
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const Community(),
//         ),
//       );
//     } else if (response.statusCode == 201) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const Community(),
//         ),
//       );
//     } else if (response.statusCode == 400) {
//       // Handle a 400 (Bad Request) error here. Example:
//       // Show an error message to the user.
//       print(response.body);
//       print("Bad Request: Invalid data sent to the server.");
//     } else if (response.statusCode == 401) {
//       // Handle a 401 (Unauthorized) error here. Example:
//       // Redirect the user to the login screen.
//       print("Unauthorized: User not authenticated.");
//     } else {
//       // Handle other status codes as needed.
//       print("HTTP Status Code: ${response.statusCode}");
//     }
//     return response;
//   }

  @override
  void initState() {
    setState(() {});
    _email.text = widget.email;
    _fullname.text = widget.name;
    _phoneNo.text = widget.phoneNO;
    print(_phoneNo.text);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Figma Flutter Generator H3Widget - TEXT
                  Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(41, 42, 41, 1),
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        height: 1.4545454545454546),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter your details here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(119, 119, 157, 1),
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w400,
                        height: 1.7142857142857142),
                  ),
                  const SizedBox(height: 25),
                  // Figma Flutter Generator InputfieldbackgroundWidget - RECTANGLE
                  Container(
                    width: 310,
                    height: 533,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      color: Color.fromRGBO(255, 255, 255, 1),
                      border: Border.all(
                        color: Color.fromRGBO(234, 233, 255, 1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Figma Flutter Generator BodyWidget - TEXT
                        Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          alignment: AlignmentDirectional.topStart,
                          child: const Text(
                            "Your Name",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(31, 31, 57, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                                height: 1.3333333333333333),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _fullname,
                            decoration: InputDecoration(
                              hintText: "user  Name",
                              hintStyle: TextStyle(
                                color: Color(0xff38385E),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEAEAFF)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          alignment: AlignmentDirectional.topStart,
                          child: const Text(
                            'Email Address',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(31, 31, 57, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                                height: 1.3333333333333333),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Color(0xff38385E),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEAEAFF)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          alignment: AlignmentDirectional.topStart,
                          child: const Text(
                            'Address',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(31, 31, 57, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                                height: 1.3333333333333333),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _address,
                            decoration: const InputDecoration(
                              hintText: '       your address here',
                              hintStyle: TextStyle(
                                color: Color(0xffEAEAFF),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEAEAFF)),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          alignment: AlignmentDirectional.topStart,
                          child: const Text(
                            'Phone number',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(31, 31, 57, 1),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                                height: 1.3333333333333333),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            controller: _phoneNo,
                            decoration: const InputDecoration(
                              hintText: '       your phone number here',
                              hintStyle: TextStyle(
                                color: Color(0xffEAEAFF),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEAEAFF)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 80),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Community(
                                        name: widget.name,
                                        email: widget.email,
                                        password: widget.uid,
                                        address: _address.text,
                                        phoneNo: _phoneNo.text,
                                        profileimag: widget.photourl)));
                          },
                          child: Container(
                              width: 268,
                              height: 50,
                              child: Stack(children: <Widget>[
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                        width: 268,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                        ))),
                                Positioned(
                                    top: 0,
                                    left: 0,
                                    child: Container(
                                        width: 268,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(14),
                                            topRight: Radius.circular(14),
                                            bottomLeft: Radius.circular(14),
                                            bottomRight: Radius.circular(14),
                                          ),
                                          color: Color.fromRGBO(40, 174, 97, 1),
                                        ))),
                                const Positioned(
                                    top: 13,
                                    left: 118,
                                    child: Text(
                                      'Next',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          height: 1.7142857142857142),
                                    )),
                              ])),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
