import 'dart:convert';
import 'package:community/report.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Api/CustomApi.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _addresss = TextEditingController();
  TextEditingController _phone = TextEditingController();
  List<dynamic> userData = [];
  String? id;
  String? email;
  String? username;
  String? address;
  String? phoneNO;

  late Future<void> _fetchUserDataFuture; // Declare the Future

  @override
  void initState() {
    // Initialize the Future in the initState method
    _fetchUserDataFuture = _fetchUserData();
    super.initState();
    setState(() {

    });
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    print("UserID: $userId");

    try {
      var response = await http.get(
        Uri.parse("${CustomApi.baseUrl}/api/v2/user/getUser/$userId"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
           print(responseData);
        setState(() {
          id = responseData['user']['_id'];
          email = responseData["user"]["email"];
          username = responseData["user"]["username"];
          address = responseData["user"]["address"];
          phoneNO = responseData["user"]["phoneNumber"];
        });

        // Now, you have the user data in 'responseData' which you can use as needed.
      } else {
        // Handle the error, e.g., show an error message
        print('Failed to fetch data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _email.text=email!;
    _phone.text=phoneNO!;
    _username.text=username!;
    _addresss.text=address!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const // Figma Flutter Generator H3Widget - TEXT
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
                            'Your name',
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
                            controller: _username,
                            decoration: const InputDecoration(
                              hintText: '       John Smith',
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
                            decoration: const InputDecoration(
                              hintText: '       youremail@gmail.com',
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
                            controller: _addresss,
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
                            controller: _phone,
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
                            // Navigator.push(context, MaterialPageRoute(builder: (Context)=>const Home()));
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
                                    left: 90,
                                    child: Text(
                                      'Save Changes',
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
