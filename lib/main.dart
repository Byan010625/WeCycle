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
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0085FF), Color(0xFF00A8FE), Color(0XFF00D8FD)],
            stops: [0, 0.65, 1]
        )
      ),
    );
    globals.tealCircle = new Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00D4FD), Color(0xFF00C7FD), Color(0XFF00A8FE)],
              stops: [0, 0.85, 1]
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
      home: CameraManager(),
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
