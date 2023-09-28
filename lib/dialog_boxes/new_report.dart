import 'dart:io';
import 'package:community/Api/CustomApi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReportDialog extends StatefulWidget {
  String communityID;
  ReportDialog({required this.communityID});
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  List<XFile?> _imageFiles = List.generate(3, (index) => null);

  Future<void> _getImage(int imageIndex) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final imageFile =
      await imagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        setState(() {
          _imageFiles[imageIndex - 1] = imageFile;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _reportTitle = TextEditingController();

  Future<void> _uploadImages(List<XFile?> imageFiles) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    print("UserID: $userId");
    try {
      final Uri uploadUri = Uri.parse(
          "${CustomApi.baseUrl}${CustomApi.createreport_end_point}");
      final request = http.MultipartRequest('POST', uploadUri);

      for (int i = 0; i < imageFiles.length; i++) {
        final imageFile = imageFiles[i];
        if (imageFile != null) {
          request.files.add(
            await http.MultipartFile.fromPath("image${i + 1}", imageFile.path),
          );
        }
      }

      request.fields['reportDiscription'] = _descriptioncontroller.text; // Add description field
      request.fields["community"] = widget.communityID;
      request.fields["reportTitle"] = _reportTitle.text;
      request.fields["user"] =userId!;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Successful upload
        print("Images uploaded successfully.");
      } else {
        // Handle the error
        print("Image upload failed with status code: ${response.body}");
      }
    } catch (e) {
      print("Error uploading images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 35, left: 80),
      contentPadding: const EdgeInsets.only(left: 20),
      insetPadding: const EdgeInsets.only(left: 20, right: 20, top: 150),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Color(0xffFFFFFF),
      title: Padding(
        padding: const EdgeInsets.only(left: 180),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Color(0xff535254),
            size: 25,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              alignment: AlignmentDirectional.topStart,
              height: 17,
              child: const Text(
                'Upload pictures',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(35, 73, 107, 1), fontSize: 12),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: AlignmentDirectional.topStart,
              color: const Color.fromRGBO(250, 250, 250, 1),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _reportTitle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Report Title',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.512454986572266,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      height: 1.1428571687767188,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 292.999755859375,
              height: 69.93535614013672,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _getImage(1);
                    },
                    child: Container(
                      width: 90.95872497558594,
                      height: 69.93535614013672,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(246, 246, 248, 1),
                      ),
                      child: Center(
                        child: _imageFiles[0] == null
                            ? Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        )
                            : Image.file(
                          File(_imageFiles[0]!.path),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _getImage(2);
                    },
                    child: Container(
                      width: 90.95872497558594,
                      height: 69.93535614013672,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(246, 246, 248, 200),
                      ),
                      child: Center(
                        child: _imageFiles[1] == null
                            ? Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        )
                            : Image.file(
                          File(_imageFiles[1]!.path),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _getImage(3);
                    },
                    child: Container(
                      width: 90.95872497558594,
                      height: 69.93535614013672,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(246, 246, 248, 1),
                      ),
                      child: Center(
                        child: _imageFiles[2] == null
                            ? Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        )
                            : Image.file(
                          File(_imageFiles[2]!.path),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Add more image containers here as needed
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 20),
              alignment: AlignmentDirectional.topStart,
              height: 17,
              child: const Text(
                'Description',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: AlignmentDirectional.topStart,
              color: const Color.fromRGBO(250, 250, 250, 1),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _descriptioncontroller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Descripe Report',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10.512454986572266,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      height: 1.1428571687767188,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _uploadImages(_imageFiles);
                print(widget.communityID);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 17, right: 10),
                width: 310,
                height: 50,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 268,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromRGBO(40, 174, 97, 1),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1.7142857142857142,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

void NewReport(BuildContext context, String CommunityID) {
  showDialog(
    context: context,
    builder: (ctx) {
      return ReportDialog(communityID: CommunityID);
    },
  );
}
