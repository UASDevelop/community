import 'dart:convert';
import 'dart:io';
import 'package:community/Api/CustomApi.dart';
import 'package:community/report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'Bottomnavigaton/BottomNavigation.dart';
import 'dialog_boxes/new_report.dart';
import 'home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List communityData = [];
  XFile? _image;
  Future<void> _fetchData() async {
    try {
      var response = await http.get(
        Uri.parse("${CustomApi.baseUrl}${CustomApi.allcommunity_end_point}"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print("bodyData${responseData}");
        if (responseData.containsKey('success') &&
            responseData['success'] == true &&
            responseData.containsKey('users') &&
            responseData['users'] is List) {
          List<dynamic> users = responseData['users'];

          for (var user in users) {
            String name = user['name'];
            String city = user['city'];
            String zipCode = user['zipCode'];
            String state = user['state'];
            String image = user["communityImage"];
            String id = user["_id"];
            setState(() {
              Map<String, dynamic> item = {
                'name': name,
                'city': city,
                'zipCode': zipCode,
                'state': state,
                "image": image,
                "id": id,
              };
              communityData.add(item);
            });
            print(
                "Name: $name, City: $city, Zip Code: $zipCode, State: $state, Image: $image,CommunityID:$id");
            // Here, you can use the data as needed, such as displaying it in your UI
          }
        } else {
          print("Data is not in the expected format or 'success' is not true");
        }
      } else {
        // Handle the error, e.g., show an error message
        print('Failed to fetch data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
  }

  List<int> SelectedIndex = [];
  @override
  void initState() {
    setState(() {
      _fetchData();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Figma Flutter Generator H3Widget - TEXT
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Communities',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(41, 42, 41, 1),
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      height: 1.4545454545454546),
                ),
                Text(
                  'Pick a community',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(119, 119, 157, 1),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1.7142857142857142),
                ),
                SizedBox(height: 25),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(20),
                    itemCount: communityData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final userindex = communityData[index];
                      String imageUrl = "${userindex["image"]}";

                      return InkWell(
                        onTap: () {
                          // setState(() {
                          //   if (SelectedIndex.contains(index)) {
                          //     SelectedIndex.remove(index);
                          //   } else {
                          //     SelectedIndex.add(index);
                          //   }
                          // });
                          NewReport(context, userindex["id"]);
                          print(userindex["id"]);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 311,
                          height: 240,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network("${CustomApi.baseUrl}/${imageUrl}"),
                              Text(
                                userindex["name"],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(41, 42, 41, 1),
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1.5),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(242, 242, 242, 1),
                            border: Border.all(
                              color: SelectedIndex.contains(index)
                                  ? Colors.white
                                  : Color.fromRGBO(23, 191, 95, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => BottomNav()));
                //   },
                //   child: Container(
                //     height: 45,
                //     decoration: BoxDecoration(
                //       color: Color.fromRGBO(23, 191, 95, 1),
                //       borderRadius: BorderRadius.circular(20),
                //       border: Border.all(
                //         color: Color.fromRGBO(23, 191, 95, 1),
                //         width: 2,
                //       ),
                //     ),
                //     width: MediaQuery.of(context).size.width / 1.5,
                //     child: Center(
                //       child: Text(
                //         "Next",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontFamily: 'Poppins',
                //             fontSize: 16,
                //             letterSpacing: 0,
                //             fontWeight: FontWeight.normal,
                //             height: 1.5),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
