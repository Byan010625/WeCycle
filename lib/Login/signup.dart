import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show Platform;
import 'dart:io';
import 'package:wecycle/CameraManager/cameramanager.dart';
import 'package:wecycle/globals.dart' as globals;

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  AnimationController _slideCirclesController;
  AnimationController _slideBoxController;
  AnimationController _slideProfileBoxController;
  AnimationController _textInAnimationController;
  AnimationController _textOutAnimationController;
  AnimationController _fadeInBoxController;
  AnimationController _firstTextInContoller;

  Animation<Offset> _slideBlueCircleAnimation;
  Animation<Offset> _slideTealCircleAnimation;
  Animation<Offset> _slideBoxOffsetAnimation;
  Animation<Offset> _slideProfileBoxAnimation;
  Animation<double> _textOutAnimation;
  Animation<double> _textInAnimation;
  Animation<double> _fadeInBoxAnimation;
  Animation<double> _firstTextInAnimation;

  DoubleLinkedQueue<Widget> infoBoxes;
  int keyInQueue;

  File _profileImage;

  @override
  void initState() {
    super.initState();
    infoBoxes = new DoubleLinkedQueue();
    keyInQueue = 0;

    _slideCirclesController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _slideBoxController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideBoxController.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        setState(() {
          this.keyInQueue = 1;
          _slideProfileBoxController
              .forward(); //Assumes that the user went through the first info box
          _textInAnimationController.forward();
        });
      }
    });
    _slideBlueCircleAnimation = Tween<Offset>(
      begin: Offset(1.0, 0),
      end: Offset.zero,
    ).animate(_slideCirclesController);
    _slideTealCircleAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0),
      end: Offset.zero,
    ).animate(_slideCirclesController);
    _slideBoxOffsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideBoxController,
      curve: Curves.elasticInOut,
    ));
    _textInAnimationController = AnimationController(
        duration: const Duration(
          seconds: 1,
        ),
        vsync: this);
    _textOutAnimationController = AnimationController(
        duration: const Duration(
          seconds: 1,
        ),
        vsync: this);
    _textOutAnimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_textOutAnimationController);
    _textInAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_textInAnimationController);
    _slideProfileBoxController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _slideProfileBoxAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideProfileBoxController,
      curve: Curves.elasticInOut,
    ));

    _fadeInBoxController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _firstTextInContoller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _fadeInBoxAnimation = Tween(
        begin: 0.0,
        end: 1.0).animate(_fadeInBoxController);
    _firstTextInAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_firstTextInContoller);

    _slideCirclesController.forward().then((state) {
      _firstTextInContoller.forward().then((state) {
        _fadeInBoxController.forward();
      });
    });
    _slideBoxController.stop(canceled: false);
    _slideProfileBoxController.stop(canceled: false);
  }

  @override
  void dispose() {
    super.dispose();
    _textOutAnimationController.dispose();
    _textInAnimationController.dispose();
    _slideBoxController.dispose();
    _slideProfileBoxController.dispose();
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/Blue_Circle.png"), context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    infoBoxes.add(signInfoBox(context));
    infoBoxes.add(profileInfoBox(context));

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -250,
                right: -170,
                height: 600,
                width: 600,
                child: SlideTransition(
                  position: _slideBlueCircleAnimation,
                  child: globals.blueCircle,
                )),
            Positioned(
                bottom: -400,
                right: -15,
                height: 600,
                width: 600,
                child: SlideTransition(
                  position: _slideTealCircleAnimation,
                  child: globals.tealCircle,
                )),
            Positioned(
              left: 10,
              top: 45,
              width: 40,
              height: 60,
              child: GestureDetector(
                onTap: () {
                  if (keyInQueue == 1) {
                    _slideProfileBoxController.reverse().then((state) {
                      setState(() {
                        keyInQueue = 0;
                        _slideBoxController.reverse();
                        _textOutAnimationController.reverse();
                      });
                    });
                    _textInAnimationController.reverse();
                  } else if (keyInQueue == 0) {
                    Navigator.pop(context);
                  }
                },
                child: Platform.isAndroid
                    ? Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 40,
                      )
                    : Icon(Icons.arrow_back_ios, color: Colors.white, size: 40),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FadeTransition(
                  opacity: _firstTextInAnimation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 150, 20, 10),
                    child: getCurrentText(),
                  ),
                ),
                FadeTransition(
                  opacity: _fadeInBoxAnimation,
                  child: getCurrentInfoBox(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getCurrentText() {
    if (keyInQueue == 0) {
      return FadeTransition(
        opacity: _textOutAnimation,
        child: Text("Lets get started.",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Segoe',
                fontWeight: FontWeight.w600,
                fontSize: 40)),
      );
    } else {
      //keyInQueue = 1
      return FadeTransition(
        opacity: _textInAnimation,
        child: Text("Lets get to know you.",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Segoe',
                fontWeight: FontWeight.w600,
                fontSize: 35)),
      );
    }
  }

  Widget getCurrentInfoBox() {
    return keyInQueue == 0
        ? SlideTransition(
            position: _slideBoxOffsetAnimation,
            child: infoBoxes.firstEntry().element)
        : SlideTransition(
            position: _slideProfileBoxAnimation,
            child: infoBoxes.firstEntry().nextEntry().element);
  }

  Widget profileInfoBox(BuildContext context) {
    double infoBoxWidth = MediaQuery.of(context).size.width - 40;
    double infoBoxHeight = MediaQuery.of(context).size.height - 300;

    return Stack(
      children: <Widget>[
        Container(
          width: infoBoxWidth,
          height: infoBoxHeight,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.55),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Text("So that your friends can find you.",
                  style: TextStyle(
                      color: Color(0xFFA7A7A7),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 275, 0),
              child: Text("Profile",
                  style: TextStyle(
                      color: Color(0xFF85C0B9),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                child: GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: 115,
                    height: 115,
                    child: _profileImage != null
                        ? null
                        : Row(
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
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage), fit: BoxFit.fill)
                          : null,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 275, 0),
              child: Text("Name",
                  style: TextStyle(
                      color: Color(0xFF85C0B9),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
              child: TextField(
                  decoration: InputDecoration(
                      hintText: "Ex. Jane Doe",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF85C0B9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF85C0B9))))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(300, 170, 10, 10),
              child: FlatButton(
                onPressed: () {
                  //TODO: ADD AUTHENTICATION AND FIREBASE SUPPORT
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CameraManager()),
                  );
                },
                color: Color(0xFF00FE9C),
                padding: const EdgeInsets.all(0),
                shape: CircleBorder(side: BorderSide(color: Color(0xFF00FE9C))),
                child: Container(
                  width: 30,
                  height: 50,
                  child: Platform.isAndroid
                      ? Icon(Icons.arrow_forward, color: Colors.white, size: 30)
                      : Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 30),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget signInfoBox(BuildContext context) {
    double infoBoxWidth = MediaQuery.of(context).size.width - 40;
    double infoBoxHeight = MediaQuery.of(context).size.height - 300;
    return Stack(
      children: <Widget>[
        Container(
          width: infoBoxWidth,
          height: infoBoxHeight,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.55),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 65, 275, 0),
              child: Text("Email",
                  style: TextStyle(
                      color: Color(0xFF85C0B9),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
              child: TextField(
                  decoration: InputDecoration(
                      hintText: "Ex. youremail@gmail.com",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF85C0B9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF85C0B9))))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 250, 0),
              child: Text("Password",
                  style: TextStyle(
                      color: Color(0xFF85C0B9),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF85C0B9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF85C0B9))))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 200, 0),
              child: Text("Confirm password",
                  style: TextStyle(
                      color: Color(0xFF85C0B9),
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
              child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF85C0B9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF85C0B9))))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(300, 150, 10, 10),
              child: FlatButton(
                onPressed: () {
                  _slideBoxController.forward();
                  _textOutAnimationController.forward();
                },
                color: Color(0xFF00FE9C),
                padding: const EdgeInsets.all(0),
                shape: CircleBorder(side: BorderSide(color: Color(0xFF00FE9C))),
                child: Container(
                  width: 30,
                  height: 50,
                  child: Platform.isAndroid
                      ? Icon(Icons.arrow_forward, color: Colors.white, size: 30)
                      : Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 30),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
