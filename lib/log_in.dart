import 'dart:convert';

import 'package:community/Api/CustomApi.dart';
import 'package:community/Api/alertbox.dart';
import 'package:community/Bottomnavigaton/BottomNavigation.dart';
import 'package:community/community.dart';
import 'package:community/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Log_In extends StatefulWidget {
  const Log_In({Key? key}) : super(key: key);

  @override
  State<Log_In> createState() => _Log_InState();
}

class _Log_InState extends State<Log_In> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CustomAlert customAlert = CustomAlert();
  Future<void> GoogleSignInOrSignUp() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication credential =
          await googleSignInAccount.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: credential.accessToken,
        idToken: credential.idToken,
      );

      try {
        final UserCredential authCredential =
            await FirebaseAuth.instance.signInWithCredential(credentials);
        final User? user = authCredential.user;

        // Check if the user is new or existing
        if (authCredential.additionalUserInfo!.isNewUser) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Profile(
                        name: user!.displayName ?? '',
                        email: user.email ?? '',
                        uid: user.uid,
                        photourl: user.photoURL ?? '',
                        phoneNO: user.phoneNumber ?? '',
                      )));
          // New user: Send user data to the signup API endpoint
//           final response = await sendUserDataToApi(user?.displayName ?? '',
//               user?.email ?? '', user?.uid ?? '', user?.photoURL ?? "");
//           if (response.statusCode == 201) {
//             // Parse the response body as JSON
//             Map<String, dynamic> parsedResponse = json.decode(response.body);
//
// // Access the user ID
//             String userId = parsedResponse['user']['_id'];
// // Save the user ID to SharedPreferences
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             var id = prefs.setString('userId', userId);
//
//             // Successful signup
//             customAlert.showSuccessAlert(
//                 context, "Success", "You're signed up successfully${id}");
//             print('User signed up successfully');
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => Profile(
//                       name: user!.displayName ?? '',
//                       email: user.email ?? '',
//                       uid: user.uid,
//                       photourl: user.photoURL ?? '',
//                       phoneNO:user.phoneNumber??'',
//                     )));
//              } else {
//             // Handle API signup error
//             customAlert.showErrorAlert(
//                 context, "Oops!", "Failed to sign up with API");
//             print(
//                 'Failed to sign up with API - Status Code: ${response.statusCode}');
//             print('Response body: ${response.body}');
//           }
        } else {
          // Existing user: Send user data to the login API endpoint
          final response =
              await sendLoginDataToApi(user?.email ?? '', user?.uid ?? '');

          if (response.statusCode == 200) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Community()));

            // Successful login

            Map<String, dynamic> parsedResponse = json.decode(response.body);

// Access the user ID
            String userId = parsedResponse['user']['_id'];

            SharedPreferences prefs = await SharedPreferences.getInstance();
            var id = prefs.setString('userId', userId);
            customAlert.showSuccessAlert(
                context, "Success", "You're logged in successfull${userId}");
            print('User logged in successfully');
          } else {
            // Handle API login error
            customAlert.showErrorAlert(
                context, "Oops!", "Failed to log in with API");
            customAlert.showErrorAlert(
                context, "Oops!", "Failed to log in with API${response.body}");
            print(
                'Failed to log in with API - Status Code: ${response.statusCode}');
            print('Response body: ${response.body}');
          }
        }

        // Navigate to the Community screen
      } catch (e) {
        // Handle authentication errors
        print('Authentication error: $e');
        customAlert.showErrorAlert(
            context, "Oops!", "Authentication error: $e");
      }
    }
  }

  // Future<http.Response> sendUserDataToApi(
  //     String name, String email, String uid, String photourl) async {
  //   final response = await http.post(
  //     Uri.parse("${CustomApi.baseUrl}${CustomApi.signup_end_point}"),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'username': name,
  //       'email': email,
  //       'password': uid,
  //       "profileImage": photourl,
  //     }),
  //   );
  //   return response;
  // }

  Future<http.Response> sendLoginDataToApi(String email, String uid) async {
    final response = await http.post(
      Uri.parse("${CustomApi.baseUrl}${CustomApi.login_end_point}"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password':
            uid, // Assuming your API expects the UID as the password for login.
      }),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Column(
              children: [
                const // Figma Flutter Generator H3Widget - TEXT
                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(41, 42, 41, 1),
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      height: 1.4545454545454546),
                ),
                const SizedBox(
                  height: 20,
                ),
                const // Figma Flutter Generator BodyWidget - TEXT
                Text(
                  'Please sign up or login with Google or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(119, 119, 157, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.7142857142857142),
                ),
                const Text(
                  'Facebook account..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(119, 119, 157, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.7142857142857142),
                ),
                const SizedBox(height: 80),
                // Figma Flutter Generator Buttonv1Widget - FRAME - HORIZONTAL
                Container(
                  height: 55,
                  width: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(120),
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                    color: Color.fromRGBO(23, 191, 95, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 40),
                      Image.asset(
                        'assets/google.png',
                        height: 25,
                        width: 25,
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          GoogleSignInOrSignUp();
                        },
                        child: const Text(
                          'Sign Up with Google',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.5 /*PERCENT not supported*/
                              ),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  height: 55,
                  width: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(120),
                      topRight: Radius.circular(120),
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                    color: Color.fromRGBO(23, 191, 95, 1),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 40),
                      Image.asset(
                        'assets/AppleLogo.png',
                        height: 35,
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Sign Up with Apple',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Inter',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1.5 /*PERCENT not supported*/
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 220),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (Context) =>  BottomNav()));
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
                                  color: Color.fromRGBO(255, 255, 255, 1),
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
                                  color: Color.fromRGBO(255, 255, 255, 1),
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
        ),
      ),
    );
  }
}
