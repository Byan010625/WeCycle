import 'package:flutter/material.dart';
import 'Login/intro.dart';
import 'Login/signup.dart';
import 'Login/signin.dart';
import 'package:camera/camera.dart';
import 'package:wecycle/CameraManager/cameramanager.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'globals.dart' as globals;

class WeCycleApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainState();
  }
}

class _MainState extends State<WeCycleApp> {
  @override
  void initState() {
    super.initState();
    globals.blueCircle = new Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
            center: Alignment.bottomRight,
            radius: 1,
            colors: [Color(0xFF00D8F8), Color(0xFF00A8FE), Color(0XFF0086FE)],
            stops: [0, 0.5, 1]
        )
      ),
    );
    globals.tealCircle = new Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1,
              colors: [Color(0xFF00D4FD), Color(0xFF00E7E8), Color(0XFF00FBD3)],
              stops: [0, 0.7, 1]
          )
      ),
    );
  }

  @override
  void didChangeDependencies() {
      super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Intro(),
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
