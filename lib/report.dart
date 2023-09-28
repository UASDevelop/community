import 'dart:convert';

import 'package:community/Api/CustomApi.dart';
import 'package:community/profile.dart';
import 'package:community/ReportResult.dart';
import 'package:community/extrac.dart';
import 'package:community/report3_new.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ModelsClass/ModelClass.dart';
import 'dialog_boxes/new_report.dart';
import 'dialog_boxes/report_feedback.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  List<String> _title = ["Unresolved", "Resolved", "New"];
  List<ReportData> reportsData = [];
  bool isloading = false;
  Future<void> _fetchAllReports() async {
    try {
      var response = await http.get(
        Uri.parse("${CustomApi.baseUrl}${CustomApi.allreport_end_point}"),
        headers: {'Content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
       setState(() {
         isloading = true;
       });
        List<dynamic> reports = responseData['reports'];
        reports.forEach((element) {
          var setReport = ReportData(
            id: element["_id"],
            reportTitle: element["reportTitle"],
            reportDescription: element["reportDiscription"],
            community: element["community"],
            image1: element['image1'],
            image2: element['image2'],
            image3: element['image3'],
            status: element['status'],
            user: element["user"]["username"],
          );
          reportsData.addAll({setReport});
        });
      } else if (response.statusCode == 401) {
        // Handle unauthorized access
        print("Unauthorized access");
      } else {
        // Handle other status codes
        print("Failed to fetch data: ${response.statusCode}");
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print("An error occurred: $e");
    }
  }
  var userId;
Future<void> _UserID()async{
 try{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   userId = prefs.getString('userId');
   print("UserID: $userId");
 }catch(e){
   print(e);
 }
}
  @override
  initState() {
    _UserID();
    _fetchAllReports();
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isloading == false
              ? CircularProgressIndicator()
              : Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Reports',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromRGBO(41, 42, 41, 1),
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                              height: 1.4545454545454546,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: reportsData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildReportItem(
                              title: reportsData[index].reportTitle,
                              description: reportsData[index].reportDescription,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportResult(
                                      image1: reportsData[index].image1,
                                      image2: reportsData[index].image2,
                                      image3: reportsData[index].image3,
                                      status: reportsData[index].status,
                                      descrittion:
                                          reportsData[index].reportDescription,
                                      reportID:reportsData[index].id, userID:userId,
                                    ),
                                  ),
                                );
                              },
                              status: reportsData[index].status,
                            );
                          },
                        ),
                        SizedBox(height: 70),
                        // GestureDetector(
                        //   onTap: () {
                        //     NewReport(context);
                        //   },
                        //   child: Container(
                        //     width: 268,
                        //     height: 50,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(14),
                        //       color: Color.fromRGBO(40, 174, 97, 1),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         'Report Issue',
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontFamily: 'Poppins',
                        //           fontSize: 14,
                        //           letterSpacing: 0,
                        //           fontWeight: FontWeight.normal,
                        //           height: 1.7142857142857142,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildReportItem({
    required String title,
    required String status,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: 311,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(242, 242, 242, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap:(){
               if( status.contains("resolved")){
                 // ReportFeedback(context,userId,);
               }
              },
              child:Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: status.contains("resolved")
                        ? Color.fromRGBO(23, 191, 95, 1)
                        : Color.fromRGBO(209, 26, 42, 1),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              child: Text(
                description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'see more',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xff0057FF),
                  fontFamily: 'Nunito',
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
