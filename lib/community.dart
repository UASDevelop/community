import 'dart:convert';
import 'package:community/Api/CustomApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Bottomnavigaton/BottomNavigation.dart';
import 'home.dart';

class Community extends StatefulWidget {
  String name, email, password, profileimag, phoneNo, address;
  Community(
      {required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.phoneNo,
      required this.profileimag});
  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List communityData = [];
  Future<void> _fetchData() async {
    try {
      var response = await http.get(
        Uri.parse("${CustomApi.baseUrl}${CustomApi.allcommunity_end_point}"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
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
                "Name: $name, City: $city, Zip Code: $zipCode, State: $state, Image: $image");
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
  List<Map<String, dynamic>> selectedCommunities = [];

  @override
  void initState() {
    setState(() {
      _fetchData();
    });
    // TODO: implement initState
    super.initState();
  }

  // Function to handle the "Next" button tap
  void handleNextButtonTap() {
    selectedCommunities.clear(); // Clear the selected communities list
    for (int index in SelectedIndex) {
      selectedCommunities.add(communityData[index]);
    }

    // Print the selected data
    for (var community in selectedCommunities) {
      print("CommunityID: ${community["id"]}");
      // print("Selected Community City: ${community['city']}");
      // Add more fields as needed
    }
  }

  Future<http.Response> sendUserDataToApi() async {
    final response = await http.post(
      Uri.parse("${CustomApi.baseUrl}${CustomApi.signup_end_point}"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': widget.name,
        'email': widget.email,
        'password': widget.password,
        "profileImage": widget.profileimag,
        "phoneNumber": widget.phoneNo,
        "address": widget.address,
        // "communities": selectedCommunities,
      }),
    );
    print(widget.name);
    Map<String, dynamic> parsedResponse = json.decode(response.body);

// Access the user ID
    String userId = parsedResponse['user']['_id'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.setString('userId', userId);
    if (response.statusCode == 200) {
      // If the status code is 200 (OK), the request was successful.
      // You can navigate to the 'Community' screen or perform other actions here.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      );
    } else if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      );
    } else if (response.statusCode == 400) {
      // Handle a 400 (Bad Request) error here. Example:
      // Show an error message to the user.
      print(response.body);
      print("Bad Request: Invalid data sent to the server.");
    } else if (response.statusCode == 401) {
      // Handle a 401 (Unauthorized) error here. Example:
      // Redirect the user to the login screen.
      print("Unauthorized: User not authenticated.");
    } else {
      // Handle other status codes as needed.
      print("HTTP Status Code: ${response.statusCode}");
    }
    return response;
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
                    shrinkWrap: true,
                    // padding: EdgeInsets.all(20),
                    itemCount: communityData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final userindex = communityData[index];
                      String imageUrl = userindex["image"];

                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (SelectedIndex.contains(index)) {
                              SelectedIndex.remove(index);
                            } else {
                              SelectedIndex.add(index);
                            }
                          });
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
                                  ? Color.fromRGBO(23, 191, 95, 1)
                                  : Colors.white,
                              width: 4,
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
                InkWell(
                  onTap: () {
                    // print(widget.name);
                    handleNextButtonTap(); // Call the function to print selected data
                    sendUserDataToApi();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(23, 191, 95, 1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color.fromRGBO(23, 191, 95, 1),
                        width: 2,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1.5),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
