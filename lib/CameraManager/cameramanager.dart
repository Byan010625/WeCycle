import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:path_provider/path_provider.dart';

import 'CirclePainter.dart';
import 'package:wecycle/main.dart';
import 'button_icons_icons.dart' show ButtonIcons;

class CameraManager extends StatefulWidget {
  @override
  _CameraManagerState createState() {
    return _CameraManagerState();
  }
}

class _CameraManagerState extends State<CameraManager>
    with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  double controllerRatio;

  IconButton challengesButton;
  IconButton friendsButton;

  File _profileImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    challengesButton = new IconButton(
        icon: new Icon(
          ButtonIcons.ic_star_24px,
          color: Colors.white,
          size: 43,
        ),
        onPressed: () {});
    friendsButton = new IconButton(
        icon: new Icon(
          ButtonIcons.ic_people_24px,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () {});
    controller = CameraController(cameras[0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _cameraPreviewWidget(),
        snapButton(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  //Challenges button
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Container(
                    child: Image.asset("assets/images/ic_star.png"),
                    width: 43,
                    height: 43,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Text(
                    'Challenges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Segoe',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  //Friends button
                  padding: const EdgeInsets.fromLTRB(25, 20, 40, 5),
                  child: Container(
                    child: Image.asset("assets/images/ic_people.png"),
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 33, 20),
                  child: Text(
                    'Friends',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'Segoe',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 10, 20),
          //TODO: Need to change based on device
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF85C0B9), width: 2),
                  image: _profileImage != null
                      ? DecorationImage(
                          image: FileImage(_profileImage), fit: BoxFit.fill)
                      : null,
                ),
              ),
              Container(
                width: 110,
                height: 35,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Stack(children: <Widget>[
                  Container(
                    width: 50,
                    height: 25,
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          child: Text("123",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15)),
                          padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                        ),
                        Padding(
                          child: Image.asset(
                            "assets/images/AddButton.png",
                            height: 10,
                            width: 10,
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: new BorderRadius.circular(20),
                      color: Color(0xFF4A4949),
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      "assets/images/coin.png",
                      height: 25,
                      width: 25,
                    ),
                    right: 45,
                    bottom: 10,
                  ),
                ]),
              ),
            ],
          ),
        )
      ],
    ));
  }

  Widget _cameraPreviewWidget() {
    if (controller != null && controller.value.isInitialized) {
      final size = MediaQuery.of(context).size;
      final deviceRatio = size.width / size.height;
      controllerRatio = controller.value.aspectRatio;
      return Transform.scale(
        scale: controllerRatio / deviceRatio,
        child: Center(
          child: AspectRatio(
            aspectRatio: controllerRatio,
            child: CameraPreview(controller),
          ),
        ),
      );
    } else {
      return const Text(
        'Camera not on',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }
  }

  Widget snapButton() {
    Alignment alignmentConfig =
        new Alignment(Alignment.bottomCenter.x, Alignment.bottomCenter.y - .25);
    return Align(
      alignment: alignmentConfig,
      child: RawMaterialButton(
        onPressed: onSnapButtonPressed,
        shape: CircleBorder().scale(2.0),
        child: CustomPaint(
          painter: CirclePainter(
              color: Colors.white,
              strokeWidth: 5,
              isAntialias: true,
              paintingStyle: PaintingStyle.stroke),
        ),
      ),
    );
  }

  void onSnapButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          log(imagePath);
          //controller?.dispose();
          //controller = null;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayImageToScreen(
                  imagePath: imagePath,
                  controllerRatio: controllerRatio,
                ),
              ));
        });
        if (filePath != null) {}
        //showInSnackBar('Picture saved to $filePath');
      }
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      //showInSnackBar('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      //_showCameraException(e);
      return null;
    }
    return filePath;
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Widget profileButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CircleAvatar(
          backgroundImage: AssetImage("avatar.png"),
          radius: 20,
        ),
      ),
    );
  }
}

class DisplayImageToScreen extends StatefulWidget {
  static const platform = const MethodChannel('com.teamblnd.wecycle/imgclassif');
  final String imagePath;
  final double controllerRatio;

  const DisplayImageToScreen({Key key, this.imagePath, this.controllerRatio})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DisplayedImageScreen();
  }
}

class DisplayedImageScreen extends State<DisplayImageToScreen> {
  String imagePath;
  double controllerRatio;

  @override
  void initState() {
    imagePath = widget.imagePath;
    controllerRatio = widget.controllerRatio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        imageScreen(),
        predictButton(),
      ],
    ));
  }

  Widget imageScreen() {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Transform.scale(
      scale: controllerRatio / deviceRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: controllerRatio,
          child: Image.file(new File(imagePath)),
        ),
      ),
    );
  }

  Widget predictButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(new Radius.circular(10))),
            child: Text("Scan!"),
            onPressed: onPredictButtonPressed,
          ),
        ));
  }

  void onPredictButtonPressed() {
    isRecyclableObject(this.imagePath).then((bool value) {
      if(value){
        setState(() {
          //Show custom alert box
          showWin();
          //Update coins
        });
      }
    });
  }

  void showWin() {
    showDialog(
        context: context,
        builder: (_) => AssetGiffyDialog(
              image: new Image.asset(
                'assets/animations/checkmark-animation.gif',
                fit: BoxFit.cover,
              ),
              title: Text(
                'You earn 3 coins!',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                'Good job! Keep recycling!',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),
              entryAnimation: EntryAnimation.TOP,
              onOkButtonPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              onlyOkButton: true,
            ));
  }

  Future<bool> isRecyclableObject(String imagePath) async {
    bool isRecyclable = false;
    try {
      isRecyclable = await DisplayImageToScreen.platform
          .invokeMethod('getClassificationResult', imagePath);
    } on PlatformException catch (e) {
      log("Failed!: " + e.message);
    }
    return isRecyclable;
  }
}
