import 'package:flutter/material.dart';
import 'Login/intro.dart';
import 'Login/signup.dart';
import 'Login/signin.dart';
import 'package:camera/camera.dart';
import 'CameraManager/cameramanager.dart';

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