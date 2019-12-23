import 'package:flutter/material.dart';
import 'Login/intro.dart';
import 'Login/signup.dart';
import 'Login/signin.dart';
import 'package:camera/camera.dart';
import 'CameraManager/cameramanager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WeCycleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

//Taken from WeCycleCameraPreview

List<CameraDescription> cameras;

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(WeCycleApp());
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _profileImage;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: GestureDetector(
        onTap: () {
          getImage();
        },
        child: Container(
          width: 110,
          height: 110,
          child: _profileImage != null ? null : Row(
            children: <Widget>[
              Icon(
                Icons.add,
                color: Color(0xFF85C0B9),
                size: 15,
              ),
              Text("Add a picture",
                  style: TextStyle(
                      color: Color(0xFF85C0B9),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ],
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFF85C0B9), width: 2),
            image: _profileImage != null ? DecorationImage(image: FileImage(_profileImage), fit: BoxFit.fill) : null,
          ),
        ),
      )
    );
  }
}
