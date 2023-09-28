import 'package:community/log_in.dart';
import 'package:community/report.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  final picker = ImagePicker();
  List<String> imagePaths = List.generate(3, (_) => "");

  Future<void> _pickImage(int index) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        imagePaths[index] = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Demo'),
      ),
      body: Column(
        children: <Widget>[
          for (int i = 0; i < 3; i++)
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Image ${i + 1}'),
              subtitle:
                  Text(imagePaths[i].isEmpty ? 'Not Selected' : imagePaths[i]),
              onTap: () => _pickImage(i),
            ),
          ElevatedButton(
            onPressed: () {
              // Upload the images to your server using imagePaths list
              for (int i = 0; i < imagePaths.length; i++) {
                if (imagePaths[i].isNotEmpty) {
                  // Upload imagePaths[i] to your server here
                  print('Uploading image $i: ${imagePaths[i]}');
                }
              }
            },
            child: Text('Upload Images'),
          ),
        ],
      ),
    );
  }
}

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Log_In(),
  ));
}
