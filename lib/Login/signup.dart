import 'package:flutter/material.dart';
import 'dart:collection';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUpPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  AnimationController _slideboxcontroller;
  AnimationController _slideprofileboxcontroller;
  AnimationController _textinanimationcontroller;
  AnimationController _textoutanimationcontroller;

  Animation<Offset> _slideboxoffsetanimation;
  Animation<Offset> _slideprofileboxanimation;
  Animation<double> _textoutanimation;
  Animation<double> _textinanimation;

  DoubleLinkedQueue<Widget> infoBoxes;
  int keyInQueue;


  @override
  void initState() {
    super.initState();
    infoBoxes = new DoubleLinkedQueue();
    keyInQueue = 0;
    _slideboxcontroller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideboxcontroller.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        setState(() {
          this.keyInQueue = 1;
          _slideprofileboxcontroller.forward(); //Assumes that the user went through the first info box
          _textinanimationcontroller.forward();
        });
      }
    });
    _slideboxoffsetanimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _slideboxcontroller,
      curve: Curves.elasticInOut,
    ));
    _textinanimationcontroller = AnimationController(
        duration: const Duration(seconds: 1,),
        vsync: this
    );
    _textoutanimationcontroller = AnimationController(
        duration: const Duration(seconds: 1,),
        vsync: this
    );
    _textoutanimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_textoutanimationcontroller);
    _textinanimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_textinanimationcontroller);
    _slideprofileboxcontroller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this
    );
    _slideprofileboxanimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideprofileboxcontroller,
      curve: Curves.bounceIn,
    ));
    _slideboxcontroller.stop(canceled: false);
    _slideprofileboxcontroller.stop(canceled: false);
  }

  @override
  void dispose() {
    super.dispose();
    _slideboxcontroller.dispose();
    _slideprofileboxcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/Blue_Circle.png"), context);
    Image blueCircle = new Image.asset("assets/images/Blue_Circle.png");
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

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
              child: blueCircle,
            ),
            Positioned(
              bottom: -400,
              right: -15,
              height: 600,
              width: 600,
              child: Image.asset("assets/images/Teal_Circle.png"),
            ),
            Positioned(
              left: 10,
              top: 45,
              width: 40,
              height: 60,
              child: Image.asset("assets/images/leftkeyboardarrow.png"),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 150, 20, 10),
                  child: getCurrentText(),
                ),
                getCurrentInfoBox(),
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
          opacity: _textoutanimation,
          child: Text("Lets get started.",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Segoe',
                  fontWeight: FontWeight.w600,
                  fontSize: 40)),
      );
    } else { //keyInQueue = 1
      return FadeTransition(
        opacity: _textinanimation,
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
    return keyInQueue == 0 ? SlideTransition(
        position: _slideboxoffsetanimation,
        child: infoBoxes
            .firstEntry()
            .element) :
    SlideTransition(
        position: _slideprofileboxanimation,
        child: infoBoxes
            .firstEntry()
            .nextEntry()
            .element);
  }

  Widget profileInfoBox(BuildContext context) {
    double infoBoxWidth = MediaQuery
        .of(context)
        .size
        .width - 40;
    double infoBoxHeight = MediaQuery
        .of(context)
        .size
        .height - 300;
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
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF85C0B9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF85C0B9))))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 250, 0),
              child: Text("Phone Number",
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

                },
                color: Color(0xFF00FE9C),
                padding: const EdgeInsets.all(0),
                shape: CircleBorder(side: BorderSide(color: Color(0xFF00FE9C))),
                child: Container(
                  width: 30,
                  height: 50,
                  child: Image.asset("assets/images/rightkeyboardarrow.png"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget signInfoBox(BuildContext context) {
    double infoBoxWidth = MediaQuery
        .of(context)
        .size
        .width - 40;
    double infoBoxHeight = MediaQuery
        .of(context)
        .size
        .height - 300;
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
                  _slideboxcontroller.forward();
                  _textoutanimationcontroller.forward();
                },
                color: Color(0xFF00FE9C),
                padding: const EdgeInsets.all(0),
                shape: CircleBorder(side: BorderSide(color: Color(0xFF00FE9C))),
                child: Container(
                  width: 30,
                  height: 50,
                  child: Image.asset("assets/images/rightkeyboardarrow.png"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

