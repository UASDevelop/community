import 'package:community/Api/CustomApi.dart';
import 'package:community/profile.dart';
import 'package:community/report.dart';
import 'package:flutter/material.dart';
import 'dialog_boxes/new_report.dart';
import 'dialog_boxes/report_feedback.dart';
import 'home.dart';

class ReportResult extends StatefulWidget {
  String image1, image2, image3, status, descrittion,reportID,userID;
  ReportResult(
      {required this.image1,
      required this.image2,
      required this.image3,
      required this.status,
      required this.descrittion,
      required this.reportID,
        required this.userID,
      });
  @override
  State<ReportResult> createState() => _ReportResultState();
}

class _ReportResultState extends State<ReportResult> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Reports',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(41, 42, 41, 1),
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        height: 1.4545454545454546),
                  ),
                  const SizedBox(height: 20),
                  Container(
                      width: 311,
                      height: 450,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                                width: 311,
                                height: 450,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                          width: 311,
                                          height: 450,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            color: Color.fromRGBO(
                                                242, 242, 242, 1),
                                            // border : Border.all(
                                            // color: Color.fromRGBO(23, 191, 95, 1),
                                            //   width: 2,
                                            // ),
                                          ))),
                                  Positioned(
                                    top: 412,
                                    left: 22,
                                    child: InkWell(
                                      onTap: () {
                                        widget.status == 'resolved'
                                            ? ReportFeedback(context,widget.userID,widget.reportID)
                                            : null;
                                      },
                                      child: Text(
                                        widget.status == 'resolved'
                                            ? "Resolved"
                                            : "Unresolved",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: widget.status == 'resolved'
                                                ? Colors.green
                                                : Color.fromRGBO(
                                                    209, 26, 42, 1),
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.w600,
                                            height: 1.5),
                                      ),
                                    ),
                                  )
                                ]))),
                        Positioned(
                            top: 18,
                            left: 18,
                            child: Container(
                                width: 114,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${CustomApi.baseUrl}/${widget.image1}"),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 18,
                            left: 137,
                            child: Container(
                                width: 114,
                                height: 64,
                                // child:Image.network('${CustomApi.baseUrl}/${widget.image2}'),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${CustomApi.baseUrl}/${widget.image2}"),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 87,
                            left: 100,
                            child: Container(
                                width: 114,
                                height: 64,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${CustomApi.baseUrl}/${widget.image3}"),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 166,
                            left: 21,
                            right: 22,
                            child: Text(
                              widget.descrittion,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.w400,
                                  height: 1.3),
                            )),
                      ])),
                  const SizedBox(height: 50),
                  // GestureDetector(
                  //   onTap: (){
                  //     NewReport(context);
                  //   },
                  //   child: Container(
                  //       width: 268,
                  //       height: 50,
                  //
                  //       child: Stack(
                  //           children: <Widget>[
                  //             Positioned(
                  //                 top: 0,
                  //                 left: 0,
                  //                 child: Container(
                  //                     width: 268,
                  //                     height: 50,
                  //                     decoration: BoxDecoration(
                  //                       color : Color.fromRGBO(255, 255, 255, 1),
                  //                     )
                  //                 )
                  //             ),Positioned(
                  //                 top: 0,
                  //                 left: 0,
                  //                 child: Container(
                  //                     width: 268,
                  //                     height: 50,
                  //                     decoration: const BoxDecoration(
                  //                       borderRadius : BorderRadius.only(
                  //                         topLeft: Radius.circular(14),
                  //                         topRight: Radius.circular(14),
                  //                         bottomLeft: Radius.circular(14),
                  //                         bottomRight: Radius.circular(14),
                  //                       ),
                  //                       color : Color.fromRGBO(40, 174, 97, 1),
                  //                     )
                  //                 )
                  //             ),const Positioned(
                  //                 top: 13,
                  //                 left: 93,
                  //                 child: Text('Report Issue', textAlign: TextAlign.center, style: TextStyle(
                  //                     color: Color.fromRGBO(255, 255, 255, 1),
                  //                     fontFamily: 'Poppins',
                  //                     fontSize: 14,
                  //                     letterSpacing: 0,
                  //                     fontWeight: FontWeight.normal,
                  //                     height: 1.7142857142857142
                  //                 ),)
                  //             ),
                  //           ]
                  //       )
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
}
